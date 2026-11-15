local t=0
local scheduled={}
local sent={}
local messages={}
local hp={Health=1000,MaxHealth=1000}
local attrs={}
local char={GetAttribute=function(_,key) return attrs[key] end,FindFirstChildOfClass=function() return hp end}
local player={Character=char}
local workspace={GetServerTimeNow=function() return t end}
local task={delay=function(_,callback) table.insert(scheduled,callback) end}
local os={clock=function() return t end}
local remote={FireServer=function(_,name) table.insert(sent,name) end}
local bh={Health=5000,MaxHealth=5000}
local boss={Parent=true,Name="Wuyan",FindFirstChildOfClass=function() return bh end}
local MURIM_HD={enabled=true,inside=true,profile={actDodge=true},bossNow=boss,
    log=function(_,message) table.insert(messages,message) end,combatRemote=function() return remote end}
local MURIM_GH={acts={},delay={},twice={},noFlee={FormationSeal=true}}
local Vec={}
local mt={__index=function(v,k) if k=="Magnitude" then return math.sqrt(v.X*v.X+v.Y*v.Y+v.Z*v.Z) end end,
    __sub=function(a,b) return Vec.new(a.X-b.X,a.Y-b.Y,a.Z-b.Z) end}
function Vec.new(x,y,z) return setmetatable({X=x,Y=y,Z=z},mt) end
MURIM_HD.fmt=function(v) return v and string.format("(%.0f,%.0f,%.0f)",v.X,v.Y,v.Z) or "nil" end
MURIM_HD.posOf=function() return Vec.new(0,0,0) end
-- MODULE_INSERT
local function check(value,message) assert(value,message) end
local function reset()
    MURIM_GH.auditReset("test reset");sent={};scheduled={};messages={}
    hp.Health=1000;attrs={};MURIM_HD.enabled=true;MURIM_HD.inside=true;MURIM_HD.bossNow=boss;t=0
end
local function plan(id,at,second)
    MURIM_GH.planParry("FormationSeal",at,{id=id,boss=boss},second)
end
plan("1",1,2)
plan("2",1.05)
check(#MURIM_GH.parryQueue==3,"overlapping attacks and second hit must all survive")
plan("1",1,2)
check(#MURIM_GH.parryQueue==3,"duplicate event must not enqueue again")
check(MURIM_GH.ownParry("FormationSeal"),"pending event owns its parry")
t=0.88;MURIM_GH.parryStep(t,char,hp)
check(#sent==1 and sent[1]=="ParryDown","first defense sent")
t=0.94;MURIM_GH.parryStep(t,char,hp)
check(#sent==1,"overlap must not send a second Down during hold")
t=1.11;MURIM_GH.parryStep(t,char,hp)
check(sent[2]=="ParryUp" and sent[3]=="ParryDown","ordered release then next due defense")
t=2.88;MURIM_GH.parryStep(t,char,hp)
check(sent[#sent]=="ParryDown","second impact still scheduled")
reset();plan("cooldown",1)
attrs.ParryReadyAt=5;t=0.9;MURIM_GH.parryStep(t,char,hp)
check(#sent==0,"known cooldown prevents premature send")
t=1.2;MURIM_GH.parryStep(t,char,hp)
check(#sent==0 and MURIM_GH.parryQueue[1].status:find("janela perdida"),"expired window logged without stale attack")
check(not MURIM_GH.ownParry("FormationSeal"),"expired event must not suppress hub parry")
reset();plan("hp",1);t=0.9;MURIM_GH.parryStep(t,char,hp)
hp.Health=200;t=1;MURIM_GH.parryStep(t,char,hp)
hp.Health=1000;t=2.2;MURIM_GH.parryStep(t,char,hp)
local found=false
for _,line in ipairs(messages) do if line:find("minimo=200",1,true) then found=true end end
check(found,"healing must not hide damage in parry result")
reset();plan("death",1);t=0.9;MURIM_GH.parryStep(t,char,hp)
hp.Health=0;MURIM_GH.parryStep(1,char,hp)
check(#MURIM_GH.parryQueue==0 and sent[#sent]=="ParryUp","death cancels and releases defense")
local count=#sent
for _,callback in ipairs(scheduled) do callback() end
check(#sent==count,"stale delayed release cannot affect a later defense")
reset();plan("bosschange",1);MURIM_HD.bossNow={Parent=true};t=0.9;MURIM_GH.parryStep(t,char,hp)
check(#sent==0 and #MURIM_GH.parryQueue==0,"changed boss cancels event")
reset();plan("stop",1);MURIM_HD.enabled=false;t=0.9;MURIM_GH.parryStep(t,char,hp)
check(#sent==0 and #MURIM_GH.parryQueue==0,"Auto off cancels pending parry")
reset()
local root={Position=Vec.new(60,0,0)}
for _=1,3 do MURIM_GH.farLesson("Cast",Vec.new(0,0,0),root) end
check(MURIM_GH.farEvidence.Cast==3 and not MURIM_GH.noFlee.Cast,"distant damage remains evidence, not proof to stop fleeing")
for i=0,50 do t=i*0.2;MURIM_GH.auditTick(t,char,hp,root,boss) end
check(#MURIM_GH.auditFight.samples<=32,"sample memory bounded")
hp.Health=100;t=10.2;MURIM_GH.auditTick(t,char,hp,root,boss)
found=false
for _,line in ipairs(messages) do if line:find("DANO AUDITADO",1,true) then found=true end end
check(found,"large hit includes audit evidence")
hp.Health=0;t=10.4;MURIM_GH.auditTick(t,char,hp,root,boss)
check(not MURIM_GH.auditFight and MURIM_GH.auditDump():find("morte do jogador",1,true),"death summary survives reset and appears in dump")
print("PASS V21D: overlap, second hit, dedup, cooldown, expiration, HP minimum, death, stale callback, boss change, Auto off, far evidence, bounded audit, summary")
