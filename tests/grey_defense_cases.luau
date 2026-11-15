local t=0
local scheduled={}
local sent={}
local messages={}
local hp={Health=1000,MaxHealth=1000}
local attrs={Armed=true}
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
local MURIM_GH={acts={},delay={},twice={},danger={},noFlee={FormationSeal=true},nearDist=40,safeDist=45}
local Workspace=workspace
local isParrying=false
local PARRY_WINDOW=0.22
local combatRemote=remote
local function findCombatRemote() return remote end
local Vec={}
local mt={__index=function(v,k) if k=="Magnitude" then return math.sqrt(v.X*v.X+v.Y*v.Y+v.Z*v.Z) end end,
    __sub=function(a,b) return Vec.new(a.X-b.X,a.Y-b.Y,a.Z-b.Z) end}
function Vec.new(x,y,z) return setmetatable({X=x,Y=y,Z=z},mt) end
MURIM_HD.fmt=function(v) return v and string.format("(%.0f,%.0f,%.0f)",v.X,v.Y,v.Z) or "nil" end
MURIM_HD.posOf=function() return Vec.new(0,0,0) end
-- MODULE_INSERT
-- INTEGRATION_INSERT
local function check(value,message) assert(value,message) end
local function reset()
    MURIM_GH.auditReset("test reset");sent={};scheduled={};messages={}
    hp.Health=1000;attrs={Armed=true};MURIM_HD.enabled=true;MURIM_HD.inside=true;MURIM_HD.bossNow=boss;t=0
    MURIM_HD.genericParryUntil=nil;isParrying=false
    MURIM_GH.danger={};bh.Health=5000
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
reset();plan("reserved",1);t=0.7
check(MURIM_GH.defenseWindow(t),"short pre-parry window reserved")
executeParry()
check(#sent==0,"generic parry cannot consume reserved window")
MURIM_HD.attack(nil,nil,t)
check(MURIM_HD.state:find("ataque suspenso",1,true),"actual attack returns before movement or Attack remote")
check(MURIM_HD.artifactBlocked(),"artifact cannot consume defense window")
t=0.1
check(not MURIM_GH.defenseWindow(t),"no prolonged combat pause between impacts")
reset();executeParry();check(#sent==1,"generic parry starts normally")
plan("generic-active",0.2);t=0.1;MURIM_GH.parryStep(t,char,hp)
check(#sent==1,"queued parry cannot overlap active generic hold")
for _,callback in ipairs(scheduled) do callback() end
t=0.23;MURIM_GH.parryStep(t,char,hp)
check(sent[2]=="ParryUp" and sent[3]=="ParryDown","queued defense follows generic release")
reset();plan("busy",1);attrs.Busy=true;t=0.9;MURIM_GH.parryStep(t,char,hp)
check(#sent==0,"busy character cannot send queued parry")
attrs.Busy=false;t=1;MURIM_GH.parryStep(t,char,hp)
check(sent[1]=="ParryDown","recovery within window retries")
reset();plan("knocked",1);attrs.Knocked=true;t=0.9;MURIM_GH.parryStep(t,char,hp)
check(#sent==0,"knocked character cannot parry")
t=1.3;MURIM_GH.parryStep(t,char,hp)
check(MURIM_GH.parryQueue[1].status~=nil,"incapacitation cannot hold queue indefinitely")
reset();MURIM_HD.profile.actDodge=false
check(not MURIM_GH.defenseWindow(1),"other dungeon profiles unaffected")
print("PASS V21E: real generic/queued parry coordination, Attack/artifact guards, short windows, busy retry, incapacitation, profile isolation")
MURIM_HD.profile.actDodge=true
local moves=0
MURIM_HD.backTo=function() moves+=1 end
local gained=0
-- Windups recorded in the supplied TXT; damage values are from greyheartland_golpes.txt.
for _,case in ipairs({{"FistCrit1014",0.92,0.32},{"Cast",0.94,0.68},{"SpearCrit",0.97,0.99},{"SpearDriveThrust",0.89,1.0}}) do
    reset();moves=0
    MURIM_GH.danger[case[1]]=case[3]
    local f=MURIM_GH.planFlee(boss,case[1],10,case[2],0,0,45,4)
    local immediate=case[3]>=0.9
    check(math.abs(f.startAt-(immediate and 10 or 10+case[2]-0.45))<0.00001,"scheduled lead or immediate lethal retreat")
    if not immediate then check(not MURIM_GH.fleeTick({},10) and moves==0,"early windup does not move or block combat") end
    check(not MURIM_GH.fleeBlocks(f.startAt-0.01),"attack allowed before dodge lead")
    check(MURIM_GH.fleeTick({},f.startAt) and moves==1,"dodge begins at lead")
    check(MURIM_GH.fleeBlocks(10+case[2]),"impact remains defended even for lethal attacks")
    MURIM_HD.attack(nil,nil,10+case[2]) -- must return before dereferencing/moving/attacking
    check(not MURIM_GH.fleeTick({},f.untilT),"combat resumes after original safety tail")
    gained+=f.startAt-10
end
reset();local f=MURIM_GH.planFlee(boss,"late",10,0.1,0,0,45,4)
check(f.startAt==10,"late alert flees immediately")
reset();f=MURIM_GH.planFlee(boss,"already-away",10,1,0,0,45,48)
check(f.startAt==10,"already far never reenters pending danger")
reset();MURIM_GH.planFlee(boss,"first",10,1,0,0,45,4)
f=MURIM_GH.planFlee(boss,"second",10.6,1,0.9,2,60,4)
check(f.startAt<=10.6 and math.abs(f.untilT-15.1)<0.001 and f.dist==60,"active overlapping/second hit protection retained")
check(MURIM_GH.fleeBlocks(14),"delayed second hit remains protected")
MURIM_HD.bossNow={Parent=true}
check(not MURIM_GH.fleeTick({},11),"old boss cannot move character")
print(string.format("PASS V21F: observed windups gain %.2fs attack opportunity across four attacks; lethal/overlapping/late/distant protections preserved",gained))
reset();moves=0
MURIM_GH.danger.SpearDriveThrust=1.0
local f=MURIM_GH.planFlee(boss,"SpearDriveThrust",10,0.874,0,0,45,4)
check(f.startAt==10,"143526 log: lethal thrust must not wait 0.424 seconds")
root.Position=Vec.new(45,0,0)
MURIM_GH.maintainFlee(root,10.2)
root.Position=Vec.new(4,0,0)
MURIM_GH.maintainFlee(root,10.41)
check(moves==2,"143526 log: movement lost during active retreat must trigger another position check/move")
local warned=false
for _,line in ipairs(messages) do if line:find("perdeu distancia",1,true) then warned=true end end
check(warned,"observed return from 45 to 4 must be explicit")
MURIM_GH.maintainFlee(root,10.42)
check(moves==2,"heartbeat corrections are throttled")
MURIM_GH.maintainFlee(root,f.untilT+0.1)
check(moves==2,"no retreat movement after attack window")
reset();local summaries=#MURIM_GH.auditHistory
MURIM_GH.auditTick(0,char,hp,root,boss)
bh.Health=0
MURIM_GH.auditTick(0.2,char,hp,root,boss)
for i=1,5 do MURIM_GH.auditTick(0.2+i*0.02,char,hp,root,boss) end
check(#MURIM_GH.auditHistory==summaries+1,"dead boss produces exactly one summary")
reset();MURIM_GH.auditTick(0,char,hp,root,boss);hp.Health=0
MURIM_GH.auditTick(0.2,char,hp,root,nil)
check(MURIM_GH.auditHistory[#MURIM_GH.auditHistory]:find("morte do jogador",1,true),"death when boss disappears retains correct reason")
print("PASS V21G: lethal immediate retreat, recorded 45-to-4 return, throttled correction, expired defense, single death summaries")
