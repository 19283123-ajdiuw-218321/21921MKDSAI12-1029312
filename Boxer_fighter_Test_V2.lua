-- Boxer_fighter_Test V2: startup diagnostics for Delta.
-- Entire implementation is embedded locally; no network download or external loadstring URL.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then warn("Boxer_fighter_Test V2: LocalPlayer unavailable"); return end
local pg = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui", 10)
if not pg then warn("Boxer_fighter_Test V2: PlayerGui unavailable"); return end
local old = pg:FindFirstChild("MurimHubStartup")
if old then old:Destroy() end
local notice = Instance.new("ScreenGui")
notice.Name = "MurimHubStartup"
notice.ResetOnSpawn = false
notice.DisplayOrder = 2147483647
notice.Parent = pg
local box = Instance.new("TextLabel")
box.Position = UDim2.new(0.5, -160, 0, 12)
box.Size = UDim2.fromOffset(320, 100)
box.BackgroundColor3 = Color3.fromRGB(28, 35, 49)
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.SourceSansBold
box.TextSize = 15
box.TextWrapped = true
box.Text = "Boxer_fighter_Test V2 • Inicializando..."
box.Parent = notice
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)
local dismiss = Instance.new("TextButton")
dismiss.Size = UDim2.fromOffset(26, 26)
dismiss.Position = UDim2.new(1, -28, 0, 2)
dismiss.Text = "×"
dismiss.BackgroundColor3 = Color3.fromRGB(110, 45, 55)
dismiss.TextColor3 = Color3.new(1, 1, 1)
dismiss.Parent = box
dismiss.Activated:Connect(function() notice:Destroy() end)
local function report(message, failed)
    if box.Parent then
        box.Text = "Boxer_fighter_Test V2\n" .. tostring(message)
        box.BackgroundColor3 = failed and Color3.fromRGB(115, 40, 45) or Color3.fromRGB(28, 35, 49)
    end
    if failed then warn("[Boxer_fighter_Test V2] " .. tostring(message)) end
end
local function finishNotice()
    if notice.Parent then notice:Destroy() end
end


local source = [====[
local report, finishNotice = ...
-- V18T: chunk independente, LocalPlayer do loader nao existe neste escopo.
local player = game:GetService("Players").LocalPlayer
print("[Boxer_fighter_Test V2] V19E: A06 timeline log (attacks, damage, new objects, ms); no behavior change")
-- Boxer_fighter_Test V2: supplied farm GUI + Alchemy / Forge / Cultivation.
-- Diagnostico interno: nao grava chaves, HWID, URLs ou credenciais.
-- O log permanece na memoria ate a sessao terminar; gravacao e opcional.
local MURIM_TRACE = {
    entries = {}, listeners = {}, lastSeen = {},
    active = false, stage = "Aguardando ativacao", lastStageAt = os.clock(),
    nextAction = "Ative o Halloween e utilize Inspecionar raid.",
    lastA01Action = nil,
    extraStatus = nil,
}
function MURIM_TRACE.add(level, area, message, minInterval, eventKey)
    local safeMessage = tostring(message or ""):gsub("[\r\n]+", " "):sub(1, 280)
    local key = tostring(level) .. "|" .. tostring(area) .. "|" .. (eventKey or safeMessage)
    local now = os.clock()
    if now - (MURIM_TRACE.lastSeen[key] or -1e9) < (minInterval or 0) then return end
    MURIM_TRACE.lastSeen[key] = now
    local timestamp = os.date("%H:%M:%S")
    local entry = string.format("[%s] [%s] [%s] %s", timestamp, tostring(level), tostring(area), safeMessage)
    table.insert(MURIM_TRACE.entries, entry)
    if #MURIM_TRACE.entries > 20000 then table.remove(MURIM_TRACE.entries, 1) end
    for _, handler in ipairs(MURIM_TRACE.listeners) do
        task.defer(handler)
    end
    if level == "ERRO" then warn("[Murim] " .. entry) end
end
function MURIM_TRACE.stageTo(stage)
    if MURIM_TRACE.stage == stage then return end
    MURIM_TRACE.stage = stage
    MURIM_TRACE.lastStageAt = os.clock()
    MURIM_TRACE.add("ETAPA", "Halloween", stage)
end
function MURIM_TRACE.suggest(message)
    if type(message) ~= "string" or message == "" then return end
    message = message:gsub("[\r\n]+", " "):sub(1, 360)
    if MURIM_TRACE.nextAction == message then return end
    MURIM_TRACE.nextAction = message
    MURIM_TRACE.add("ORIENTACAO", "Proximo teste", message)
end
-- V18S: no emulador a transferencia de texto pode truncar perto de 16 KB.
-- Copiar log prioriza os eventos MAIS RECENTES; Salvar TXT mantem o historico integral.
function MURIM_TRACE.section(lines,budget)
    local out,used={},0
    for i=#lines,1,-1 do
        if used+#lines[i]+1>budget then break end
        table.insert(out,1,lines[i]);used+=#lines[i]+1
    end
    return table.concat(out,"\n")
end
function MURIM_TRACE.dump(maxBytes)
    local header = "Boxer_fighter_Test V2 | Diagnostico V19E | " .. os.date("%Y-%m-%d %H:%M:%S")
        .. "\nEtapa: " .. MURIM_TRACE.stage
        .. "\nProximo teste sugerido (hipotese): " .. tostring(MURIM_TRACE.nextAction)
        .. "\n" .. (type(MURIM_TRACE.extraStatus)=="function" and MURIM_TRACE.extraStatus() or "Auto A01: estado nao carregado")
        .. "\nLog local; nao inclui keys, tokens, HWID nem URLs.\n\n"
        .. (MURIM_TRACE.encounterDump and MURIM_TRACE.encounterDump(type(maxBytes)~="number") or "")
    if type(maxBytes) ~= "number" then
        return header .. (MURIM_TRACE.timelineDump and MURIM_TRACE.timelineDump() or "") .. table.concat(MURIM_TRACE.entries, "\n")
            .. (type(MURIM_TRACE.surveyDump)=="function" and MURIM_TRACE.surveyDump() or "")
    end
    header=header..(MURIM_TRACE.timelineDump and MURIM_TRACE.timelineDump(math.clamp(math.floor(maxBytes)-#header-1130,1200,4200)) or "")
    local remaining=math.max(1000,math.floor(maxBytes)-#header-130)
    local recent,used={},0
    for i=#MURIM_TRACE.entries,1,-1 do
        local line=MURIM_TRACE.entries[i]
        if used+#line+1>remaining then break end
        table.insert(recent,1,line)
        used=used+#line+1
    end
    return header .. string.format(
        "[ULTIMOS EVENTOS: %d/%d; demais omitidos PARA EVITAR CORTE NO BLUESTACKS]\n",
        #recent,#MURIM_TRACE.entries) .. table.concat(recent,"\n")
end
function MURIM_TRACE.tail(count)
    local out = {}
    local first = math.max(1, #MURIM_TRACE.entries - (count or 80) + 1)
    for i = first, #MURIM_TRACE.entries do
        out[#out + 1] = MURIM_TRACE.entries[i]
    end
    return table.concat(out, "\n")
end
MURIM_TRACE.add("INFO", "Inicio", "Diagnostico carregado. Aba Logs disponivel apos criar o menu.")

-- Run the entire file once. Minus hides the menu; Destroy removes all systems.
-- No automatic reset, purchase, or breakthrough-start actions are added.
if type(_G.ArtificeGuiCleanup) == "function" then
    pcall(_G.ArtificeGuiCleanup)
end


-- ============================================================================
-- 🎃 HALLOWEEN RAID CONSTANTS & HELPERS (FILE-LEVEL SCOPE TO SAVE LOCAL REGISTERS)
-- ============================================================================
local HALLOW_GATE_CFRAME = CFrame.new(17958, 2, 2058)
local HALLOW_FOE_KEYWORDS = {
    "jiangshi", "driver", "effigy", "paper tailor", "hg_tailor", "hungry", "lure", "cerberus", "matriarch", "hg_", "raidmob"
}
local HALLOW_IGNORE_KEYWORDS = {
    "watchman", "sedan", "faceless", "gu heng", "tailor gu heng", "an rou", "tailor an rou", "under", "guest", "ledger", "outfit", "cloth"
}


local HALLOW_ROOM_DATA = {
    { name = "A01_Causeway", title = "Causeway of Unlit Lanterns", hz = "滅燈堤", offset = Vector3.new(0, 5, 96), maxZ = 232 },
    { name = "A02_CoffinLodge", title = "The Coffin Lodge", hz = "義莊", offset = Vector3.new(0, 5, 309), maxZ = 386 },
    { name = "A03_EffigyShop", title = "The Paper Effigy Shop", hz = "紙紮鋪", offset = Vector3.new(0, 5, 457), maxZ = 528 },
    { name = "A04_WatchmanStreet", title = "Watchman's Street", hz = "更夫街", offset = Vector3.new(0, 5, 760), maxZ = 992 },
    { name = "A05_Teahouse", title = "The Last Teahouse", hz = "末茶樓", offset = Vector3.new(0, -10, 1040), maxZ = 1088 },
    { name = "A06_Kennel", title = "Kennel of the Yin Gate", hz = "陰門獒院", offset = Vector3.new(0, -10, 1163), maxZ = 1238 },
    { name = "A07_Throat", title = "The Throat", hz = "咽井", offset = Vector3.new(0, -140, 1280), maxZ = 1322 },
    { name = "A08_Banquet", title = "Banquet of the Hungry", hz = "餓鬼宴", offset = Vector3.new(0, -300, 1422), maxZ = 1526 },
    { name = "A09_EmptyBelly", title = "The Empty Belly", hz = "空腹", offset = Vector3.new(0, -290, 1606), maxZ = 1686 },
    { name = "A10_MoonReturns", title = "The Moon Returns", hz = "月歸", offset = Vector3.new(0, -290, 1680), maxZ = 2000 },
}


local function findGuestLedger()
    local ws = game:GetService("Workspace")
    for _, desc in ipairs(ws:GetDescendants()) do
        if desc:IsA("ProximityPrompt") and desc.Enabled then
            local act = (desc.ActionText or ""):lower()
            local obj = (desc.ObjectText or ""):lower()
            if obj:find("ledger") or act:find("ledger") or obj:find("guest") or act:find("guest") then
                local pPart = desc.Parent:IsA("BasePart") and desc.Parent or (desc.Parent and desc.Parent:FindFirstChildWhichIsA("BasePart", true))
                if pPart then
                    return desc, pPart
                end
            end
        end
    end
    for _, desc in ipairs(ws:GetDescendants()) do
        local n = desc.Name:lower()
        if n:find("guest") and n:find("ledger") then
            local p = desc:IsA("BasePart") and desc or (desc:IsA("Model") and (desc.PrimaryPart or desc:FindFirstChildWhichIsA("BasePart", true)))
            if p then
                local prompt = desc:FindFirstChildWhichIsA("ProximityPrompt", true)
                return prompt, p
            end
        end
    end
    return nil, nil
end


-- Entrada do Halloween: auxiliares isolados da função buildMaster.
-- Não acrescentar locais ao escopo extenso de buildMaster (limite 200 do Luau).
local HallowEntryState = {
    lastPromptAt = 0,
    promptAttempts = 0,
    lastChoiceAt = 0,
    choiceAttempts = 0,
    awaitingEntryUntil = 0,
    lastSeenDialogAt = 0,
    manualChoiceWarned = false,
    wasInsideRaid = false,
    verifiedRoomIndex = nil,
    verifiedRoomAt = 0,
    sawCombatInRoom = false,
    lastRaidSnapshotAt = 0,
    lastRaidWarningAt = 0, lastNoDamageWarnAt = 0,
    lastRoomScanAt = 0,
    lastRoomScanReason = "ainda nao inspecionado",
    fallSince = 0, lastFallWarnAt = 0, lastGroundedY = nil,
}

-- Diagnostico de queda isolado: nao acrescenta registros locais a buildMaster.
-- V13: somente pausar uma queda grave, nao descidas normais durante combate.
-- O modo Above posiciona o personagem alguns studs acima do inimigo; ao descer
-- a velocidade vertical pode ser negativa mesmo com piso abaixo.
local function detectUncontrolledRaidFall(char, hrp)
    local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or not hrp then return false end
    local currentY = hrp.Position.Y
    if humanoid.FloorMaterial ~= Enum.Material.Air then
        HallowEntryState.lastGroundedY = currentY
        HallowEntryState.fallSince = 0
        return false
    end
    local groundedY = HallowEntryState.lastGroundedY
    local descent = groundedY and (groundedY - currentY) or 0
    local verticalSpeed = hrp.AssemblyLinearVelocity.Y
    -- Nao confundir queda de 8,5 studs no modo Above com fora do mapa.
    if not groundedY or descent < 55 or verticalSpeed > -15 then
        HallowEntryState.fallSince = 0
        return false
    end
    -- Durante transicoes de altura, um piso abaixo pode ser legitimo.
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char}
    params.IgnoreWater = true
    local floorHit = workspace:Raycast(hrp.Position, Vector3.new(0, -130, 0), params)
    if floorHit and floorHit.Instance and floorHit.Instance.CanCollide
        and floorHit.Normal.Y >= 0.65 then
        HallowEntryState.fallSince = 0
        return false
    end
    local now = os.clock()
    if HallowEntryState.fallSince == 0 then
        HallowEntryState.fallSince = now
        MURIM_TRACE.add("AVISO", "Fisica", string.format(
            "Possivel queda: Y=%.0f, ultimo piso=%.0f, diferenca=%.0f, VY=%.1f; confirmando antes de pausar.",
            currentY, groundedY, descent, verticalSpeed), 8)
        return false
    end
    if now - HallowEntryState.fallSince >= 2.0
        and now - HallowEntryState.lastFallWarnAt >= 5 then
        HallowEntryState.lastFallWarnAt = now
        MURIM_TRACE.add("ERRO", "Fisica", string.format(
            "Queda grave confirmada: Y=%.0f, ultimo piso=%.0f, queda=%.0f, VY=%.1f, sem piso nos proximos 130 studs. Auto Halloween sera pausado.",
            currentY, groundedY, descent, verticalSpeed))
        MURIM_TRACE.suggest("Queda grave abaixo do ultimo piso; use o respawn do jogo antes de reativar o Auto Halloween. Descidas curtas durante combate nao causam mais pausa.")
        return true
    end
    return false
end

local function isHallowGuiVisible(object)
    if not object or not object:IsA("GuiObject") then return false end
    if object.AbsoluteSize.X <= 0 or object.AbsoluteSize.Y <= 0 then return false end
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize
    if viewport and viewport.X > 0 and viewport.Y > 0 then
        local pos = object.AbsolutePosition
        local size = object.AbsoluteSize
        if pos.X + size.X < 0 or pos.Y + size.Y < 0 or pos.X >= viewport.X or pos.Y >= viewport.Y then
            return false
        end
    end
    local node = object
    while node do
        if node:IsA("GuiObject") and not node.Visible then return false end
        if node:IsA("ScreenGui") and not node.Enabled then return false end
        node = node.Parent
    end
    return true
end

local function isExactDifficultyText(raw, difficulty)
    if type(raw) ~= "string" then return false end
    local value = raw:lower():gsub("^%s+", "")
    local wanted = difficulty:lower()
    -- Mantém Hard distinto de Hardcore; aceita textos como 'Hard (Lv.90)'.
    return value == wanted
        or value:match("^" .. wanted .. "%f[%W]") ~= nil
        or value:match("^%b[]%s*" .. wanted .. "%f[%W]") ~= nil
end

local function findVisibleHallowDifficulty(playerGui, difficulty)
    local dialog = playerGui and playerGui:FindFirstChild("MurimDialog", true)
    if not dialog then return nil, false end
    local panel = dialog:FindFirstChild("Panel", true)
    if not panel or not isHallowGuiVisible(panel) then return nil, false end

    -- Não assumir Panel.ScrollingFrame, porque a UI do jogo pode mudar.
    -- Busca qualquer botão visível cujo nome ou legenda indique a dificuldade.
    local sawChoice = false
    for _, desc in ipairs(panel:GetDescendants()) do
        if desc:IsA("GuiButton") and isHallowGuiVisible(desc) then
            local candidate = isExactDifficultyText(desc.Name, difficulty)
            if desc:IsA("TextButton") then
                candidate = candidate or isExactDifficultyText(desc.Text, difficulty)
            end
            if not candidate then
                for _, nested in ipairs(desc:GetDescendants()) do
                    if nested:IsA("TextLabel") and isHallowGuiVisible(nested)
                       and isExactDifficultyText(nested.Text, difficulty) then
                        candidate = true
                        break
                    end
                end
            end
            if candidate then return desc, true end
            sawChoice = true
        end
    end
    return nil, sawChoice -- objeto invisível não bloqueia interação com o livro
end

local function tryHallowGuestPrompt(prompt)
    if not prompt or not prompt.Parent or not prompt.Enabled then
        return false, "prompt não disponível"
    end
    if typeof(fireproximityprompt) == "function" then
        local ok = pcall(function() fireproximityprompt(prompt) end)
        if ok then return true, "fireproximityprompt" end
    end
    local ok = pcall(function()
        prompt:InputHoldBegin()
        task.wait(math.max(0.1, prompt.HoldDuration or 0) + 0.1)
        prompt:InputHoldEnd()
    end)
    return ok, ok and "InputHoldBegin/End" or "interação manual necessária"
end

local function getActiveRaidInfo(p)
    local ply = p or game:GetService("Players").LocalPlayer
    local ws = game:GetService("Workspace")
    local raidsFolder = ws:FindFirstChild("Raids")
    local hrp = ply and ply.Character and ply.Character:FindFirstChild("HumanoidRootPart")
    local origin = Vector3.new(40000, 700, 3000)
    local activeRaidModel = nil


    if raidsFolder and hrp then
        local bestDist = math.huge
        for _, child in ipairs(raidsFolder:GetChildren()) do
            if child.Name:find("HallowGate") then
                local p = child:IsA("Model") and (child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart", true))
                if p then
                    local d = (p.Position - hrp.Position).Magnitude
                    if d < bestDist then
                        bestDist = d
                        activeRaidModel = child
                    end
                elseif not activeRaidModel then
                    activeRaidModel = child
                end
            end
        end
    end


    if activeRaidModel then
        if activeRaidModel.Name:find("2") then
            origin = Vector3.new(40000, 700, 7000)
        elseif activeRaidModel.Name:find("3") then
            origin = Vector3.new(40000, 700, 11000)
        else
            origin = Vector3.new(40000, 700, 3000)
        end
    end


    return activeRaidModel, origin
end


local function getRoomTargetPosition(roomIndex, activeRaidModel, origin)
    local data = HALLOW_ROOM_DATA[roomIndex]
    if not data then return nil end


    if activeRaidModel then
        local roomModel = activeRaidModel:FindFirstChild(data.name, true)
        if roomModel and roomModel:IsA("Model") then
            local cf, sz = roomModel:GetBoundingBox()
            if sz.Magnitude > 0 then
                return Vector3.new(cf.Position.X, cf.Position.Y - sz.Y / 2 + 4, cf.Position.Z)
            end
        end
    end


    -- Nunca teleportar por coordenadas estimadas se o modelo da sala nao carregou.
    return nil
end


-- O valor X confirma somente a regiao geral da arena.
-- Identificar a sala exige um modelo A01..A10 realmente carregado.
-- NÃO inferir a sala 10 quando um Z relativo ultrapassar os limites previstos.
-- V16: uma unica instancia, dez MODELOS de ambiente; as caixas 3D se sobrepoem
-- (telhados e decoracao). Preferir o Z do percurso empiricamente observado,
-- usando o modelo como validacao de carregamento, e nunca como flag de conclusao.
local HALLOW_AREA_Z = { -80, 230, 399, 530, 960, 1097, 1236, 1320, 1530, 1688, 2050 }
local function detectRoomIndexFromPosition(hrpPos, origin, activeRaidModel)
    if not activeRaidModel or not activeRaidModel.Parent then
        return nil, "modelo da raid nao encontrado"
    end
    if math.abs(hrpPos.X - origin.X) > 145 then
        return nil, "fora do corredor principal: deslocamento X=" .. string.format("%.0f",hrpPos.X-origin.X)
    end
    local relativeZ = hrpPos.Z - origin.Z
    for i = 1, #HALLOW_ROOM_DATA do
        if relativeZ >= HALLOW_AREA_Z[i] and relativeZ < HALLOW_AREA_Z[i+1] then
            local areaModel = activeRaidModel:FindFirstChild(HALLOW_ROOM_DATA[i].name, true)
            if not areaModel then return nil, "zona A"..string.format("%02d",i).." sem modelo carregado (streaming)" end
            -- Durante uma queda profunda, pos.Z ainda pode indicar area,
            -- mas NAO devemos declarar a sala como verificada.
            local expectedFloor = i <= 4 and origin.Y or (i <= 6 and origin.Y-20 or (i == 7 and origin.Y-140 or origin.Y-300))
            if i <= 6 and hrpPos.Y < expectedFloor - 90 then
                return nil, "abaixo do nivel transitavel; queda possivel Y="..string.format("%.0f",hrpPos.Y)
            end
            return i, string.format("faixa Z=%.0f em %s (modelo carregado; objetivo nao comprovado)",relativeZ,HALLOW_ROOM_DATA[i].name)
        end
    end
    return nil, "fora das faixas das dez areas: Z relativo="..string.format("%.0f",relativeZ)
end

local function isHallowEnemyInArea(foePos, origin, areaIndex)
    if not foePos or not origin or not areaIndex then return false end
    local rel=foePos.Z-origin.Z
    -- Only check the current section (with overlap for gate chokepoints).
    local low=HALLOW_AREA_Z[areaIndex]-24
    local high=HALLOW_AREA_Z[areaIndex+1]+24
    return rel>=low and rel<=high
end


-- ==========================================================================
-- V14: auditoria somente leitura das dez areas carregadas da Hungry Ghost Gate.
-- Cada sala pode conter parte de uma etapa do guia; nao igualar indice a conclusao.
-- Fica FORA de buildMaster para preservar o limite de registradores do Luau.
-- ==========================================================================
local MURIM_SURVEY = {
    latest = nil, previous = nil, report = "Mapa ainda nao gerado. Entre na raid e use 'Mapear dungeon'.",
    running = false, sequence = 0, promptEvents = 0,
}

function MURIM_SURVEY.clean(value, limit)
    return tostring(value or ""):gsub("[\r\n\t]+", " "):sub(1, limit or 100)
end

function MURIM_SURVEY.classify(name)
    local n = tostring(name or ""):lower()
    if n:find("coffin",1,true) or n:find("casket",1,true) or n:find("sarcoph",1,true) then return "CAIXAO" end
    if (n:find("key",1,true) and not n:find("monkey",1,true) and not n:find("keyboard",1,true)) or n:find("chave",1,true) then return "CHAVE_CANDIDATA" end
    if n:find("watchman",1,true) or n:find("faceless",1,true) or n:find("sedan",1,true) or n:find("procession",1,true) then return "AMEACA" end
    if n:find("hide",1,true) or n:find("hiding",1,true) or n:find("wardrobe",1,true) or n:find("closet",1,true) then return "ESCONDERIJO" end
    if n:find("door",1,true) or n:find("gate",1,true) or n:find("barrier",1,true) or n:find("seal",1,true) then return "PORTA" end
    if n:find("brazier",1,true) or n:find("torch",1,true) or n:find("bonfire",1,true) or n:find("firepit",1,true) then return "BRASEIRO" end
    if n:find("lantern",1,true) or n:find("lamp",1,true) or n:find("oil jar",1,true) or n=="oiljar" then return "LANTERNA" end
    if n:find("altar",1,true) or n:find("painting",1,true) or n:find("picture",1,true) or n:find("portrait",1,true) then return "ALTAR" end
    if n:find("offering",1,true) or n:find("tribute",1,true) then return "OFERENDA" end
    if n:find("lever",1,true) or n:find("switch",1,true) or n:find("trigger",1,true) then return "MECANISMO" end
    if n:find("cerberus",1,true) or n:find("matriarch",1,true) or n:find("boss",1,true) then return "CHEFE" end
    if n:find("bat",1,true) or n:find("paper",1,true) or n:find("effigy",1,true) or n:find("ghost",1,true) then return "ELEMENTO" end
    return nil
end

function MURIM_SURVEY.position(object)
    if not object then return nil end
    if object:IsA("BasePart") then return object.Position end
    if object:IsA("Model") then
        local p = object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart", true)
        return p and p.Position or nil
    end
    local node = object.Parent
    while node do
        if node:IsA("BasePart") then return node.Position end
        if node:IsA("Model") then
            local part = node.PrimaryPart or node:FindFirstChildWhichIsA("BasePart", true)
            if part then return part.Position end
        end
        node = node.Parent
    end
    return nil
end

function MURIM_SURVEY.positionLabel(pos)
    if not pos then return "pos=indisponivel" end
    return string.format("pos=(%.0f,%.0f,%.0f)", pos.X, pos.Y, pos.Z)
end

function MURIM_SURVEY.readState(obj)
    local state = {}
    if obj:IsA("ProximityPrompt") then
        state[#state+1] = "Enabled="..tostring(obj.Enabled)
        state[#state+1] = "Hold="..string.format("%.1f", obj.HoldDuration)
        state[#state+1] = "MaxDist="..string.format("%.0f", obj.MaxActivationDistance)
    elseif obj:IsA("ClickDetector") then
        state[#state+1] = "ClickMaxDist="..string.format("%.0f", obj.MaxActivationDistance)
    elseif obj:IsA("Humanoid") then
        state[#state+1] = "HP="..string.format("%.0f", obj.Health)
    end
    -- Lista permitida: atributos de ESTADO, nunca chaves de acesso ou IDs pessoais.
    for _, name in ipairs({
        "Open", "Opened", "IsOpen", "Locked", "Unlocked", "IsLocked", "HasKey", "KeyFound",
        "Collected", "Taken", "Used", "Activated", "Active", "Completed", "Cleared", "Solved",
        "Lit", "Ignited", "IsLit", "Triggered", "State", "Progress", "Stage", "Room", "GateState"
    }) do
        local value = obj:GetAttribute(name)
        if value ~= nil then
            local t = typeof(value)
            if t == "number" or t == "boolean" or t == "string" then
                state[#state+1] = name.."="..MURIM_SURVEY.clean(value, 40)
            end
        end
    end
    if obj:IsA("Model") or obj:IsA("Folder") then
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("BoolValue") or child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("StringValue") then
                local n = child.Name:lower()
                if n:find("open",1,true) or n:find("lock",1,true) or n:find("key",1,true)
                    or n:find("complete",1,true) or n:find("lit",1,true) or n:find("state",1,true)
                    or n:find("progress",1,true) or n:find("activ",1,true) then
                    state[#state+1] = "Value."..MURIM_SURVEY.clean(child.Name,35).."="..MURIM_SURVEY.clean(child.Value,35)
                end
            end
        end
    end
    if #state == 0 then return "estado nao exposto" end
    return table.concat(state, ",")
end

function MURIM_SURVEY.identity(obj, roomName, pos)
    local path = MURIM_SURVEY.clean(obj:GetFullName(), 210)
    return roomName.."/"..obj.ClassName.."/"..path.."@"..MURIM_SURVEY.positionLabel(pos)
end

function MURIM_SURVEY.run(p)
    if MURIM_SURVEY.running then
        MURIM_TRACE.add("AVISO", "Mapa", "Varredura ja em andamento; aguarde terminar.", 3)
        return false
    end
    MURIM_SURVEY.running = true
    local resultOK, resultError = pcall(function()
        local ws = game:GetService("Workspace")
        local player = p or game:GetService("Players").LocalPlayer
        local char = player and player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local raid, origin = getActiveRaidInfo(player)
        MURIM_SURVEY.sequence = MURIM_SURVEY.sequence + 1
        local previous = MURIM_SURVEY.latest
        local current = { states={}, loaded={}, timestamp=os.date("%Y-%m-%d %H:%M:%S") }
        local lines = {}
        lines[#lines+1] = "MAPA DUNGEON | V18R | varredura #"..MURIM_SURVEY.sequence.." | "..current.timestamp
        lines[#lines+1] = "Somente objetos replicados/carregados no cliente (StreamingEnabled pode ocultar areas)."
        lines[#lines+1] = "O mapa NAO decompila scripts do servidor, nao prova conclusao da etapa e NAO executa interacoes."
        lines[#lines+1] = "Raid="..(raid and MURIM_SURVEY.clean(raid.Name) or "NAO ENCONTRADA")
            .." | "..(root and MURIM_SURVEY.positionLabel(root.Position) or "personagem ausente")
            .." | origem="..MURIM_SURVEY.positionLabel(origin)
        lines[#lines+1] = "Guia: etapa 1 pode usar A01 + A02; nao equivale diretamente a dez etapas."
        if not raid then
            MURIM_TRACE.add("AVISO", "Mapa", "Modelo da raid nao encontrado: entre na dungeon, aguarde carregar e mapeie novamente.")
            lines[#lines+1] = "[BLOQUEIO] Modelo HallowGate ausente. Nao ha evidencia para mapear salas."
        end
        local loadedRooms, relevantTotal, promptTotal, coffinsTotal, keyCandidates = 0, 0, 0, 0, 0
        for index, data in ipairs(HALLOW_ROOM_DATA) do
            local room = raid and raid:FindFirstChild(data.name, true)
            local label = string.format("A%02d", index)
            if not room then
                lines[#lines+1] = "["..label.."] NAO CARREGADA/VISIVEL; ausencia NAO significa etapa concluida."
            else
                loadedRooms = loadedRooms + 1
                current.loaded[data.name] = true
                local objects = room:GetDescendants()
                local counts, details = {}, {}
                local prompts, humanoids, scanned, truncated = 0, 0, 0, false
                for _, obj in ipairs(objects) do
                    scanned = scanned + 1
                    if scanned > 18000 then truncated = true; break end
                    local isPrompt = obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector")
                    local isHumanoid = obj:IsA("Humanoid")
                    local kind = isPrompt and "INTERACAO" or (isHumanoid and "INIMIGO_CANDIDATO" or MURIM_SURVEY.classify(obj.Name))
                    if kind then
                        -- Evita listar partes de modelos cuja categoria ja foi representada pelo Model.
                        local parent = obj.Parent
                        local duplicatedPart = obj:IsA("BasePart") and parent and parent:IsA("Model") and MURIM_SURVEY.classify(parent.Name) == kind
                        if not duplicatedPart and (isPrompt or isHumanoid or obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("Folder")) then
                            counts[kind] = (counts[kind] or 0) + 1
                            local pos = MURIM_SURVEY.position(obj)
                            local state = MURIM_SURVEY.readState(obj)
                            local action = ""
                            if obj:IsA("ProximityPrompt") then
                                prompts = prompts + 1
                                action = "acao="..MURIM_SURVEY.clean(obj.ActionText, 60).."; alvo="..MURIM_SURVEY.clean(obj.ObjectText, 60).."; "
                            elseif isHumanoid then
                                humanoids = humanoids + 1
                            end
                            local key = MURIM_SURVEY.identity(obj,data.name,pos)
                            local fullState = state.."|"..action
                            current.states[key] = fullState
                            if #details < 210 or kind == "CAIXAO" or kind == "CHAVE_CANDIDATA" then
                                local distance = pos and root and string.format(" | dist=%.0f", (pos - root.Position).Magnitude) or ""
                                local parentLabel = ""
                                if isPrompt and obj.Parent then
                                    parentLabel = " | pai="..MURIM_SURVEY.clean(obj.Parent.Name,45)
                                    local near = obj.Parent.Parent
                                    if near and near.Name ~= room.Name then
                                        parentLabel = parentLabel.." < "..MURIM_SURVEY.clean(near.Name,45)
                                    end
                                end
                                local line = "  ["..kind.."] "..MURIM_SURVEY.clean(obj.Name, 62)
                                    .." ("..obj.ClassName..") "..MURIM_SURVEY.positionLabel(pos)..distance
                                    ..parentLabel.." | "..action..state
                                details[#details+1] = {kind=kind,line=line,pos=pos,sortName=obj.Name}
                            end
                        end
                    end
                    if scanned % 1800 == 0 then task.wait() end
                end
                relevantTotal = relevantTotal + #details
                promptTotal = promptTotal + prompts
                coffinsTotal = coffinsTotal + (counts.CAIXAO or 0)
                keyCandidates = keyCandidates + (counts.CHAVE_CANDIDATA or 0)
                table.sort(details, function(a,b)
                    if a.kind ~= b.kind then return a.kind < b.kind end
                    if a.pos and b.pos and a.pos.Z ~= b.pos.Z then return a.pos.Z < b.pos.Z end
                    return a.sortName < b.sortName
                end)
                local countText={}
                for kind, count in pairs(counts) do countText[#countText+1] = kind.."="..count end
                table.sort(countText)
                lines[#lines+1] = "["..label.."] "..data.name.." | modelo visivel (streaming parcial possivel)"
                    .." | atributos="..MURIM_SURVEY.readState(room)
                    .." | descendentes lidos="..math.min(scanned,18000)
                    ..(#objects > 18000 and "/"..#objects or "")
                    .." | "..table.concat(countText, ",")
                if truncated then lines[#lines+1] = "  [LIMITE] Auditoria parcial: >18000 descendentes na area." end
                local printed = 0
                for _, detail in ipairs(details) do
                    if printed >= 240 then break end
                    lines[#lines+1] = detail.line
                    printed = printed+1
                end
                if #details > printed then lines[#lines+1]="  [LIMITE] "..(#details-printed).." detalhes omitidos; totais acima ainda incluem itens." end
                if index==2 then
                    lines[#lines+1] = "  [CHECKLIST A02] objetos com nome caixao="..(counts.CAIXAO or 0)
                        .." (inclui partes/modelos, nao equivale a caixoes fisicos distintos)"
                        .."; candidatos a chave="..(counts.CHAVE_CANDIDATA or 0)
                        .."; interacoes="..prompts..". Nao ha confirmacao de chave coletada sem estado replicado."
                    lines[#lines+1] = "  [PROXIMA ACAO] Compare antes/depois de acionar 'Open' em um caixao; veja se apareceu chave, mudou atributo ou prompt. Identifique o caixao por posicao."
                end
            end
        end
        lines[#lines+1] = "[RESUMO] modelos de area visiveis="..loadedRooms.."/10; detalhes registrados="..relevantTotal
            .."; prompts="..promptTotal.."; objetos nomeados caixao="..coffinsTotal.."; candidatos chave="..keyCandidates
        local backpack = player and player:FindFirstChildOfClass("Backpack")
        if backpack then
            local matches = 0
            for _, item in ipairs(backpack:GetChildren()) do
                local n = item.Name:lower()
                if n:find("key",1,true) or n:find("chave",1,true) then
                    matches=matches+1
                    lines[#lines+1] = "[BACKPACK CHAVE CANDIDATA] "..MURIM_SURVEY.clean(item.Name,80).." | "..item.ClassName
                end
            end
            lines[#lines+1] = "[BACKPACK] objetos nomeados como chave="..matches.."; ausência não exclui chave guardada no servidor."
        end
        lines[#lines+1] = "[IMPORTANTE] Objeto nao encontrado pode estar fora de streaming. Prompt desabilitado nao prova, sozinho, quest concluida."
        lines[#lines+1] = "[COMPARACAO] "..(previous and "Comparando com varredura anterior:" or "Primeira varredura; nenhuma comparacao anterior.")
        if previous then
            local changes, totalChanges = 0, 0
            for key, state in pairs(current.states) do
                local before = previous.states[key]
                if before and before ~= state then
                    totalChanges = totalChanges+1
                    if changes < 100 then
                        lines[#lines+1] = "  [ALTERADO] "..MURIM_SURVEY.clean(key,160).." | ANTES "..MURIM_SURVEY.clean(before,170).." | DEPOIS "..MURIM_SURVEY.clean(state,170)
                        changes=changes+1
                    end
                elseif not before then
                    totalChanges=totalChanges+1
                    if changes < 100 then
                        lines[#lines+1] = "  [NOVO/STREAM] "..MURIM_SURVEY.clean(key,160).." | "..MURIM_SURVEY.clean(state,120)
                        changes=changes+1
                    end
                end
            end
            for key in pairs(previous.states) do
                if not current.states[key] then
                    local roomName=key:match("^(A%d%d_[^/]+)/")
                    if roomName and current.loaded[roomName] then
                        totalChanges=totalChanges+1
                        if changes < 100 then
                            lines[#lines+1] = "  [DESAPARECEU/STREAM] "..MURIM_SURVEY.clean(key,160).." (pode ser streaming; nao provar coleta)"
                            changes=changes+1
                        end
                    end
                end
            end
            lines[#lines+1] = "  Total de diferencas detectadas="..totalChanges
            if totalChanges > changes then lines[#lines+1] = "  Outras "..(totalChanges-changes).." diferencas omitidas para limitar o log." end
        end
        MURIM_SURVEY.previous = previous
        MURIM_SURVEY.latest = current
        MURIM_SURVEY.report = table.concat(lines,"\n")
        MURIM_TRACE.add("INFO", "Mapa", string.format("Varredura %d finalizada: %d/10 modelos de area visiveis, %d prompts, %d objetos de caixao e %d candidatos a chave. Veja MAPA no final do log copiado.",MURIM_SURVEY.sequence,loadedRooms,promptTotal,coffinsTotal,keyCandidates))
        local areaNow=tonumber(tostring(MURIM_TRACE.stage):match("area (%d+)"))
        if areaNow==4 then
            MURIM_TRACE.suggest("A04 Watchman's Street: 3 lanternas de santuario e esconderijos Hide/E para o Watchman/procissao. Logs Watchman registram progresso e ameacas.")
        elseif areaNow==3 then
            MURIM_TRACE.suggest("A03: siga o objetivo ATUAL da HUD. Se aparecer To the yard, nao atacar mais Paper Effigy; priorizar chefe/passagem final. Se Painted eyes estiver ativo, comparar dano e contador.")
        elseif areaNow==2 then
            MURIM_TRACE.suggest("A02 Coffin Lodge: abrir caixoes e verificar Back gate Open=true antes de prosseguir.")
        else
            MURIM_TRACE.suggest("Mapa registrado. Use o resumo da area atual; modelos distantes podem estar incompletos pelo streaming.")
        end
    end)
    MURIM_SURVEY.running = false
    if not resultOK then
        MURIM_TRACE.add("ERRO", "Mapa", "Falha na auditoria, sem alterar mundo: "..MURIM_SURVEY.clean(resultError,220))
    end
    return resultOK
end

function MURIM_SURVEY.notePromptTriggered(prompt)
    if not prompt or not prompt.Parent then return end
    local node, roomName, inRaid = prompt.Parent, nil, false
    while node do
        if type(node.Name)=="string" and node.Name:match("^A%d%d_") then roomName = node.Name end
        if type(node.Name)=="string" and node.Name:find("HallowGate",1,true) then inRaid = true; break end
        node = node.Parent
    end
    if not inRaid then return end
    local action=MURIM_SURVEY.clean(prompt.ActionText,60)
    local target=MURIM_SURVEY.clean(prompt.ObjectText,60)
    local label=roomName or "AREA NAO IDENTIFICADA"
    MURIM_SURVEY.promptEvents=MURIM_SURVEY.promptEvents+1
    MURIM_TRACE.add("ACAO", "DungeonPrompt", label.." | "..action.." / "..target
        .." | evento="..MURIM_SURVEY.promptEvents.." | Enabled="..tostring(prompt.Enabled)
        ..". Evento nao prova aceitacao pelo servidor.")
    task.delay(1, function()
        if not prompt.Parent then
            MURIM_TRACE.add("EVIDENCIA", "DungeonPrompt", label.." | prompt removido/nao carregado apos interacao; pode ser streaming.")
        else
            MURIM_TRACE.add("EVIDENCIA", "DungeonPrompt", label.." | estado apos 1s: Enabled="..tostring(prompt.Enabled)
                .."; atributos="..MURIM_SURVEY.readState(prompt))
        end
    end)
end

MURIM_TRACE.surveyDump = function()
    return "\n\n"..MURIM_SURVEY.report
end

-- Diagnostico somente leitura: examina por que a sala 1 nao gera combate.
-- Fica no escopo do arquivo para nao aumentar os locais em buildMaster (limite Luau).
local MURIM_A01 -- forward declaration: inspection and controller share the same state
local function inspectHalloweenWorld(ply, isAcceptedFoe, isAlivePredicate)
    local ws = game:GetService("Workspace")
    local rs = game:GetService("ReplicatedStorage")
    local cs = game:GetService("CollectionService")
    local char = ply and ply.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then
        MURIM_TRACE.add("AVISO", "Censo", "Sem HumanoidRootPart; entre no jogo antes de inspecionar.")
        return
    end
    local raid, origin = getActiveRaidInfo(ply)
    local roomIndex=detectRoomIndexFromPosition(root.Position,origin,raid)
    local roomDef=roomIndex and HALLOW_ROOM_DATA[roomIndex]
    local roomName=roomDef and roomDef.name or "sala desconhecida"
    local room=roomDef and raid and raid:FindFirstChild(roomName,true)
    local roomLabel=roomIndex and string.format("A%02d",roomIndex) or "desconhecida"
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
    local fm = humanoid and humanoid.FloorMaterial.Name or "indisponivel"
    MURIM_TRACE.add("INFO", "Censo", string.format("INICIO (somente leitura) pos=(%.0f,%.0f,%.0f), solo=%s, raid=%s", root.Position.X, root.Position.Y, root.Position.Z, fm, raid and raid.Name or "ausente"))
    if not raid then
        MURIM_TRACE.add("AVISO", "Censo", "Sem modelo HallowGate carregado; inspeção de inimigos pode ser parcial.")
    else
        MURIM_TRACE.add("INFO", "Censo", roomName.." carregada=" .. tostring(room ~= nil)
            .. "; tipo=" .. (room and room.ClassName or "-")
            .. "; filhos=" .. (room and tostring(#room:GetChildren()) or "0"))
    end
    -- Inspeciona os dois locais onde o farm procura inimigos, sem mover o jogador.
    local npcFolder = ws:FindFirstChild("Murim_NPCs")
    local countBySource = {}
    local records = {}
    local visited = {}
    local function inspectSource(parent, source, deep)
        if not parent then
            MURIM_TRACE.add("INFO", "Censo", source .. " inexistente ou nao carregado")
            return
        end
        local descendants = deep and parent:GetDescendants() or parent:GetChildren()
        local seen, directH, nestedH, alive, inRange, accepted = 0,0,0,0,0,0
        local inspected = 0
        for _, model in ipairs(descendants) do
            if inspected >= 6000 then break end
            inspected += 1
            if model:IsA("Model") and not visited[model] then
                local hum = model:FindFirstChildOfClass("Humanoid")
                if hum then
                    visited[model] = true
                    seen += 1
                    directH += 1
                    if hum.Health > 0 then alive += 1 end
                    local p = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart", true)
                    if p then
                        local dist = (p.Position - root.Position).Magnitude
                        if dist <= 250 then inRange += 1 end
                        local valid = (type(isAcceptedFoe)=="function" and isAcceptedFoe(model)) or false
                        local acceptedAlive = (type(isAlivePredicate)=="function" and isAlivePredicate(model)) or false
                        if valid and acceptedAlive and dist <= 250 then accepted += 1 end
                        if dist <= 500 then
                            records[#records+1] = {
                                distance=dist, name=model.Name, source=source,
                                health=hum.Health, direct=true, valid=valid, alive=acceptedAlive,
                                range=(dist<=250), x=p.Position.X,
                                friendPrompt=model:FindFirstChildWhichIsA("ProximityPrompt",true)~=nil,
                                unhurt=model:GetAttribute("unhurt"), noBar=model:GetAttribute("HallowNoBar"),
                                watched=cs:HasTag(model,"HallowWatched"),
                            }
                        end
                    end
                end
            end
        end
        countBySource[#countBySource+1] = string.format("%s: modelos com Humanoid=%d; vivos=%d; a <=250=%d; aceitos por ambos filtros=%d; inspecionados=%d",source,seen,alive,inRange,accepted,inspected)
    end
    inspectSource(npcFolder,"Murim_NPCs",false)
    inspectSource(room,"Sala atual/"..roomLabel,true)
    inspectSource(raid,"Raids/HallowGate",true)
    for _, line in ipairs(countBySource) do MURIM_TRACE.add("INFO","Censo",line) end
    table.sort(records, function(a,b) return a.distance<b.distance end)
    for i=1,math.min(12,#records) do
        local m=records[i]
        MURIM_TRACE.add("INFO","Candidato", string.format("%s | %s | dist=%.0f | HP=%.0f | X=%.0f | filtroFoe=%s | isAlive=%s | prompt=%s | unhurt=%s | NoBar=%s | watched=%s",m.source,tostring(m.name):sub(1,55),m.distance,m.health,m.x,tostring(m.valid),tostring(m.alive),tostring(m.friendPrompt),tostring(m.unhurt),tostring(m.noBar),tostring(m.watched)))
    end
    if #records==0 then
        MURIM_TRACE.add("AVISO","Censo","Nenhum Model com Humanoid encontrado a 500 studs nos dois locais pesquisados. Pode ser fase sem inimigos ou estrutura diferente.")
    end
    -- Verifica Humanoids aninhados: causa comum de falha em FindFirstChildOfClass.
    if raid then
        local nestedCount=0
        for _, desc in ipairs(raid:GetDescendants()) do
            if desc:IsA("Humanoid") and desc.Parent and desc.Parent:IsA("Model") then
                local owner=desc.Parent
                if owner.Parent and owner.Parent:IsA("Model") then
                    nestedCount+=1
                    if nestedCount<=5 then
                        MURIM_TRACE.add("INFO","NestedHumanoid","Modelo="..owner.Name.."; pai="..owner.Parent.Name.."; HP="..math.floor(desc.Health))
                    end
                end
            end
        end
        MURIM_TRACE.add("INFO","Censo","Humanoids aninhados no modelo da raid="..nestedCount)
    end
    local remote = rs:FindFirstChild("HallowGateSeen")
    local watched = cs:GetTagged("HallowWatched")
    MURIM_TRACE.add("INFO","Mecanica","HallowGateSeen="..(remote and remote.ClassName or "nao encontrado").."; HallowWatched tags="..#watched)
    for i=1,math.min(5,#watched) do
        local obj=watched[i]
        MURIM_TRACE.add("INFO","Mecanica","HallowWatched #"..i.." "..obj.Name.." tipo="..obj.ClassName.." HallowId="..tostring(obj:GetAttribute("HallowId")~=nil))
    end
    -- Prompt de interacao no modelo A01 (pode revelar objetivo sem inimigos).
    if room then
        local promptCount=0
        for _, obj in ipairs(room:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                promptCount+=1
                if promptCount<=12 then
                    local anchor=obj:FindFirstAncestorWhichIsA("BasePart")
                    local dist=anchor and (anchor.Position-root.Position).Magnitude or -1
                    MURIM_TRACE.add("INFO","Prompt"..roomLabel,string.format("%s | acao=%s | objeto=%s | enabled=%s | dist=%.0f",obj.Name,tostring(obj.ActionText):sub(1,45),tostring(obj.ObjectText):sub(1,45),tostring(obj.Enabled),dist))
                end
            end
        end
        MURIM_TRACE.add("INFO","Censo","ProximityPrompts na sala "..roomLabel.."="..promptCount)
        local specialCount=0
        local keywords={"paper","flutt","ghost","jiangs","effigy","lantern","trigger","watch","enemy","talisman","soul","door","brazier"}
        for _, obj in ipairs(room:GetDescendants()) do
            local low=obj.Name:lower()
            local match=false
            for _, word in ipairs(keywords) do
                if low:find(word,1,true) then match=true; break end
            end
            if match and (obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("ProximityPrompt")) then
                specialCount+=1
                if specialCount<=12 then
                    local part=obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart",true))
                    local dist=part and (part.Position-root.Position).Magnitude or -1
                    MURIM_TRACE.add("INFO","Objeto"..roomLabel,string.format("%s | tipo=%s | dist=%.0f",obj.Name:sub(1,65),obj.ClassName,dist))
                end
            end
        end
        MURIM_TRACE.add("INFO","Censo","Objetos com nomes de mecanica na "..roomLabel.."="..specialCount)
    end
    -- Analise acionavel somente de leitura. Nunca afirmar que houve conclusao da fase.
    if room and roomIndex==1 then
        local aliveNear = 0
        for _, m in ipairs(records) do
            if m.health > 0 then aliveNear += 1 end
        end
        local oilDist, offeringDist, oilEnabled, offeringEnabled = math.huge, math.huge, false, false
        for _, obj in ipairs(room:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and obj.Enabled then
                local action = (obj.ActionText or ""):lower()
                local target = (obj.ObjectText or ""):lower()
                local anchor = obj:FindFirstAncestorWhichIsA("BasePart")
                local dist = anchor and (anchor.Position - root.Position).Magnitude or math.huge
                if action:find("refill", 1, true) or target:find("oil jar", 1, true) then
                    oilEnabled = true
                    oilDist = math.min(oilDist, dist)
                elseif action:find("offering", 1, true) or target:find("offering bowl", 1, true) then
                    offeringEnabled = true
                    offeringDist = math.min(offeringDist, dist)
                end
            end
        end
        if aliveNear == 0 and (oilEnabled or offeringEnabled) and MURIM_A01.enabled then
            MURIM_TRACE.add("DIAGNOSTICO", "Sala A01", "Sem inimigos no alcance; Auto A01 esta ligado e tentara objetos conhecidos (Oil Jar / Offering Bowl) com verificacao de efeitos.")
            MURIM_TRACE.suggest("Auto A01 LIGADO. Aguarde logs DECISAO/ACAO/EVIDENCIA. Se o mundo nao reagir, desative Auto A01 e teste o prompt manualmente.")
        elseif aliveNear == 0 and (oilEnabled or offeringEnabled) then
            MURIM_TRACE.add("DIAGNOSTICO", "Sala A01",
                "Nao ha inimigos com Humanoid perto, mas ha interacoes habilitadas. Combate automatico NAO e a proxima etapa comprovada.")
            if MURIM_TRACE.lastA01Action == "refill" then
                MURIM_TRACE.suggest("Oil Jar ja foi acionado nesta sessao. Verifique no jogo se a lanterna mudou; teste Offering Bowl manualmente se ainda estiver disponivel, e inspecione a raid novamente. Ordem nao confirmada.")
            elseif MURIM_TRACE.lastA01Action == "offering" then
                MURIM_TRACE.suggest("Offering Bowl ja foi acionado nesta sessao. Verifique objetivo e passagem; se nada mudou, teste o Oil Jar proximo e reinspecione. Ordem nao confirmada.")
            elseif oilEnabled then
                MURIM_TRACE.suggest(string.format(
                    "Teste MANUAL: aproxime-se de Oil Jar (%.0f studs), toque 'Refill your lantern', aguarde a mudanca do objetivo e use Inspecionar raid novamente. Depois teste Offering Bowl (%.0f studs) se necessario. A ordem ainda nao esta confirmada.",
                    oilDist, offeringEnabled and offeringDist or -1))
            else
                MURIM_TRACE.suggest(string.format(
                    "Teste MANUAL: Offering Bowl (%.0f studs) tem 'Take the offering'. Toque, verifique a missao e inspecione novamente; nao ha inimigos perto.",
                    offeringDist))
            end
        elseif aliveNear == 0 then
            MURIM_TRACE.suggest("Nenhum inimigo com Humanoid perto e nenhum prompt-chave acessivel. Leia a instrucao do jogo e inspecione objetos da sala; nao teleportar para proxima sala sem confirmacao.")
        else
            MURIM_TRACE.suggest("Ha inimigos proximos. Se Auto Halloween estiver ON e nao atacar, confira registros CombateA01 (remoto, HP e resposta).")
        end
        MURIM_TRACE.add("INFO", "Sala A01", "Inspecao concluida sem acionar interacoes; as instrucoes acima sao HIPOTESES para teste manual.")
    end
    if roomIndex~=1 then
        MURIM_TRACE.add("INFO","Sala "..roomLabel,"Inspecao da sala atual; presenca de objetos nao comprova conclusao nem autoria de interacoes.")
    end
    if roomIndex==3 then
        MURIM_TRACE.suggest("Voce esta na A03. Observe a HUD atual: em 'To the yard', confirme HallowDoor.Open na Z+478 e avance ate o patio/Tailor. A instrucao generica da A01 nao se aplica aqui.")
    end
    MURIM_TRACE.add("INFO","Censo","FIM. Nenhum ataque, teleporte ou clique foi executado por esta inspecao.")
end

-- ==========================================================================
-- V12 - AUTOMACAO OBSERVAVEL DA A01
-- Executa somente os prompts conhecidos (Oil Jar / Offering Bowl) da A01.
-- Um evento enviado nunca e tratado como confirmacao do servidor.
-- ==========================================================================
local MURIM_A02
local MURIM_RAID_HIT, MURIM_A03, MURIM_A04
MURIM_A01 = {
    enabled = true,
    phase = "aguardando raid",
    attempts = setmetatable({}, {__mode="k"}),
    lastTickAt = 0, lastMoveAt = 0, lastThreatAt = 0,
    pending = nil, lastAction = "nenhuma", lastResult = "nenhum",
    triggerConfirmed = false, damageObserved = false, defeatedObserved = false,
    lastTarget = nil, lastTargetHp = nil, lastDamageAt = 0,
    lastCombatReportAt = 0, lastNoEffectAt = 0,
    noFloorWarnAt = 0, lastNoTaskAt = 0,
    patrolIndex = 1, patrolDone = false, patrolBlocked = false, lastPatrolWarnAt = 0,
}
MURIM_TRACE.extraStatus = function()
    -- Falha de leitura nao deve impedir copiar o diagnostico.
    local a04Live="indisponivel"
    if MURIM_A04 and type(MURIM_A04.observeWorld)=="function" then
        local ok,value=pcall(MURIM_A04.observeWorld)
        if ok then
            a04Live=tostring(value)
        else
            -- Registrar a falha REAL, sem presumir que a sala ou os shrines falharam.
            a04Live="ERRO OBSERVEWORLD: "..tostring(value):gsub("[\r\n]+"," "):sub(1,190)
        end
    end
    return "Auto A01: " .. (MURIM_A01.enabled and "ON" or "OFF")
        .. " | fase=" .. tostring(MURIM_A01.phase)
        .. " | ultima acao=" .. tostring(MURIM_A01.lastAction)
        .. " | ultimo resultado=" .. tostring(MURIM_A01.lastResult)
        .. " | dano observado=" .. tostring(MURIM_A01.damageObserved)
        .. " | derrota observada=" .. tostring(MURIM_A01.defeatedObserved)
        .. " | patrulha=" .. tostring(math.min(MURIM_A01.patrolIndex, 2)) .. "/2"
        .. (MURIM_A02 and (" | Auto A02: " .. tostring(MURIM_A02.phase)
            .. " | caixoes alterados=" .. tostring(MURIM_A02.openedObserved)) or "")
        .. " | DanoRaid: confirmados="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.damageCount or 0)
        .. ", sem dano/skip="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.skipCount or 0)
        .. ", Painted eyes="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.eyes or "nao ativo/nao lido")
        .. " | HUD="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.hudObjective or "-")
        .. ", efígies imunes="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.paperPermanentSkips or 0)
        .. ", foco chefe="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.bossFocus and MURIM_RAID_HIT.bossFocus.Name or "nenhum")
        .. " | Auto A03="..tostring(MURIM_A03 and MURIM_A03.phase or "-")
         .. " | Navegacao A03="..tostring(MURIM_A03 and MURIM_A03.lastStageReason or "-")
         .. " | Paper mortes sem HUD="..tostring(MURIM_RAID_HIT and MURIM_RAID_HIT.paperKillsSinceEye or 0)
        .. " | HP seguro="..tostring(MURIM_RAID_DEFENSE and MURIM_RAID_DEFENSE.phase or "aguardando")
        .. " | Auto A04="..(a04Live:find("FORA DA RAID",1,true) and "historico - fora da raid"
            or tostring(MURIM_A04 and MURIM_A04.phase or "-"))
        .. " | lanternas (cache automatico, nao HUD)="..tostring(MURIM_A04 and MURIM_A04.lampCount or 0).."/3"
        .. " | A04 mundo agora="..tostring(a04Live)
        .. " | A04 diagnostico="..tostring(MURIM_A04 and MURIM_A04.debugStatus or "ainda sem leitura")
end
function MURIM_A01.reset(why)
    MURIM_A01.attempts = setmetatable({}, {__mode="k"})
    MURIM_A01.pending = nil
    MURIM_A01.lastTickAt = 0
    MURIM_A01.lastMoveAt = 0
    MURIM_A01.lastTarget = nil
    MURIM_A01.lastTargetHp = nil
    MURIM_A01.lastDamageAt = 0
    MURIM_A01.damageObserved = false
    MURIM_A01.defeatedObserved = false
    MURIM_A01.patrolIndex = 1
    MURIM_A01.patrolDone = false
    MURIM_A01.patrolBlocked = false
    MURIM_A01.lastPatrolWarnAt = 0
    MURIM_A01.phase = "procurando objetivos"
    MURIM_A01.lastAction = "nenhuma"
    MURIM_A01.lastResult = "nenhum"
    MURIM_TRACE.add("INFO", "AutoA01", "Estado reiniciado: " .. tostring(why or "nova entrada") .. "; interacoes automaticas=" .. tostring(MURIM_A01.enabled))
end
function MURIM_A01.kind(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return nil end
    local act = tostring(prompt.ActionText or ""):lower()
    local obj = tostring(prompt.ObjectText or ""):lower()
    if act:find("refill your lantern", 1, true) and obj:find("oil jar", 1, true) then return "Oil Jar" end
    if act:find("take the offering", 1, true) and obj:find("offering bowl", 1, true) then return "Offering Bowl" end
    return nil
end
function MURIM_A01.onPromptTriggered(prompt)
    if not MURIM_A01.kind(prompt) then return false end
    local automatic = MURIM_A01.pending and MURIM_A01.pending.prompt == prompt
    if automatic then
        MURIM_A01.triggerConfirmed = true
        MURIM_TRACE.add("EVIDENCIA", "AutoA01", "Evento PromptTriggered recebido para " .. MURIM_A01.kind(prompt) .. ". Ainda verificando efeito no mundo.")
    end
    return automatic == true
end
function MURIM_A01.scanEnemies(root, foePredicate, alivePredicate, origin)
    local folder = workspace:FindFirstChild("Murim_NPCs")
    local countNear, countFar, nearest, nearestDist = 0, 0, nil, math.huge
    if not folder or not root then return countNear, countFar, nearest, nearestDist end
    for _, npc in ipairs(folder:GetChildren()) do
        if npc:IsA("Model") and typeof(foePredicate)=="function" and foePredicate(npc)
            and typeof(alivePredicate)=="function" and alivePredicate(npc) then
            local p = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart or npc:FindFirstChildWhichIsA("BasePart", true)
            if p then
                local d=(p.Position-root.Position).Magnitude
                if not origin or p.Position.Z < origin.Z + 242 then
                    if d<=250 then countNear += 1 elseif d<=490 then countFar += 1 end
                    if d<nearestDist and d<=490 then nearest, nearestDist=p, d end
                end
            end
        end
    end
    return countNear, countFar, nearest, nearestDist
end
function MURIM_A01.safeWarp(root, targetPosition, char, label)
    -- Sem piso confirmado por raycast, NAO teleportar.
    if not root or not root.Parent or not targetPosition then return false end
    if math.abs(targetPosition.X-40000)>2900 then
        MURIM_TRACE.add("AVISO","NavegacaoA01","Destino fora da arena; movimento bloqueado.", 15)
        return false
    end
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances=char and {char} or {}
    params.IgnoreWater=true
    local hit=workspace:Raycast(targetPosition+Vector3.new(0,8,0),Vector3.new(0,-46,0),params)
    local surfaceName = hit and hit.Instance and hit.Instance.Name:lower() or ""
    local wrongSurface = surfaceName:find("ceiling",1,true) or surfaceName:find("roof",1,true)
        or surfaceName:find("canopy",1,true) or surfaceName:find("overdoor",1,true)
    if not hit or not hit.Instance or not hit.Instance.CanCollide
        or hit.Normal.Y < 0.65 or wrongSurface
        or hit.Position.Y > targetPosition.Y + 3
        or targetPosition.Y - hit.Position.Y > 16 then
        if os.clock()-MURIM_A01.noFloorWarnAt>8 then
            MURIM_A01.noFloorWarnAt=os.clock()
            MURIM_TRACE.add("AVISO","NavegacaoA01",string.format("Sem piso seguro para %s; destino=(%.0f,%.0f,%.0f). Movimento NAO executado.",tostring(label),targetPosition.X,targetPosition.Y,targetPosition.Z))
            MURIM_TRACE.suggest("Nao foi possivel confirmar um piso no caminho do objetivo. Inspecione a raid e verifique se a superficie esta carregada.")
        end
        return false
    end
    local destination=hit.Position+Vector3.new(0,3.5,0)
    if (destination-root.Position).Magnitude>320 then
        MURIM_TRACE.add("AVISO","NavegacaoA01","Movimento superior a 320 studs bloqueado por seguranca.", 10)
        return false
    end
    local distanceBefore=(destination-root.Position).Magnitude
    root.CFrame=CFrame.new(destination)
    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    MURIM_A01.lastMoveAt=os.clock()
    MURIM_A01.lastAction="Mover para "..tostring(label)
    MURIM_TRACE.add("MOVIMENTO","AutoA01",string.format("Destino %s, distancia=%.0f, piso=%s; pos=(%.0f,%.0f,%.0f).",tostring(label),distanceBefore,hit.Instance.Name,destination.X,destination.Y,destination.Z))
    return true
end
function MURIM_A01.tick(root, raid, roomIndex, foePredicate, alivePredicate, raidOrigin)
    if not MURIM_A01.enabled or not root or roomIndex~=1 or not raid then return false end
    local now=os.clock()
    if now-MURIM_A01.lastTickAt<0.85 then return true end
    MURIM_A01.lastTickAt=now
    local room=raid:FindFirstChild("A01_Causeway",true)
    if not room then
        MURIM_TRACE.add("AVISO","AutoA01","Modelo A01 nao carregado; aguardando.", 16)
        return true
    end
    local nNear,nFar,nearestFoe,foeDist=MURIM_A01.scanEnemies(root,foePredicate,alivePredicate,raidOrigin)
    if MURIM_A01.lastTarget then
        local oldHum=MURIM_A01.lastTarget:FindFirstChildOfClass("Humanoid")
        if not MURIM_A01.lastTarget.Parent or (oldHum and oldHum.Health<=0) then
            MURIM_A01.defeatedObserved=true
            MURIM_TRACE.add("EVIDENCIA","CombateA01","Alvo anterior morreu/desapareceu: "..MURIM_A01.lastTarget.Name..". Nao prova conclusao da sala.")
            MURIM_A01.lastTarget=nil
            MURIM_A01.lastTargetHp=nil
        end
    end
    if nNear>0 then
        if MURIM_A01.pending then
            MURIM_TRACE.add("EVIDENCIA","AutoA01",string.format("Apos %s surgiram %d inimigos a <=250. Associacao temporal; causalidade nao comprovada.",MURIM_A01.pending.label,nNear),12)
        end
        MURIM_A01.phase="combate disponivel"
        MURIM_TRACE.add("EVIDENCIA","AutoA01",string.format("%d inimigo(s) validos a ate 250 studs; o ciclo de combate tem prioridade.",nNear),10)
        return false
    end
    if MURIM_A01.pending then
        local pending=MURIM_A01.pending
        if not pending.prompt or not pending.prompt.Parent or not pending.prompt.Enabled then
            MURIM_A01.lastResult="Prompt desabilitado ou removido (efeito observado)"
            MURIM_A01.phase="interacao alterou o mundo"
            MURIM_TRACE.add("EVIDENCIA","AutoA01",pending.label.." agora esta desabilitado/removido. Efeito do prompt observado; aguardando inimigos ou nova etapa.")
            MURIM_TRACE.suggest(pending.label.." mudou de estado. Procurando inimigos ou proxima interacao da sala 1.")
            MURIM_A01.pending=nil
            return true
        end
        if now-pending.at<3.5 then
            MURIM_A01.phase="aguardando resposta do prompt"
            return true
        end
        MURIM_A01.pending=nil
        MURIM_A01.lastResult="Sem mudanca do Enabled apos 3,5s; resultado nao confirmado"
        MURIM_TRACE.add("AVISO","AutoA01",pending.label.." ainda Enabled=true apos 3,5s; envio nao garante efeito. Tentativa "..tostring(MURIM_A01.attempts[pending.prompt] or 0).."/2.")
    end
    -- Prioridade: Oil Jar e Offering Bowl conhecidos; nao ativa props desconhecidos.
    local available={}
    local totalOil, totalOffering=0,0
    for _,desc in ipairs(room:GetDescendants()) do
        if desc:IsA("ProximityPrompt") then
            local kind=MURIM_A01.kind(desc)
            if kind then
                local anchor=desc:FindFirstAncestorWhichIsA("BasePart")
                if kind=="Oil Jar" and desc.Enabled then totalOil+=1 end
                if kind=="Offering Bowl" and desc.Enabled then totalOffering+=1 end
                if desc.Enabled and anchor and (MURIM_A01.attempts[desc] or 0)<2 then
                    local distance=(anchor.Position-root.Position).Magnitude
                    if distance<=310 then
                        available[#available+1]={prompt=desc,part=anchor,distance=distance,kind=kind,priority=(kind=="Oil Jar" and 1 or 2)}
                    end
                end
            end
        end
    end
    table.sort(available,function(a,b)
        if a.priority~=b.priority then return a.priority<b.priority end
        return a.distance<b.distance
    end)
    if #available>0 then
        local chosen=available[1]
        local reach=math.max(2,(chosen.prompt.MaxActivationDistance or 10)-2)
        MURIM_A01.phase="interacao disponivel: "..chosen.kind
        if chosen.distance>reach then
            if now-MURIM_A01.lastMoveAt<1.7 then return true end
            MURIM_TRACE.add("DECISAO","AutoA01",string.format("Nenhum inimigo a <=250; indo ate %s (distancia %.0f). Oleos ativos=%d; oferendas ativas=%d.",chosen.kind,chosen.distance,totalOil,totalOffering),7)
            local ok=MURIM_A01.safeWarp(root,chosen.part.Position,root.Parent,chosen.kind)
            if not ok then
                -- Nao repetir teleportes sem piso; pedir acao assistida.
                MURIM_A01.attempts[chosen.prompt]=2
                MURIM_TRACE.add("AVISO","AutoA01",chosen.kind.." marcado para inspecao manual: piso/destino nao confirmado.")
            end
            return true
        end
        MURIM_A01.attempts[chosen.prompt]=(MURIM_A01.attempts[chosen.prompt] or 0)+1
        local attempt=MURIM_A01.attempts[chosen.prompt]
        MURIM_A01.lastAction="Acionar "..chosen.kind
        MURIM_TRACE.add("DECISAO","AutoA01",string.format("Acionar %s, tentativa %d/2; dist=%.1f, Hold=%.1fs, Enabled=%s.",chosen.kind,attempt,chosen.distance,chosen.prompt.HoldDuration,tostring(chosen.prompt.Enabled)))
        MURIM_A01.pending={prompt=chosen.prompt,at=os.clock(),label=chosen.kind,via="pendente"}
        MURIM_A01.triggerConfirmed=false
        local ok,via=tryHallowGuestPrompt(chosen.prompt)
        MURIM_A01.pending.via=via
        MURIM_A01.phase="aguardando resultado da interacao"
        MURIM_TRACE.add(ok and "ACAO" or "ERRO","AutoA01","Interacao "..chosen.kind.." via "..tostring(via).."; pcall="..tostring(ok)..". Esperando efeito no mundo; nao e confirmacao do servidor.")
        if not ok then
            MURIM_A01.lastResult="Falha de executor ao acionar "..chosen.kind
        end
        return true
    end
    if nFar>0 and nearestFoe and foeDist>250 and foeDist<=490 then
        if now-MURIM_A01.lastMoveAt>=2.0 then
            MURIM_A01.phase="indo ate inimigos distantes"
            MURIM_TRACE.add("DECISAO","AutoA01",string.format("%d inimigo(s) entre 250-490 studs; aproximando do grupo (distancia %.0f), sem atacar fora de alcance.",nFar,foeDist),8)
            -- Fica a distancia prudente do inimigo, em vez de teleportar em cima dele.
            local towards=(root.Position-nearestFoe.Position)
            local horizontal=Vector3.new(towards.X,0,towards.Z)
            local offset=horizontal.Magnitude>1 and horizontal.Unit*100 or Vector3.new(0,0,-100)
            MURIM_A01.safeWarp(root,nearestFoe.Position+offset,root.Parent,"zona de inimigos")
        end
        return true
    end
    -- Patrulha limitada: apos os objetivos conhecidos, explorar o corredor
    -- da A01 ate o ponto onde o teste observou os primeiros fantasmas.
    -- Nenhuma sala e dada como concluida so por percorrer o corredor.
    if raidOrigin and totalOil == 0 and totalOffering == 0 and nNear == 0 and nFar == 0 then
        local checkpoints = {215, 244} -- ate a entrada A02; nunca atraves de telhado de A02
        if MURIM_A01.patrolBlocked then
            return true -- sem piso confirmado: bloqueia avance e novas tentativas.
        end
        if not MURIM_A01.patrolDone then
            -- Se o personagem ja avancou manualmente, nunca recuar na patrulha.
            while MURIM_A01.patrolIndex <= #checkpoints
                and root.Position.Z >= raidOrigin.Z + checkpoints[MURIM_A01.patrolIndex] - 12 do
                MURIM_A01.patrolIndex += 1
            end
            if MURIM_A01.patrolIndex <= #checkpoints then
                MURIM_A01.phase = "patrulhando corredor A01"
                if now - MURIM_A01.lastMoveAt >= 2.2 then
                    local step = checkpoints[MURIM_A01.patrolIndex]
                    local target = Vector3.new(raidOrigin.X, raidOrigin.Y + 3, raidOrigin.Z + step)
                    MURIM_TRACE.add("DECISAO", "PatrulhaA01", string.format(
                        "Sem inimigos/objetivos; explorando corredor: ponto %d/%d, Z=%.0f. Somente destino com piso seguro.",
                        MURIM_A01.patrolIndex, #checkpoints, target.Z), 2)
                    if MURIM_A01.safeWarp(root, target, root.Parent, "patrulha A01") then
                        -- Espera streaming/carregamento antes de procurar novo alvo.
                        MURIM_A01.patrolIndex += 1
                    else
                        MURIM_A01.patrolBlocked = true
                        MURIM_A01.phase = "patrulha bloqueada: sem piso"
                        MURIM_TRACE.add("AVISO", "PatrulhaA01", "Patrulha bloqueada: piso nao confirmado. Nao saltar para proxima sala.")
                        MURIM_TRACE.suggest("Piso inseguro na patrulha A01. Inspecione a raid e informe a coordenada/parada; o sistema nao tentara atravessar um vao.")
                    end
                end
                return true
            end
            MURIM_A01.patrolDone = true
            MURIM_TRACE.add("INFO", "PatrulhaA01", "Ponte e entrada do Coffin Lodge alcançadas. A02 continuara por seus proprios objetivos, sem salto entre salas.")
        end
    end
    if now-MURIM_A01.lastNoTaskAt>12 then
        MURIM_A01.lastNoTaskAt=now
        MURIM_A01.phase="sem objetivo comprovado"
        MURIM_TRACE.add("DIAGNOSTICO","AutoA01",string.format("Sem inimigos <=250, sem objetivos acionaveis; Oil Jar enabled=%d, Offering enabled=%d; inimigos 250-490=%d. Nao avancar de sala sem evidencias.",totalOil,totalOffering,nFar))
        MURIM_TRACE.suggest("A01 sem prompt disponivel e sem inimigo ao alcance; use Inspecionar raid. Nenhuma sala foi considerada concluida automaticamente.")
    end
    return false
end
function MURIM_A01.observeCombat(npc, remoteAvailable, eventSent)
    if not npc then return end
    local now=os.clock()
    local hum=npc:FindFirstChildOfClass("Humanoid")
    local hp=hum and hum.Health or -1
    if MURIM_A01.lastTarget~=npc then
        if MURIM_A01.lastTarget then
            local previousHum=MURIM_A01.lastTarget:FindFirstChildOfClass("Humanoid")
            if not MURIM_A01.lastTarget.Parent or (previousHum and previousHum.Health<=0) then
                MURIM_A01.defeatedObserved=true
                MURIM_TRACE.add("EVIDENCIA","CombateA01","Alvo anterior derrotado ou removido: "..MURIM_A01.lastTarget.Name)
            end
        end
        MURIM_A01.lastTarget=npc
        MURIM_A01.lastTargetHp=hp
        MURIM_A01.lastDamageAt=now
        MURIM_A01.phase="combatendo "..npc.Name
        MURIM_TRACE.add("DECISAO","CombateA01",string.format("Alvo=%s; HP=%.0f; remoto=%s; FireServer sem erro=%s. Dano ainda nao confirmado.",npc.Name,hp,tostring(remoteAvailable),tostring(eventSent)))
        return
    end
    if hp>=0 and MURIM_A01.lastTargetHp and hp<MURIM_A01.lastTargetHp-0.1 then
        MURIM_A01.damageObserved=true
        MURIM_A01.lastDamageAt=now
        MURIM_A01.lastResult="HP do inimigo diminuiu"
        if now-MURIM_A01.lastCombatReportAt>=3 then
            MURIM_A01.lastCombatReportAt=now
            MURIM_TRACE.add("EVIDENCIA","CombateA01",string.format("HP %s caiu de %.0f para %.0f; dano observado.",npc.Name,MURIM_A01.lastTargetHp,hp))
        end
    elseif now-MURIM_A01.lastDamageAt>=8 and now-MURIM_A01.lastNoEffectAt>=8 then
        MURIM_A01.lastNoEffectAt=now
        MURIM_TRACE.add("AVISO","CombateA01",string.format("8s sem queda de HP observada em %s (HP=%.0f). Remoto presente=%s; disparo pcall=%s. Verifique ataque/alcance.",npc.Name,hp,tostring(remoteAvailable),tostring(eventSent)))
    end
    MURIM_A01.lastTargetHp=hp
end

local function gateDistance(angle)
    return math.abs((angle + 180) % 360 - 180)
end


-- ============================================================================
-- 🛸 FARM POSITIONING & NOCLIP HELPERS (FILE-LEVEL SCOPE TO SAVE LOCAL REGISTERS)
-- ============================================================================
local farmPositionMode = "Above" -- "Above" (flutua acima) ou "Under" (abaixo do solo)
local farmDistance = 8.5
local heightUnder = 8.5
local lyingRotation = CFrame.Angles(math.rad(-90), 0, 0)
local updateFarmPositionDisplay = nil -- callback to refresh UI buttons/labels


local function updateFarmSettings(mode, dist)
    if mode == "Above" or mode == "Under" then
        farmPositionMode = mode
    end
    if dist then
        farmDistance = math.max(2.0, math.min(25.0, dist))
    end
    local d = math.abs(farmDistance or 8.5)
    if farmPositionMode == "Above" then
        heightUnder = d
        lyingRotation = CFrame.Angles(math.rad(-90), 0, 0)
    else
        heightUnder = -d
        lyingRotation = CFrame.Angles(math.rad(90), 0, 0)
    end
    if updateFarmPositionDisplay then
        pcall(updateFarmPositionDisplay)
    end
end


local function getFarmOffsetCFrame()
    local d = math.abs(farmDistance or 8.5)
    if farmPositionMode == "Above" then
        -- Flutua acima da cabeça, de bruços e olhando para o chão
        return CFrame.new(0, d, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    else
        -- Fica abaixo do chão, de costas e olhando para o monstro
        return CFrame.new(0, -d, 0) * CFrame.Angles(math.rad(90), 0, 0)
    end
end



-- V16 - The Coffin Lodge: progressao por objetivo da instancia UNICA.
-- Nao exige que chave tenha nome "Key": observa prompt de caixao, porta e mochila.
-- A porta aberta e sinal de passagem; a localizacao da chave continua indeterminada
-- enquanto nenhum atributo/item explicito estiver replicado.
MURIM_A02 = {
    attempts = setmetatable({}, {__mode="k"}), pending = nil,
    lastTick = 0, lastMove = 0, lastReport = 0,
    openedObserved = 0, doorReported = false, keyReported = false,
    phase = "aguardando", lastAction = "nenhuma", gateApproach = false,
}
function MURIM_A02.reset()
    MURIM_A02.attempts = setmetatable({}, {__mode="k"})
    MURIM_A02.pending = nil
    MURIM_A02.lastTick = 0
    MURIM_A02.lastMove = 0
    MURIM_A02.lastReport = 0
    MURIM_A02.openedObserved = 0
    MURIM_A02.doorReported = false
    MURIM_A02.keyReported = false
    MURIM_A02.gateApproach = false
    MURIM_A02.phase = "caixoes pendentes"
end
local function getV16ModelPosition(object)
    if not object then return nil end
    if object:IsA("BasePart") then return object.Position end
    if object:IsA("Model") then
        local part = object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart",true)
        if part then return part.Position end
    end
    return nil
end
function MURIM_A02.getObservables(ply, lodge, origin)
    local prompts = {}
    local door, doorPosition, doorOpen, gatePrompt = nil,nil,nil,nil
    local keyObjects = {}
    if lodge then
        for _, object in ipairs(lodge:GetDescendants()) do
            if object:IsA("ProximityPrompt") then
                local act = (object.ActionText or ""):lower()
                local objText = (object.ObjectText or ""):lower()
                local coffin = object:FindFirstAncestor("HallowCoffin")
                if coffin and act == "open" then
                    local parentPart = object:FindFirstAncestorWhichIsA("BasePart")
                    if parentPart then
                        prompts[#prompts+1] = {prompt=object, part=parentPart, coffin=coffin,
                            pos=parentPart.Position}
                    end
                elseif act:find("open",1,true) and objText:find("back gate",1,true) then
                    gatePrompt = object
                elseif act:find("key",1,true) or act:find("collect",1,true) and objText:find("key",1,true) then
                    keyObjects[#keyObjects+1] = object
                end
            elseif object:IsA("Model") and object.Name == "HallowDoor" then
                local pos = getV16ModelPosition(object)
                if pos and pos.Z >= origin.Z + 366 and (not doorPosition or pos.Z > doorPosition.Z) then
                    door,doorPosition = object,pos
                    doorOpen = object:GetAttribute("Open")
                end
            elseif object.Name:lower():find("key",1,true) and (object:IsA("BasePart") or object:IsA("Tool")) then
                keyObjects[#keyObjects+1] = object
            end
        end
    end
    -- Estado extra: Backpack e Character, apenas evidencias replicadas.
    local keyInInventory = false
    for _, container in ipairs({ply and ply:FindFirstChildOfClass("Backpack"),ply and ply.Character}) do
        if container then
            for _,child in ipairs(container:GetChildren()) do
                if child.Name:lower():find("key",1,true) then keyInInventory = true end
            end
        end
    end
    return prompts,door,doorPosition,doorOpen,gatePrompt,keyObjects,keyInInventory
end
function MURIM_A02.tick(ply, root, raid, origin)
    if not root or not raid then return true end
    local now=os.clock()
    if now-MURIM_A02.lastTick < 0.9 then return true end
    MURIM_A02.lastTick=now
    local lodge=raid:FindFirstChild("A02_CoffinLodge",true)
    if not lodge then
        MURIM_TRACE.add("AVISO","AutoA02","Coffin Lodge ainda sem modelo carregado.",15)
        return true
    end
    local prompts,gate,gatePosition,gateOpen,gatePrompt,keyObjects,keyInInventory =
        MURIM_A02.getObservables(ply,lodge,origin)
    local enabled,disabled=0,0
    for _,p in ipairs(prompts) do
        if p.prompt.Enabled then enabled+=1 else disabled+=1 end
    end
    if keyInInventory and not MURIM_A02.keyReported then
        MURIM_A02.keyReported=true
        MURIM_TRACE.add("EVIDENCIA","AutoA02","Item com nome Key visto no inventario. Confirmar se corresponde ao Coffin Lodge.")
    end
    if MURIM_A02.pending then
        local pending=MURIM_A02.pending
        if not pending.prompt.Parent or not pending.prompt.Enabled then
            MURIM_A02.openedObserved += 1
            MURIM_TRACE.add("EVIDENCIA","Caixao",string.format(
                "Caixao (X=%.0f,Z=%.0f): prompt Open agora desabilitado/removido. Abertura observavel, chave ainda nao comprovada.",
                pending.pos.X,pending.pos.Z))
            MURIM_A02.pending=nil
        elseif now-pending.at < 3.2 then
            return true
        else
            MURIM_TRACE.add("AVISO","Caixao", "Prompt Open nao mudou em 3s no caixao Z="..string.format("%.0f",pending.pos.Z).."; tentando proximo/aguardando.")
            MURIM_A02.pending=nil
        end
    end
    if gateOpen == true then
        if not MURIM_A02.doorReported then
            MURIM_A02.doorReported=true
            MURIM_TRACE.add("EVIDENCIA","BackGate","A02: HallowDoor.Open=true, pos Z="..string.format("%.0f",gatePosition and gatePosition.Z or 0)..". Porta aberta observada; nao prova como chave foi obtida.")
        end
        MURIM_A02.phase="passagem para A03 liberada"
        local target
        if root.Position.Z < origin.Z + 375 then
            target=Vector3.new(origin.X,origin.Y+3,origin.Z+378) -- antes da porta
        elseif root.Position.Z < origin.Z + 407 then
            target=Vector3.new(origin.X,origin.Y+3,origin.Z+409) -- apos a porta, inicio A03
        end
        if target and now-MURIM_A02.lastMove>=2.3 then
            MURIM_A02.lastMove=now
            local moved=MURIM_A01.safeWarp(root,target,root.Parent,"passagem Back gate A02")
            if not moved then MURIM_TRACE.add("AVISO","BackGate","Nao consegui confirmar piso da passagem. Avance manualmente; sem teleporte cego.",9) end
        end
        return true
    end
    if gatePrompt and gatePrompt.Parent and gatePrompt.Enabled and keyInInventory then
        local anchor=gatePrompt:FindFirstAncestorWhichIsA("BasePart")
        if anchor then
            local dist=(root.Position-anchor.Position).Magnitude
            if dist > (gatePrompt.MaxActivationDistance or 11)-2 then
                if now-MURIM_A02.lastMove>=2 then
                    MURIM_A02.lastMove=now
                    MURIM_A01.safeWarp(root,anchor.Position,root.Parent,"Back gate")
                end
            else
                local ok,via=tryHallowGuestPrompt(gatePrompt)
                MURIM_TRACE.add(ok and "ACAO" or "AVISO","BackGate","Acionar Open / Back gate; via="..tostring(via).."; aguardar Open=true.",6)
            end
            return true
        end
    end
    -- Key object may be dynamic and not named Key. Only act on explicit Key object/prompts.
    for _,obj in ipairs(keyObjects) do
        local prompt=obj:IsA("ProximityPrompt") and obj or obj:FindFirstChildWhichIsA("ProximityPrompt",true)
        local part=prompt and prompt:FindFirstAncestorWhichIsA("BasePart") or (obj:IsA("BasePart") and obj or nil)
        if part and prompt and prompt.Enabled then
            MURIM_A02.phase="chave visivel"
            local d=(part.Position-root.Position).Magnitude
            if d > (prompt.MaxActivationDistance or 9)-2 then
                if now-MURIM_A02.lastMove>2 then
                    MURIM_A02.lastMove=now
                    MURIM_A01.safeWarp(root,part.Position,root.Parent,"objeto-chave A02")
                end
            else
                local ok,via=tryHallowGuestPrompt(prompt)
                MURIM_TRACE.add(ok and "ACAO" or "AVISO","Chave","Tentativa de coletar objeto de chave via "..tostring(via).."; validar estado da porta.",7)
            end
            return true
        end
    end
    local available={}
    for _,info in ipairs(prompts) do
        if info.prompt.Enabled and (MURIM_A02.attempts[info.prompt] or 0)<2 then
            info.distance=(info.pos-root.Position).Magnitude
            available[#available+1]=info
        end
    end
    table.sort(available,function(a,b) return a.distance<b.distance end)
    if #available>0 then
        MURIM_A02.phase="abrindo caixoes"
        local item=available[1]
        local reach=math.max(2,(item.prompt.MaxActivationDistance or 9)-2)
        if item.distance>reach then
            if now-MURIM_A02.lastMove>=1.8 then
                MURIM_A02.lastMove=now
                local ok=MURIM_A01.safeWarp(root,item.pos,root.Parent,"caixao A02")
                if not ok then
                    MURIM_A02.attempts[item.prompt]=2
                    MURIM_TRACE.add("AVISO","Caixao","Caixao X="..string.format("%.0f",item.pos.X)..",Z="..string.format("%.0f",item.pos.Z).." bloqueado: piso nao confiavel.")
                end
            end
            return true
        end
        MURIM_A02.attempts[item.prompt]=(MURIM_A02.attempts[item.prompt] or 0)+1
        local ok,via=tryHallowGuestPrompt(item.prompt)
        MURIM_A02.lastAction="Abrir caixao Z="..string.format("%.0f",item.pos.Z)
        MURIM_A02.pending={prompt=item.prompt,at=os.clock(),pos=item.pos}
        MURIM_TRACE.add(ok and "ACAO" or "ERRO","Caixao",string.format(
            "Open em HallowCoffin X=%.0f,Z=%.0f via %s, tentativa=%d/2, sucesso do envio=%s. Chave nao confirmada.",
            item.pos.X,item.pos.Z,tostring(via),MURIM_A02.attempts[item.prompt],tostring(ok)))
        return true
    end
    MURIM_A02.phase="aguardando porta ou chave"
    if gatePrompt and gatePrompt.Parent and gatePrompt.Enabled and now-MURIM_A02.lastMove > 6 then
        local anchor=gatePrompt:FindFirstAncestorWhichIsA("BasePart")
        MURIM_A02.lastMove=now
        if anchor then
            local d=(root.Position-anchor.Position).Magnitude
            if d>(gatePrompt.MaxActivationDistance or 11)-2 then
                MURIM_A01.safeWarp(root,anchor.Position,root.Parent,"porta final A02")
            else
                local ok,via=tryHallowGuestPrompt(gatePrompt)
                MURIM_TRACE.add(ok and "ACAO" or "AVISO","BackGate","Testando gate apos caixoes: "..tostring(via)..". Open=true ainda nao observado; servidor pode controlar chave ocultamente.",6)
            end
        end
        return true
    end
    if now-MURIM_A02.lastReport>12 then
        MURIM_A02.lastReport=now
        MURIM_TRACE.add("DIAGNOSTICO","AutoA02",string.format(
            "Caixoes com prompt: %d ativos, %d inativos; aberturas observadas nesta execucao=%d; objetos chave=%d; inventarioKey=%s; gateOpen=%s. Nenhum salto de sala.",
            enabled,disabled,MURIM_A02.openedObserved,#keyObjects,tostring(keyInInventory),tostring(gateOpen)))
        MURIM_TRACE.suggest("Se Back gate ainda esta fechada, inspecione o resultado do ultimo caixao. O servidor pode guardar a chave sem nome exposto ao cliente.")
    end
    return true
end


-- V16: combate auditado. Um disparo sem erro NAO equivale a dano.
-- Cada Model tem seu proprio historico e cooldown: nao insistir em efígies imunes.
MURIM_RAID_HIT = {
    records=setmetatable({},{__mode="k"}), lastTarget=nil,
    lastSeenEyes=nil, eyes=nil, lastHudAt=0, skipCount=0, damageCount=0,
    lastZeroNotice=false, lastTargetScan=0,
    yardObjective=false, hudObjective="desconhecido", hudObjectiveAt=0,
    bossFocus=nil, paperPermanentSkips=0,
    eyesLastChangeAt=0, paperKillsSinceEye=0, paperKillsTotal=0,
    paperSlots={}, paperStallUntil=0, lastPaperStallAt=0,
    -- V18I: varredura automatica quando RESTA UM objetivo na HUD.
    paperSweepTarget=nil, paperSweepAt=0, paperSweepHit=false,
    paperSweepTried=setmetatable({},{__mode="k"}), paperSweepLastReport=0,
}
function MURIM_RAID_HIT.reset()
    MURIM_RAID_HIT.records=setmetatable({},{__mode="k"})
    MURIM_RAID_HIT.lastTarget=nil
    MURIM_RAID_HIT.lastSeenEyes=nil
    MURIM_RAID_HIT.eyes=nil
    MURIM_RAID_HIT.lastHudAt=0
    MURIM_RAID_HIT.skipCount=0
    MURIM_RAID_HIT.damageCount=0
    MURIM_RAID_HIT.lastZeroNotice=false
    MURIM_RAID_HIT.yardObjective=false
    MURIM_RAID_HIT.hudObjective="desconhecido"
    MURIM_RAID_HIT.hudObjectiveAt=0
    MURIM_RAID_HIT.bossFocus=nil
    MURIM_RAID_HIT.paperPermanentSkips=0
    MURIM_RAID_HIT.eyesLastChangeAt=0
    MURIM_RAID_HIT.paperKillsSinceEye=0
    MURIM_RAID_HIT.paperKillsTotal=0
    MURIM_RAID_HIT.paperSlots={}
    MURIM_RAID_HIT.paperStallUntil=0
    MURIM_RAID_HIT.lastPaperStallAt=0
    MURIM_RAID_HIT.paperSweepTarget=nil
    MURIM_RAID_HIT.paperSweepAt=0
    MURIM_RAID_HIT.paperSweepHit=false
    MURIM_RAID_HIT.paperSweepTried=setmetatable({},{__mode="k"})
    MURIM_RAID_HIT.paperSweepLastReport=0
end
function MURIM_RAID_HIT.isSpecialPaper(npc, area)
    return area==3 and npc and npc:IsA("Model")
        and npc.Name:lower():find("paper effigy",1,true)~=nil
        and npc:FindFirstChildOfClass("Humanoid")~=nil
end
-- V18E: o log mostrou muitas mortes em A03 com HUD 3->2 e depois parada.
-- Nao sabemos se a tag HallowWatched e o objetivo; tratamos apenas como
-- sinal exploratorio, sem inferir conclusao. A posicao identifica spawns repetidos.
function MURIM_RAID_HIT.paperSlot(npc)
    local part=npc and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
        or npc:FindFirstChildWhichIsA("BasePart",true))
    if not part then return nil end
    return string.format("%d:%d:%d", math.floor(part.Position.X/7),
        math.floor(part.Position.Y/10),math.floor(part.Position.Z/7))
end
function MURIM_RAID_HIT.paperScore(npc,distance)
    if not MURIM_RAID_HIT.isSpecialPaper(npc,3) then return distance end
    local slot=MURIM_RAID_HIT.paperSlot(npc)
    local seen=MURIM_RAID_HIT.paperSlots[slot or "-"]
    if seen and os.clock()<(seen.skipUntil or 0) then return math.huge end
    local cs=game:GetService("CollectionService")
    local tagged=cs:HasTag(npc,"HallowWatched") or npc:GetAttribute("HallowId")~=nil
    -- A tag nao prova qual effigy conta. Dar prioridade exploratoria, nao certeza.
    return distance+(seen and seen.kills or 0)*22-(tagged and 35 or 0)
end
function MURIM_RAID_HIT.paperStallCheck()
    local now=os.clock()
    if MURIM_RAID_HIT.yardObjective or not MURIM_RAID_HIT.eyes
        or MURIM_RAID_HIT.eyes<=1 then return end
    if now<(MURIM_RAID_HIT.paperStallUntil or 0) then return end
    if MURIM_RAID_HIT.eyesLastChangeAt>0 and now-MURIM_RAID_HIT.eyesLastChangeAt>27
        and MURIM_RAID_HIT.paperKillsSinceEye>=7 and now-MURIM_RAID_HIT.lastPaperStallAt>15 then
        MURIM_RAID_HIT.paperStallUntil=now+8
        MURIM_RAID_HIT.lastPaperStallAt=now
        MURIM_TRACE.add("AVISO","PaintedEyes",string.format(
            "HUD presa em %d left apos %d mortes observadas desde a ultima mudanca. Pausa de 8s em Paper Effigy; revisar HallowWatched/portas. Mortes nao equivalem a objetivo.",
            MURIM_RAID_HIT.eyes,MURIM_RAID_HIT.paperKillsSinceEye))
        MURIM_TRACE.suggest("A03 Painted eyes travada: coletar HallowWatched e HallowId, verificar se houve transicao real na HUD e evitar repetir o mesmo spawn indefinidamente.")
        MURIM_RAID_HIT.paperKillsSinceEye=0
    end
end
function MURIM_RAID_HIT.canConsider(npc, area, normalFilter)
    if not npc or not npc.Parent or not npc:IsA("Model") then return false end
    local hum=npc:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 then return false end
    local name=npc.Name:lower()
    -- A04 e furtividade: nunca atacar o Watchman, mesmo que o filtro generico aceite.
    if name:find("watchman",1,true) or name:find("faceless",1,true)
        or name:find("red sedan",1,true) or name:find("procession",1,true) then return false end
    -- Nao gastar mais ataques em bonecos quando a missao ja passou a pedir o patio.
    if area==3 and name:find("paper effigy",1,true) then
        if MURIM_RAID_HIT.yardObjective or MURIM_RAID_HIT.eyes==0 then return false end
        if MURIM_RAID_HIT.eyes~=1 then
            if os.clock()<(MURIM_RAID_HIT.paperStallUntil or 0) then return false end
            local slot=MURIM_RAID_HIT.paperSlot(npc)
            local slotRecord=slot and MURIM_RAID_HIT.paperSlots[slot]
            if slotRecord and os.clock()<(slotRecord.skipUntil or 0) then return false end
        end
        -- Se o chefe ja entrou em combate, conservar o foco ate morrer/sumir.
        local boss=MURIM_RAID_HIT.bossFocus
        if boss and boss.Parent then
            local bossHum=boss:FindFirstChildOfClass("Humanoid")
            if bossHum and bossHum.Health>0 then return false end
        end
    end
    local record=MURIM_RAID_HIT.records[npc]
    if area==6 and name:find("cerberus",1,true) then
        -- Recovery pauses and boss phases are not grounds for abandoning a live boss.
        if record then record.skipUntil=0;record.permanentSkip=false end
        return true
    end
    local lastEyePending=area==3 and MURIM_RAID_HIT.eyes==1
        and not MURIM_RAID_HIT.yardObjective and MURIM_RAID_HIT.isSpecialPaper(npc,area)
    if record and record.permanentSkip and not lastEyePending then return false end
    if record and os.clock()< (record.skipUntil or 0) and not lastEyePending then return false end
    if record and record.skipUntil and record.skipUntil>0 and os.clock()>=record.skipUntil then
        record.skipUntil=0
        record.attempts=0
        record.lastDamageAt=os.clock()
        MURIM_TRACE.add("INFO","DanoRaid","Retestando apos cooldown de invulnerabilidade: "..npc.Name..". Ainda nao provar dano.",9)
    end
    return normalFilter or MURIM_RAID_HIT.isSpecialPaper(npc,area)
end
-- V18I: quando a HUD ainda diz "1 left", visitar cada Paper Effigy vivo da A03.
-- O HallowWatched ajuda a ordenar, mas NAO comprova que aquele mob pontua.
-- Nao usar o filtro generico, skip permanente nem slot skip para esta verificacao.
function MURIM_RAID_HIT.selectLastEyePaper(root, origin)
    if not root or not origin or MURIM_RAID_HIT.yardObjective
        or MURIM_RAID_HIT.eyes~=1 then return nil end
    local folder=workspace:FindFirstChild("Murim_NPCs")
    if not folder then return nil end
    local cs=game:GetService("CollectionService")
    local candidates, alive = {}, {}
    for _,npc in ipairs(folder:GetChildren()) do
        if MURIM_RAID_HIT.isSpecialPaper(npc,3) then
            local hum=npc:FindFirstChildOfClass("Humanoid")
            local part=npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                or npc:FindFirstChildWhichIsA("BasePart",true)
            if hum and hum.Health>0 and part
                and math.abs(part.Position.X-origin.X)<145
                and isHallowEnemyInArea(part.Position,origin,3) then
                alive[npc]=true
                candidates[#candidates+1]={npc=npc,dist=(part.Position-root.Position).Magnitude,
                    watched=cs:HasTag(npc,"HallowWatched") or npc:GetAttribute("HallowId")~=nil,
                    tried=MURIM_RAID_HIT.paperSweepTried[npc]}
            end
        end
    end
    local now=os.clock()
    local current=MURIM_RAID_HIT.paperSweepTarget
    if current and alive[current] then
        local rec=MURIM_RAID_HIT.records[current]
        if rec and rec.didDamage and (rec.lastDamageAt or 0)>MURIM_RAID_HIT.paperSweepAt then
            MURIM_RAID_HIT.paperSweepHit=true
        end
        local lastDamage=rec and rec.lastDamageAt or 0
        if (MURIM_RAID_HIT.paperSweepHit and now-lastDamage<=9)
            or (not MURIM_RAID_HIT.paperSweepHit and now-MURIM_RAID_HIT.paperSweepAt<=4.5) then
            return current -- Dano REAL: continuar batendo ate morrer; sem dano: proximo alvo.
        end
        MURIM_RAID_HIT.paperSweepTried[current]=now
        -- A lista foi montada antes deste registro: atualizar a prioridade
        -- AGORA, ou o alvo atual seria escolhido novamente na mesma rodada.
        for _,candidate in ipairs(candidates) do
            if candidate.npc==current then candidate.tried=now; break end
        end
        MURIM_TRACE.add("INFO","PaintedEyes",
            "HUD 1 left: Paper testado sem dano recente; passando ao proximo Paper vivo. Nao marcado como derrotado.",3)
    end
    MURIM_RAID_HIT.paperSweepTarget=nil
    MURIM_RAID_HIT.paperSweepHit=false
    if #candidates==0 then
        if now-(MURIM_RAID_HIT.paperSweepLastReport or 0)>=7 then
            MURIM_RAID_HIT.paperSweepLastReport=now
            MURIM_TRACE.add("AVISO","PaintedEyes",
                "HUD 1 left, mas nenhum Paper Effigy vivo carregado na A03. Nao declarar conclusao; continuar procurando.")
        end
        return nil
    end
    -- Primeiro os ainda nao visitados; em seguida, os menos recentemente testados.
    -- Se tiverem a mesma prioridade, tentar HallowWatched e entao proximidade.
    table.sort(candidates,function(a,b)
        if (a.tried==nil)~=(b.tried==nil) then return a.tried==nil end
        if a.tried and b.tried and a.tried~=b.tried then return a.tried<b.tried end
        if a.watched~=b.watched then return a.watched end
        return a.dist<b.dist
    end)
    local chosen=candidates[1]
    MURIM_RAID_HIT.paperSweepTarget=chosen.npc
    MURIM_RAID_HIT.paperSweepAt=now
    MURIM_TRACE.add("DECISAO","PaintedEyes",string.format(
        "HUD 1 left: TESTE AUTOMATICO Paper Effigy (%d vivos); teleporte ao alvo, atacar, manter se HP cair; alternar se imune. Dist=%.0f, watched=%s.",
        #candidates,chosen.dist,tostring(chosen.watched)))
    return chosen.npc
end
function MURIM_RAID_HIT.checkHealth(npc, area)
    if not npc or not npc.Parent then return false end
    local hum=npc:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 then return false end
    local now=os.clock()
    local nameLow=npc.Name:lower()
    local isTailor=area==3 and (nameLow:find("paper tailor",1,true)
        or nameLow:find("hg_tailor",1,true))
    local rec=MURIM_RAID_HIT.records[npc]
    if not rec then
        rec={hp=hum.Health,firstAt=now,lastDamageAt=now,attempts=0,skipUntil=0,
            didDamage=false,area=area,reported=false,
            paperSlot=(area==3 and MURIM_RAID_HIT.isSpecialPaper(npc,area)) and MURIM_RAID_HIT.paperSlot(npc) or nil}
        MURIM_RAID_HIT.records[npc]=rec
        MURIM_TRACE.add("DECISAO","DanoRaid",string.format("A%02d alvo=%s HP=%.0f; aguardando dano REAL, morte e contador HUD.",area,npc.Name,hum.Health))
    elseif hum.Health < rec.hp-0.1 then
        rec.didDamage=true
        rec.lastDamageAt=now
        rec.attempts=0
        MURIM_RAID_HIT.damageCount+=1
        if now-(rec.lastReport or 0)>2.5 then
            rec.lastReport=now
            MURIM_TRACE.add("EVIDENCIA","DanoRaid",string.format("A%02d %s: HP %.0f -> %.0f; dano confirmado (nao confirma objetivo).",area,npc.Name,rec.hp,hum.Health))
        end
    elseif isTailor and hum.Health>rec.hp+1500 then
        -- HP subiu no MESMO Humanoid; pode ser cura ou reinicio do encontro.
        MURIM_TRACE.add("AVISO","TailorLeash",string.format(
            "HP do Paper Tailor subiu de %.0f para %.0f no mesmo modelo. Possivel cura/reset do chefe; origem nao comprovada.",
            rec.hp,hum.Health),8)
        rec.attempts=0
        rec.lastDamageAt=now
    end
    rec.hp=hum.Health
    if area==6 and nameLow:find("cerberus",1,true) then
        rec.skipUntil=0;rec.permanentSkip=false
        if rec.attempts>=12 and now-rec.lastDamageAt>=7 then
            MURIM_TRACE.add("AVISO","Cerberus","Chefe vivo sem dano recente; manter alvo, sem liberar loot/porta por cooldown.",10)
        end
        return true
    end
    if isTailor then
        -- Falha do V18C: o Tailor levava cooldown de 24s depois de 12 ataques
        -- sem dano; com o chefe correndo a HUD ficava parada enquanto ele
        -- recuperava aggro/HP. Nunca o excluir por esta regra de efígies.
        if rec.attempts>=12 and now-rec.lastDamageAt>=7
            and now-(rec.lastTailorNoDamageNoticeAt or 0)>=10 then
            rec.lastTailorNoDamageNoticeAt=now
            MURIM_TRACE.add("AVISO","TailorLeash",string.format(
                "Tailor HP %.0f estagnado ha %.1fs. Nao excluir o alvo; verificar distancia, altura e possivel leash.",
                hum.Health,now-rec.lastDamageAt),8)
        end
        return true
    end
    local paperPending=area==3 and MURIM_RAID_HIT.isSpecialPaper(npc,area)
        and not MURIM_RAID_HIT.yardObjective
        and MURIM_RAID_HIT.eyes~=nil and MURIM_RAID_HIT.eyes>0
    if paperPending and MURIM_RAID_HIT.eyes==1 then
        -- A varredura alterna alvos apos 4.5s sem queda real de HP.
        -- NUNCA excluir um Paper permanentemente por uma tentativa sem dano.
        rec.permanentSkip=false
        rec.skipUntil=0
        return true
    end
    if rec.attempts>=12 and now-rec.lastDamageAt>=7 then
        local permanent=false -- V18I: sem exclusao PERMANENTE de Paper ainda exigido pela HUD.
        local cooldown=paperPending and 5 or 24
        rec.skipUntil=now+cooldown
        rec.permanentSkip=false
        rec.attempts=0
        rec.lastDamageAt=now
        MURIM_RAID_HIT.skipCount+=1
        MURIM_TRACE.add("AVISO","DanoRaid",string.format(
            "A%02d %s: ataques sem queda de HP (%.0f). Pausa temporaria de %ds; nao marcou como derrotado nem excluiu da raid.",
            area,npc.Name,hum.Health,cooldown))
        return false
    end
    return now>=rec.skipUntil
end
function MURIM_RAID_HIT.sent(npc, area, available, success)
    local rec=MURIM_RAID_HIT.records[npc]
    if not rec then return end
    rec.attempts+=1
    if rec.attempts==1 or (rec.attempts%50==0 and not rec.didDamage) then
        MURIM_TRACE.add("ACAO","DanoRaid",string.format("A%02d %s: CombatInput presente=%s; FireServer sem erro=%s; nao prova dano.",area,npc.Name,tostring(available),tostring(success)),4)
    end
end
-- So considerar TEXTO VISIVEL. UI antiga/oculta nao e o objetivo ativo.
function MURIM_RAID_HIT.visibleHudText(guiObj)
    if not guiObj then return false end
    local node=guiObj
    while node and node~=game do
        if node:IsA("GuiObject") and node.Visible==false then return false end
        if node:IsA("ScreenGui") and node.Enabled==false then return false end
        node=node.Parent
    end
    return true
end
function MURIM_RAID_HIT.hudTick(gui)
    local now=os.clock()
    if not gui or now-MURIM_RAID_HIT.lastHudAt<0.8 then return end
    MURIM_RAID_HIT.lastHudAt=now
    local found=nil
    local sawYard=false
    for _,v in ipairs(gui:GetDescendants()) do
        if (v:IsA("TextLabel") or v:IsA("TextButton"))
            and type(v.Text)=="string" and MURIM_RAID_HIT.visibleHudText(v) then
            local txt=v.Text:lower()
            -- Frase observada na HUD real: "To the yard. Don't...".
            -- Preferir objetivo novo mesmo se um painel antigo reter "Painted eyes".
            if txt:match("^%s*to the yard") and #txt<=190 then
                sawYard=true
            elseif not found and txt:find("painted",1,true) and txt:find("eyes",1,true) then
                found=tonumber(txt:match("painted%s+eyes%s*:%s*(%d+)"))
                    or tonumber(txt:match("painted%s+eyes.-(%d+)%s*left"))
            end
        end
    end
    if sawYard then
        if not MURIM_RAID_HIT.yardObjective then
            MURIM_TRACE.add("EVIDENCIA","ObjetivoA03",
                "HUD visivel agora diz 'To the yard...'. Objetivo Painted eyes antigo nao governa mais o combate: bloquear Paper Effigy e priorizar passagem/chefe, conforme porta.")
            MURIM_TRACE.suggest("Novo objetivo na HUD: To the yard. Paper Effigy excluidos; verificar Paper Tailor e porta final A03 antes de A04.")
        end
        MURIM_RAID_HIT.yardObjective=true
        MURIM_RAID_HIT.hudObjective="to the yard"
        MURIM_RAID_HIT.hudObjectiveAt=now
        MURIM_RAID_HIT.eyes=nil -- NAO converter contador anterior em 0 sem prova.
        MURIM_RAID_HIT.lastSeenEyes=nil
        return
    end
    -- Objetivo de patio observado e persistente dentro da mesma raid.
    -- Um TextLabel antigo 'Painted eyes' nao reabre a fase ja superada.
    if MURIM_RAID_HIT.yardObjective then return end
    if found~=nil then
        MURIM_RAID_HIT.hudObjective="painted eyes"
        MURIM_RAID_HIT.hudObjectiveAt=now
        MURIM_RAID_HIT.eyes=found
        if MURIM_RAID_HIT.lastSeenEyes~=found then
            if MURIM_RAID_HIT.lastSeenEyes~=nil then
                MURIM_TRACE.add(found<MURIM_RAID_HIT.lastSeenEyes and "EVIDENCIA" or "INFO","PaintedEyes",
                    "HUD Painted eyes "..tostring(MURIM_RAID_HIT.lastSeenEyes).." -> "..tostring(found).."; contador independente das mortes.")
            else
                MURIM_TRACE.add("INFO","PaintedEyes","Contador da HUD encontrado: "..tostring(found).." left. Alguns bonecos nao pontuam.")
            end
            MURIM_RAID_HIT.lastSeenEyes=found
            MURIM_RAID_HIT.eyesLastChangeAt=now
            MURIM_RAID_HIT.paperKillsSinceEye=0
            MURIM_RAID_HIT.paperSlots={}
            MURIM_RAID_HIT.paperStallUntil=0
            MURIM_RAID_HIT.paperSweepTarget=nil
            MURIM_RAID_HIT.paperSweepAt=0
            MURIM_RAID_HIT.paperSweepHit=false
            MURIM_RAID_HIT.paperSweepTried=setmetatable({},{__mode="k"})
            -- Reiniciar elegibilidade dos Paper vivos quando o objetivo mudar.
            for npc,rec in pairs(MURIM_RAID_HIT.records) do
                if rec.area==3 and MURIM_RAID_HIT.isSpecialPaper(npc,3) then
                    rec.permanentSkip=false
                    rec.skipUntil=0
                    rec.attempts=0
                    rec.lastDamageAt=now
                end
            end
        end
    elseif MURIM_RAID_HIT.eyes~=nil and now-MURIM_RAID_HIT.hudObjectiveAt>3 then
        -- A HUD deixou de exibir o objetivo; numero antigo nao deve bloquear progresso.
        -- Isso NAO prova que o contador chegou a zero.
        MURIM_RAID_HIT.eyes=nil
        MURIM_RAID_HIT.lastSeenEyes=nil
        MURIM_RAID_HIT.hudObjective="nao visivel"
        MURIM_TRACE.add("INFO","ObjetivoA03","Painted eyes nao aparece mais em texto visivel ha >3s; contador antigo invalidado, sem assumir sucesso.",12)
    end
end
function MURIM_RAID_HIT.onNoLongerTarget(npc)
    if not npc then return end
    local rec=MURIM_RAID_HIT.records[npc]
    if not rec or rec.reported then return end
    local hum=npc:FindFirstChildOfClass("Humanoid")
    if (not npc.Parent) or (hum and hum.Health<=0) then
        rec.reported=true
        if rec.area==3 and rec.didDamage and MURIM_RAID_HIT.isSpecialPaper(npc,3) then
            MURIM_RAID_HIT.paperKillsSinceEye+=1
            MURIM_RAID_HIT.paperKillsTotal+=1
            if rec.paperSlot then
                local slot=MURIM_RAID_HIT.paperSlots[rec.paperSlot] or {kills=0,skipUntil=0}
                slot.kills+=1
                -- Permite tentar outro ponto em vez de matar spawns idênticos.
                if slot.kills>=2 then slot.skipUntil=os.clock()+16 end
                MURIM_RAID_HIT.paperSlots[rec.paperSlot]=slot
            end
        end
        local isBoss=rec.area==3 and (npc.Name:lower():find("paper tailor",1,true)
            or npc.Name:lower():find("hg_tailor",1,true))
        if isBoss and (not hum or hum.Health>0 or rec.hp>0 and not (hum and hum.Health<=0)) then
            MURIM_TRACE.add("AVISO","TailorLeash",string.format(
                "Modelo antigo do Paper Tailor desapareceu; ultimo HP observado %.0f. Reset/despawn possivel; morte NAO confirmada.",
                rec.hp or -1))
        else
            MURIM_TRACE.add("EVIDENCIA","DanoRaid",string.format("A%02d %s morreu/desapareceu. Dano antes=%s; nao inferir variacao de Painted eyes.",rec.area or 0,npc.Name,tostring(rec.didDamage)))
        end
    end
end

-- V18: A03 - seguir a HUD REAL e atravessar a porta do patio de modo observado.
-- Evidencia do log: To the yard, porta intermediaria Z+478 Open=true, jogador
-- em Z+455. O Pathfinding da plataforma superior nao achou rota.
-- Nao confundir o modelo 3D visivel com conclusao de objetivo.
-- Esta rotina NAO depende de Pathfinding para cruzar uma porta comprovadamente aberta.
MURIM_A03 = {
    lastTick=0, lastReport=0, phase="aguardando", gateOpen=false,
    lastStageAt=0, stageAttempts=0, stageFailures=0, lastStageReport=0,
    lastDoorReport=0, pendingMove=nil, lastStageReason="nao testado",
    tailorEngaged=false, lastTailorReport=0,
    tailorProbeBoss=nil, tailorProbeAt=0, tailorProbeFailed=false,
    tailorProbeConfirmed=false,
}
function MURIM_A03.reset()
    MURIM_A03.lastTick=0
    MURIM_A03.lastReport=0
    MURIM_A03.phase="procurando olhos pintados"
    MURIM_A03.gateOpen=false
    MURIM_A03.lastStageAt=0
    MURIM_A03.stageAttempts=0
    MURIM_A03.stageFailures=0
    MURIM_A03.lastStageReport=0
    MURIM_A03.lastDoorReport=0
    MURIM_A03.pendingMove=nil
    MURIM_A03.lastStageReason="nao testado"
    MURIM_A03.tailorEngaged=false
    MURIM_A03.lastTailorReport=0
    MURIM_A03.tailorProbeBoss=nil
    MURIM_A03.tailorProbeAt=0
    MURIM_A03.tailorProbeFailed=false
    MURIM_A03.tailorProbeConfirmed=false
end
function MURIM_A03.getDoors(area, origin)
    local inner, final=nil,nil
    for _, item in ipairs(area:GetDescendants()) do
        if item:IsA("Model") and item.Name=="HallowDoor" then
            local part=item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart",true)
            if part then
                local z=part.Position.Z-origin.Z
                if z>=466 and z<=493 then
                    inner=item
                elseif z>=518 and z<=538 then
                    final=item
                end
            end
        end
    end
    return inner,final
end
function MURIM_A03.seeTailor(origin)
    local folder=workspace:FindFirstChild("Murim_NPCs")
    if not folder then return nil end
    for _,npc in ipairs(folder:GetChildren()) do
        if npc:IsA("Model") then
            local name=npc.Name:lower()
            if name:find("paper tailor",1,true) or name:find("hg_tailor",1,true) then
                local hum=npc:FindFirstChildOfClass("Humanoid")
                local part=npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                if hum and hum.Health>0 and part
                    and math.abs(part.Position.X-origin.X)<85
                    and part.Position.Z-origin.Z>458
                    and part.Position.Z-origin.Z<542 then
                    return npc,part
                end
            end
        end
    end
    return nil
end
-- V18E / Somente A03: posicao fixa do chefe baseada no marcador RaidBoss.
-- O limite e uma medida conservadora para testar, NAO um limite do servidor confirmado.
function MURIM_A03.tailorCenter(origin, raid)
    local area=raid and raid:FindFirstChild("A03_EffigyShop",true)
    local marker=area and area:FindFirstChild("RaidBoss",true)
    if marker and marker:IsA("BasePart") then return marker.Position end
    -- Fallback coerente com o marcador observado no mapa: Z+512, Y+1.
    return origin and (origin+Vector3.new(0,1,512)) or nil
end
-- V18M: a distancia de 8.5 atingia, mas deixava acertos intermitentes.
-- Provar a altura mais proxima por HP; se nao acertar em 5s de combate
-- CONTINUO, voltar automaticamente ao +8.5 comprovado na V18I.
-- A distancia ao marcador nao e um limite do servidor confirmado.
function MURIM_A03.tailorCombatPosition(root, bossPart, origin, raid)
    local center=MURIM_A03.tailorCenter(origin,raid)
    if not root or not bossPart or not center then return nil,false end
    local now=os.clock()
    local boss=bossPart.Position
    local offset=Vector3.new(boss.X-center.X,0,boss.Z-center.Z)
    local fromMarker=offset.Magnitude
    -- Ainda permanecer junto a arena (nao ir buscar o chefe pelo mapa inteiro),
    -- mas aproximar horizontalmente o maximo permitido pela borda de teste.
    local holdRadius=24
    local xz=fromMarker>holdRadius and center+offset.Unit*holdRadius or boss
    local npc=bossPart.Parent
    if MURIM_A03.tailorProbeBoss~=npc then
        MURIM_A03.tailorProbeBoss=npc
        MURIM_A03.tailorProbeAt=now
        MURIM_A03.tailorProbeFailed=false
        MURIM_A03.tailorProbeConfirmed=false
        MURIM_A03.tailorLastCombatAt=now
    end
    -- O tempo de cura NAO deve ser contado como falha de ataque: reiniciar
    -- a janela de teste depois do recuo de HP.
    if now-(MURIM_A03.tailorLastCombatAt or now)>1.3 then
        MURIM_A03.tailorProbeAt=now
    end
    MURIM_A03.tailorLastCombatAt=now
    local rec=npc and MURIM_RAID_HIT.records[npc]
    if rec and (rec.lastDamageAt or 0)>MURIM_A03.tailorProbeAt then
        MURIM_A03.tailorProbeConfirmed=true
    end
    if not MURIM_A03.tailorProbeFailed and not MURIM_A03.tailorProbeConfirmed
        and now-MURIM_A03.tailorProbeAt>5 then
        MURIM_A03.tailorProbeFailed=true
        MURIM_A03.tailorProbeAt=now
        MURIM_TRACE.add("AVISO","TailorLeash",
            "Posicao mais proxima (+6.0) sem dano confirmado em 5s de combate. Voltando ao +8.5 que confirmou dano no log.",5)
    end
    local attackRise=MURIM_A03.tailorProbeFailed and 8.5 or 6.0
    local y=math.clamp(boss.Y+attackRise,center.Y+6,center.Y+19)
    local desired=Vector3.new(xz.X,y,xz.Z)
    local distance=(desired-boss).Magnitude
    -- V18I suspendia QUALQUER ataque com boss >26 do marcador mesmo que
    -- a distancia real de contato ainda fosse pequena. Agora o criterio
    -- principal e a distancia 3D real, com um teto apenas para nao fugir da A03.
    local relZ=boss.Z-origin.Z
    local insideArena=relZ>=458 and relZ<=542 and math.abs(boss.X-origin.X)<=85
    local canHit=insideArena and fromMarker<=38 and distance<=13.5
    if now-(MURIM_A03.lastTailorReport or 0)>=6 then
        MURIM_A03.lastTailorReport=now
        MURIM_TRACE.add("INFO","TailorLeash",string.format(
            "Chefe raio=%.1f; jogador raio=%.1f; distancia REAL=%.1f, rise=%.1f; atacar=%s, altura confirmou HP=%s; arena=%s.",
            fromMarker,(Vector3.new(desired.X-center.X,0,desired.Z-center.Z)).Magnitude,
            distance,attackRise,tostring(canHit),tostring(MURIM_A03.tailorProbeConfirmed),tostring(insideArena)))
    end
    if not canHit then
        MURIM_A03.phase="Paper Tailor fora da distancia real de ataque; acompanhando borda da arena"
        MURIM_TRACE.add("AVISO","TailorLeash",string.format(
            "Sem ataque valido: raio chefe=%.1f, distancia 3D=%.1f. Retomar assim que aproximar; nao excluir alvo.",
            fromMarker,distance),8)
    end
    return CFrame.new(desired)*CFrame.Angles(math.rad(-90),0,0),canHit
end
-- Scoped to navigation in A03 onward; no combat or A01/A02 changes.
MURIM_RAID_NAV={failed=setmetatable({},{__mode="k"}),events={}}
function MURIM_RAID_NAV.note(message)
    table.insert(MURIM_RAID_NAV.events,"["..os.date("%H:%M:%S").."] "..message:sub(1,260))
    if #MURIM_RAID_NAV.events>2000 then table.remove(MURIM_RAID_NAV.events,1) end
    MURIM_TRACE.add("NAVEGACAO","Destino",message,2)
end
function MURIM_RAID_NAV.reject(root,pos)
    if not pos then return end
    local records=MURIM_RAID_NAV.failed[root] or {}
    MURIM_RAID_NAV.failed[root]=records
    table.insert(records,{pos=pos,untilAt=os.clock()+30})
    if #records>20 then table.remove(records,1) end
    MURIM_RAID_NAV.note(string.format("Destino falhou e fica excluido por 30s: (%.0f,%.0f,%.0f); atual=(%.0f,%.0f,%.0f)",
        pos.X,pos.Y,pos.Z,root.Position.X,root.Position.Y,root.Position.Z))
end
function MURIM_RAID_NAV.allowed(root,pos)
    for _,record in ipairs(MURIM_RAID_NAV.failed[root] or {}) do
        if os.clock()<record.untilAt and (record.pos-pos).Magnitude<6 then return false end
    end
    return true
end
function MURIM_RAID_NAV.collisionBody(root)
    if root.CanCollide then return root end
    if root.Parent then
        for _,part in ipairs(root.Parent:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then return part end
        end
    end
    return nil
end
function MURIM_RAID_NAV.configure(root,params)
    local body=MURIM_RAID_NAV.collisionBody(root)
    params.CollisionGroup=(body or root).CollisionGroup
    params.RespectCanCollide=true
end
function MURIM_RAID_NAV.surface(root,hit)
    if not hit or not hit.Instance or not hit.Instance.CanCollide or hit.Normal.Y<0.7 then return false end
    local part=hit.Instance
    local body=MURIM_RAID_NAV.collisionBody(root)
    if not body or not body:CanCollideWith(part) then return false end
    local raid=getActiveRaidInfo()
    if not raid or not part:IsDescendantOf(raid) then return false end
    local name=part.Name:lower()
    if name:find("roof",1,true) or name:find("ceiling",1,true) or name:find("spike",1,true)
        or name=="pit" then return false end
    return MURIM_RAID_NAV.allowed(root,hit.Position+Vector3.new(0,3.5,0))
end
function MURIM_RAID_NAV.support(root,hit,params)
    if not MURIM_RAID_NAV.surface(root,hit) then return false end
    for _,offset in ipairs({Vector3.new(1.2,0,0),Vector3.new(-1.2,0,0),Vector3.new(0,0,1.2),Vector3.new(0,0,-1.2)}) do
        local edge=workspace:Raycast(hit.Position+offset+Vector3.new(0,3,0),Vector3.new(0,-6,0),params)
        if not MURIM_RAID_NAV.surface(root,edge) or math.abs(edge.Position.Y-hit.Position.Y)>2 then return false end
    end
    return true
end
function MURIM_RAID_NAV.describe(hit)
    return string.format("%s grupo=%s pos=(%.0f,%.0f,%.0f)",hit.Instance:GetFullName(),
        hit.Instance.CollisionGroup,hit.Position.X,hit.Position.Y,hit.Position.Z)
end

function MURIM_A03.checkLastMove(root, origin)
    local previous=MURIM_A03.pendingMove
    if not previous or os.clock()-previous.at<0.65 then return end
    local actualZ=root.Position.Z-origin.Z
    local advanced=actualZ-previous.fromZ
    if advanced<math.min(2.5,(previous.targetZ-previous.fromZ)*0.45)
        or (previous.to and root.Position.Y<previous.to.Y-8) then
        MURIM_RAID_NAV.reject(root,previous.to)
        MURIM_A03.stageFailures=MURIM_A03.stageFailures+1
        MURIM_A03.lastStageReason="deslocamento nao persistiu no cliente/servidor"
        MURIM_TRACE.add("AVISO","AutoA03",string.format(
            "Movimento A03 NAO persistiu: Z inicial +%.0f, alvo +%.0f, atual +%.0f; pode haver colisao ou correcao do servidor.",
            previous.fromZ,previous.targetZ,actualZ),5)
    else
        MURIM_A03.stageFailures=0
        MURIM_TRACE.add("EVIDENCIA","AutoA03",string.format(
            "Deslocamento A03 confirmado apos %.1fs: Z +%.0f -> +%.0f (alvo +%.0f). Nao comprova objetivo da raid.",
            os.clock()-previous.at,previous.fromZ,actualZ,previous.targetZ),2)
    end
    MURIM_A03.pendingMove=nil
end
-- Procura um piso em MAIS DE UMA altura. Uma plataforma em Y~712 e o patio em
-- Y~701 nao devem ser confundidos com teto/OverDoor. Nao altera o mundo sem
-- confirmar superficie horizontal e espaco fisico na chegada.
function MURIM_A03.findLanding(root, origin, relZ)
    local char=root.Parent
    if not char then return nil,"personagem ausente" end
    local rayParams=RaycastParams.new()
    rayParams.FilterType=Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances={char}
    rayParams.IgnoreWater=true
    pcall(function() MURIM_RAID_NAV.configure(root,rayParams) end)
    local overlapParams=OverlapParams.new()
    overlapParams.FilterType=Enum.RaycastFilterType.Exclude
    overlapParams.FilterDescendantsInstances={char}
    overlapParams.MaxParts=50
    pcall(function() MURIM_RAID_NAV.configure(root,overlapParams) end)
    local xOffsets={0,-4,4,-8,8,-12,12}
    local zOffsets={0,-2,2}
    local heights={root.Position.Y+6,origin.Y+28,origin.Y+11}
    local hits=0
    local reason="sem piso horizontal e desobstruido"
    for _,zOffset in ipairs(zOffsets) do
        for _,xOffset in ipairs(xOffsets) do
            local x=origin.X+xOffset
            local z=origin.Z+relZ+zOffset
            for _,height in ipairs(heights) do
                -- Rejeitar coberturas/tetos como piso e continuar o raio abaixo.
                local rayY=height
                for _=1,5 do
                    local hit=workspace:Raycast(Vector3.new(x,rayY,z),Vector3.new(0,-68,0),rayParams)
                    if not hit then break end
                    hits=hits+1
                    local obj=hit.Instance
                    local n=obj and obj.Name:lower() or ""
                    local badName=n:find("roof",1,true) or n:find("ceiling",1,true)
                        or n:find("canopy",1,true) or n:find("overdoor",1,true)
                        or n:find("doorbeam",1,true) or n:find("seal",1,true)
                    local good=not badName and MURIM_RAID_NAV.support(root,hit,rayParams)
                    local landing=hit.Position+Vector3.new(0,3.5,0)
                    local deltaY=landing.Y-root.Position.Y
                    if good and deltaY<=17 and deltaY>=-27
                        and landing.Y>=origin.Y-38 and landing.Y<=origin.Y+37 then
                        -- A caixa começa acima do chão, e procura paredes no corpo.
                        local occupied=false
                        local ok,parts=pcall(function()
                            return workspace:GetPartBoundsInBox(
                                CFrame.new(landing+Vector3.new(0,0.4,0)),
                                Vector3.new(3.0,4.0,3.0),overlapParams)
                        end)
                        if ok and parts then
                            for _,part in ipairs(parts) do
                                if part.CanCollide and part~=obj then
                                    occupied=true
                                    reason="corpo colide com "..tostring(part.Name)
                                    break
                                end
                            end
                        end
                        if not occupied then
                            MURIM_RAID_NAV.note("Pouso A03: "..MURIM_RAID_NAV.describe(hit))
                            return landing,"piso="..obj.Name..", altura="..string.format("%.0f",hit.Position.Y)
                        end
                    elseif good then
                        reason="diferenca vertical insegura na chegada"
                    end
                    -- Descer para procurar o proximo plano, sem reusar o mesmo hit.
                    local nextY=hit.Position.Y-0.35
                    if nextY>=rayY-0.01 then break end
                    rayY=nextY
                end
            end
        end
    end
    if hits==0 then reason="sem geometria carregada no destino (StreamingEnabled?)" end
    return nil,reason
end
-- Avancar no maximo 16 studs por ciclo. So cruza Z+478 se a porta tem
-- Open=true; so cruza a ultima porta Z+526 quando Open=true.
function MURIM_A03.safeStage(root, origin, relGoal, label, innerOpen, finalOpen)
    if not root or not root.Parent or not origin then return false end
    local rel=root.Position.Z-origin.Z
    if rel<397 or rel>552 or relGoal<408 or relGoal>548 then return false end
    if rel>=relGoal-2 then return true end
    -- Porta intermediaria Z+478: so exige Open=true ANTES de atravessar.
    -- Depois de Z+487 ela pode fechar novamente; isso nao bloqueia
    -- o caminho A03 -> A04 quando a porta FINAL Z+526 esta Open=true.
    local innerAlreadyCrossed=rel>=487
    if not innerAlreadyCrossed and innerOpen~=true and relGoal>469 then
        MURIM_A03.lastStageReason="porta intermediaria fechada e ainda nao atravessada"
        return false
    end
    if finalOpen~=true and relGoal>519 then
        MURIM_A03.lastStageReason="porta final nao confirmou Open=true"
        return false
    end
    local now=os.clock()
    if now-MURIM_A03.lastStageAt<1.05 then return true end
    MURIM_A03.lastStageAt=now
    MURIM_A03.stageAttempts=MURIM_A03.stageAttempts+1
    local stepRel=math.min(relGoal,rel+16)
    -- Reduz passo antes das duas portas para evitar pular o batente.
    if rel<473 and stepRel>473 then stepRel=473 end
    if rel<521 and stepRel>521 then stepRel=521 end
    if innerOpen~=true and not innerAlreadyCrossed then
        stepRel=math.min(stepRel,467)
    end
    if finalOpen~=true then stepRel=math.min(stepRel,518) end
    if stepRel<=rel+1.5 then return false end
    local landing,why=MURIM_A03.findLanding(root,origin,stepRel)
    if landing then
        local oldZ=rel
        root.CFrame=CFrame.new(landing)
        root.AssemblyLinearVelocity=Vector3.zero
        root.AssemblyAngularVelocity=Vector3.zero
        MURIM_A03.pendingMove={fromZ=oldZ,targetZ=stepRel,at=now,to=landing}
        MURIM_A03.lastStageReason=why
        MURIM_TRACE.add("MOVIMENTO","AutoA03",string.format(
            "A03 %s: Z +%.0f -> alvo +%.0f, pouso=(%.0f,%.0f,%.0f); %s; porta inter=%s, final=%s.",
            label,oldZ,stepRel,landing.X,landing.Y,landing.Z,why,tostring(innerOpen),tostring(finalOpen)),0.6)
        return true
    end
    MURIM_A03.stageFailures=MURIM_A03.stageFailures+1
    MURIM_A03.lastStageReason=why
    if now-MURIM_A03.lastStageReport>=3.5 then
        MURIM_A03.lastStageReport=now
        MURIM_TRACE.add("AVISO","AutoA03",string.format(
            "A03 sem pouso confiavel para %s: atual Z+%.0f, passo Z+%.0f, tentativas=%d; motivo=%s. Sem teleporte cego.",
            label,rel,stepRel,MURIM_A03.stageAttempts,why))
    end
    return false
end
function MURIM_A03.tick(ply, root, raid, origin)
    if not ply or not root or not raid then return true end
    local now=os.clock()
    if now-MURIM_A03.lastTick<0.80 then return true end
    MURIM_A03.lastTick=now
    MURIM_RAID_HIT.hudTick(ply:FindFirstChild("PlayerGui"))
    local area=raid:FindFirstChild("A03_EffigyShop",true)
    if not area then
        MURIM_A03.phase="A03 nao carregada (streaming)"
        return true
    end
    MURIM_A03.checkLastMove(root,origin)
    local inner,final=MURIM_A03.getDoors(area,origin)
    local innerOpen=inner and inner:GetAttribute("Open")==true
    local finalOpen=final and final:GetAttribute("Open")==true
    MURIM_A03.gateOpen=finalOpen==true
    local rel=root.Position.Z-origin.Z
    if now-MURIM_A03.lastDoorReport>12 then
        MURIM_A03.lastDoorReport=now
        MURIM_TRACE.add("INFO","AutoA03",string.format(
            "Pos Z+%.0f, Y=%.0f; HUD=%s; porta Z+478 encontrada=%s/Open=%s; porta Z+526 encontrada=%s/Open=%s; ultimo piso=%s.",
            rel,root.Position.Y,tostring(MURIM_RAID_HIT.hudObjective),tostring(inner~=nil),
            tostring(innerOpen),tostring(final~=nil),tostring(finalOpen),MURIM_A03.lastStageReason))
    end
    if MURIM_RAID_HIT.eyes and MURIM_RAID_HIT.eyes>0 and not MURIM_RAID_HIT.yardObjective then
        MURIM_A03.phase="Painted eyes pendentes: "..tostring(MURIM_RAID_HIT.eyes)
        if now-MURIM_A03.lastReport>=12 then
            MURIM_A03.lastReport=now
            local cs=game:GetService("CollectionService")
            local nearTagged,tagged=0,0
            for _,obj in ipairs(cs:GetTagged("HallowWatched")) do
                if obj:IsA("Model") then
                    local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
                    if part and math.abs(part.Position.X-origin.X)<145
                        and part.Position.Z-origin.Z>=399 and part.Position.Z-origin.Z<530 then
                        tagged+=1
                        if (part.Position-root.Position).Magnitude<130 then nearTagged+=1 end
                    end
                end
            end
            MURIM_TRACE.add("DIAGNOSTICO","AutoA03",string.format(
                "Painted eyes=%d; mortes Paper desde mudanca=%d (total=%d); HallowWatched em A03=%d, proximos=%d; pausa=%s; porta inter Open=%s. Sem supor progresso por morte.",
                MURIM_RAID_HIT.eyes,MURIM_RAID_HIT.paperKillsSinceEye,
                MURIM_RAID_HIT.paperKillsTotal,tagged,nearTagged,
                tostring(now<(MURIM_RAID_HIT.paperStallUntil or 0)),tostring(innerOpen)))
        end
        return true
    end
    if not MURIM_RAID_HIT.yardObjective and MURIM_RAID_HIT.eyes~=0 then
        MURIM_A03.phase="aguardando HUD Painted eyes / To the yard"
        return true
    end
    local tailor,tailorPart=MURIM_A03.seeTailor(origin)
    if tailor and tailorPart then
        MURIM_A03.phase="Paper Tailor vivo: combate tem prioridade"
        MURIM_TRACE.add("INFO","AutoA03",string.format(
            "Paper Tailor identificado: %s, Z+%.0f, distancia=%.0f. Navegacao pausada durante combate do chefe.",
            tailor.Name,tailorPart.Position.Z-origin.Z,(tailorPart.Position-root.Position).Magnitude),10)
        return true
    end
    if MURIM_A03.tailorEngaged and not finalOpen then
        MURIM_A03.phase="Paper Tailor ja combatido: aguardar chefe/porta sem abandonar o centro da arena"
        MURIM_TRACE.add("INFO","TailorLeash",
            "Paper Tailor ausente ou indisponivel. Segurando no patio; nao caminhar ao gatilho Z+517 ate porta final abrir.",12)
        return true
    end
    if finalOpen then
        MURIM_A03.phase="porta final aberta: atravessando para A04"
        if rel>=487 and innerOpen~=true then
            MURIM_TRACE.add("DECISAO","AutoA03",
                "Porta final Open=true. Intermediaria fechou ATRAS do jogador; prosseguir sem retroceder.",8)
        end
        MURIM_A03.safeStage(root,origin,544,"saida A04",innerOpen,finalOpen)
    elseif innerOpen then
        if rel<483 then
            MURIM_A03.phase="ATRAVESSANDO porta intermediaria aberta"
            MURIM_A03.safeStage(root,origin,487,"porta aberta para o patio",innerOpen,finalOpen)
        elseif rel<507 then
            MURIM_A03.phase="indo ao patio do Paper Tailor"
            MURIM_A03.safeStage(root,origin,510,"patio do Tailor",innerOpen,finalOpen)
        elseif rel<516 then
            MURIM_A03.phase="indo ao gatilho do Paper Tailor"
            MURIM_A03.safeStage(root,origin,517,"gatilho do Tailor",innerOpen,finalOpen)
        else
            MURIM_A03.phase=tailor and "Tailor detectado; aguardando combate" or "patio alcancado: aguardando chefe/objetivo"
            MURIM_TRACE.add("INFO","AutoA03",string.format(
                "No patio Z+%.0f. Paper Tailor=%s, porta final Open=%s. Nao atravessar a porta final fechada.",
                rel,tostring(tailor~=nil),tostring(finalOpen)),12)
        end
    elseif rel<466 then
        MURIM_A03.phase="aproximando porta intermediaria (sem Open=true)"
        MURIM_A03.safeStage(root,origin,466,"antes da porta fechada",innerOpen,finalOpen)
    else
        MURIM_A03.phase="AGUARDANDO porta intermediaria confirmar Open=true"
        MURIM_TRACE.add("AVISO","AutoA03",string.format(
            "HUD=To the yard, mas HallowDoor na Z+478 Open=%s. Parado antes da porta; nao voltar a atacar Paper Effigy.",
            tostring(innerOpen)),10)
    end
    return true
end

-- Defesa V17R: elevacao CONTROLADA, segurando a posicao durante a cura real.
-- HP real eh a unica evidencia de cura; subir nao garante imunidade contra toda habilidade.
MURIM_RAID_DEFENSE={retreating=false,phase="monitorando",hover=nil,hoverPos=nil,
    hoverRoot=nil,prevHP=nil,lastWarnAt=0,lastSnapAt=0,damageHits=0,resumeAt=0,hoverRise=0,
    tailorMode=false,tailorAnchor=nil,retreatStartedAt=0}
function MURIM_RAID_DEFENSE.release()
    if MURIM_RAID_DEFENSE.hover then pcall(function() MURIM_RAID_DEFENSE.hover:Destroy() end) end
    MURIM_RAID_DEFENSE.hover=nil
    MURIM_RAID_DEFENSE.hoverPos=nil
    MURIM_RAID_DEFENSE.hoverRoot=nil
    MURIM_RAID_DEFENSE.hoverRise=0
end
function MURIM_RAID_DEFENSE.reset()
    MURIM_RAID_DEFENSE.release()
    MURIM_RAID_DEFENSE.retreating=false
    MURIM_RAID_DEFENSE.phase="monitorando"
    MURIM_RAID_DEFENSE.prevHP=nil
    MURIM_RAID_DEFENSE.lastWarnAt=0
    MURIM_RAID_DEFENSE.lastSnapAt=0
    MURIM_RAID_DEFENSE.damageHits=0
    MURIM_RAID_DEFENSE.tailorMode=false
    MURIM_RAID_DEFENSE.tailorAnchor=nil
    MURIM_RAID_DEFENSE.retreatStartedAt=0
    MURIM_RAID_DEFENSE.cerberusRecovery=nil
    MURIM_RAID_DEFENSE.lastCerberusFallback=0
end
function MURIM_RAID_DEFENSE.clearance(char,root,up)
    local p=RaycastParams.new()
    p.FilterType=Enum.RaycastFilterType.Exclude
    p.FilterDescendantsInstances={char}
    p.IgnoreWater=true
    pcall(function() p.RespectCanCollide=true end)
    local ray=workspace:Raycast(root.Position+Vector3.new(0,1,0),Vector3.new(0,up,0),p)
    if ray and ray.Instance and ray.Instance.CanCollide then
        return math.max(0,ray.Distance-5)
    end
    return up
end
function MURIM_RAID_DEFENSE.hoverAbove(char,root,requested)
    local clearance=MURIM_RAID_DEFENSE.clearance(char,root,requested+6)
    local rise=math.min(requested,clearance)
    if rise<10 then return false,"sem espaco vertical >=10 studs (teto/objeto)" end
    local pos=root.Position+Vector3.new(0,rise,0)
    root.CFrame=root.CFrame+Vector3.new(0,rise,0)
    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    MURIM_RAID_DEFENSE.release()
    local body=Instance.new("BodyPosition")
    body.Name="MurimV17R_RecuperacaoHP"
    body.Position=pos
    body.MaxForce=Vector3.new(15000000,15000000,15000000)
    body.P=80000
    body.D=5000
    body.Parent=root
    MURIM_RAID_DEFENSE.hover=body
    MURIM_RAID_DEFENSE.hoverRoot=root
    MURIM_RAID_DEFENSE.hoverPos=pos
    MURIM_RAID_DEFENSE.hoverRise=rise
    return true,rise
end
-- V18K: quando HP cair no Tailor, apenas subir um pouco no mesmo X/Z.
-- Nao puxar o personagem para o marcador: isso afastava do boss na cura.
-- Mantem os gatilhos HP 68%/78% e o mesmo controle de BodyPosition.
function MURIM_RAID_DEFENSE.hoverTailor(char,root,center)
    if not center then return false,"marcador do Tailor ausente" end
    local ceiling=center.Y+20
    local desiredY=math.min(ceiling,math.max(root.Position.Y,center.Y+16))
    local requested=desiredY-root.Position.Y
    if requested>0.5 then
        local clearance=MURIM_RAID_DEFENSE.clearance(char,root,requested+4)
        if clearance<requested then
            desiredY=root.Position.Y
            MURIM_TRACE.add("AVISO","TailorLeash",
                "Subida curta bloqueada pelo teto: mantendo a mesma posicao X/Z, sem afastar do chefe.",9)
        end
    end
    -- Manter X/Z da ultima posicao de ataque; mudar somente a altura.
    local pos=Vector3.new(root.Position.X,desiredY,root.Position.Z)
    MURIM_RAID_DEFENSE.release()
    root.CFrame=CFrame.new(pos)*root.CFrame.Rotation
    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    local body=Instance.new("BodyPosition")
    body.Name="MurimV18K_TailorHP"
    body.Position=pos
    body.MaxForce=Vector3.new(15000000,15000000,15000000)
    body.P=80000
    body.D=5000
    body.Parent=root
    MURIM_RAID_DEFENSE.hover=body
    MURIM_RAID_DEFENSE.hoverRoot=root
    MURIM_RAID_DEFENSE.hoverPos=pos
    MURIM_RAID_DEFENSE.hoverRise=math.max(0,pos.Y-center.Y)
    MURIM_TRACE.add("INFO","TailorLeash",string.format(
        "HP baixo: subida curta SEM afastar X/Z; Y relativo=%.1f (maximo=20), raio XZ do marcador=%.1f. Ataques pausados ate recuperar HP.",
        pos.Y-center.Y,(Vector3.new(pos.X-center.X,0,pos.Z-center.Z)).Magnitude),5)
    return true,string.format("Tailor subida curta Y+%.1f, X/Z preservado; raio=%.1f",pos.Y-center.Y,
        (Vector3.new(pos.X-center.X,0,pos.Z-center.Z)).Magnitude)
end
function MURIM_RAID_DEFENSE.cerberusFallback(char,root,hp,maxHP)
    local saved=MURIM_RAID_DEFENSE.cerberusRecovery
    local previous=MURIM_RAID_DEFENSE.prevHP
    local hover=MURIM_RAID_DEFENSE.hover
    if not saved or saved.root~=root or not hover or not previous
        or previous-hp<maxHP*0.10 or os.clock()-(MURIM_RAID_DEFENSE.lastCerberusFallback or 0)<3 then return false end
    local delta=saved.pos-root.Position
    if delta.Magnitude<12 then
        MURIM_RAID_DEFENSE.cerberusRecovery=nil
        MURIM_TRACE.add("AVISO","SegurancaHP","Ponto anterior recebeu golpe forte; descartado como destino de recuperacao.",3)
        return false
    end
    if delta.Magnitude<6 or delta.Magnitude>90 then return false end
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={char}
    pcall(function() params.RespectCanCollide=true end)
    if workspace:Raycast(root.Position,delta,params) then return false end
    MURIM_RAID_DEFENSE.lastCerberusFallback=os.clock()
    MURIM_RAID_DEFENSE.hoverPos=saved.pos
    hover.Position=saved.pos
    root.CFrame=root.CFrame+delta
    root.AssemblyLinearVelocity=Vector3.zero
    MURIM_TRACE.add("ACAO","SegurancaHP","Golpe forte durante cura: retornando ao ultimo ponto com recuperacao concluida, caminho livre. Protecao ainda depende do HP real.",3)
    return true
end

function MURIM_RAID_DEFENSE.tick(char,root,tailorCenter,cerberus)
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hum or not root then return false end
    local hp,maxHP=hum.Health,math.max(hum.MaxHealth,1)
    -- V18E: uma pausa de 23s sem atacar precedeu a recriacao com HP cheio.
    -- A03 Tailor: tentar recuperacoes curtas ANTES de cair no HP critico.
    -- Outras salas: manter 40%/85% da V18D.
    local tailorActive=(tailorCenter~=nil or (MURIM_RAID_DEFENSE.retreating and MURIM_RAID_DEFENSE.tailorMode))
    local triggerPct=tailorActive and 0.68 or 0.40
    local resumePct=tailorActive and 0.78 or 0.85
    local trigger=math.max(1,maxHP*triggerPct)
    local resume=math.max(trigger+1,maxHP*resumePct)
    MURIM_RAID_DEFENSE.resumeAt=resume
    if hp<=0 then
        MURIM_RAID_DEFENSE.reset()
        MURIM_RAID_DEFENSE.phase="derrotado; aguardando respawn"
        return true
    end
    if not MURIM_RAID_DEFENSE.retreating and hp<=trigger then
        MURIM_RAID_DEFENSE.retreating=true
        MURIM_RAID_DEFENSE.retreatStartedAt=os.clock()
        MURIM_RAID_DEFENSE.longRetreatWarned=false
        MURIM_RAID_DEFENSE.prevHP=hp
        MURIM_RAID_DEFENSE.damageHits=0
        pcall(function() hum:MoveTo(root.Position) end)
        MURIM_RAID_DEFENSE.tailorMode=tailorCenter~=nil
        MURIM_RAID_DEFENSE.tailorAnchor=tailorCenter
        local ok,height
        if MURIM_RAID_DEFENSE.tailorMode then
            ok,height=MURIM_RAID_DEFENSE.hoverTailor(char,root,tailorCenter)
        else
            ok,height=MURIM_RAID_DEFENSE.hoverAbove(char,root,25)
        end
        MURIM_TRACE.add("AVISO","SegurancaHP",string.format(
            "HP %.0f/%.0f <=%.0f%% (%.0f): ATAQUES SUSPENSOS. Recuo=%s (%s); retomar em %.0f HP (%.0f%%). Recuperacao curta=%s.",
            hp,maxHP,triggerPct*100,trigger,tostring(ok),tostring(height),resume,resumePct*100,tostring(MURIM_RAID_DEFENSE.tailorMode)))
    end
    if not MURIM_RAID_DEFENSE.retreating then
        MURIM_RAID_DEFENSE.phase=string.format("monitorando (gatilho %.0f/%.0f)",trigger,maxHP)
        return false
    end
    if hp>=resume then
        if cerberus and MURIM_RAID_DEFENSE.hoverPos then
            MURIM_RAID_DEFENSE.cerberusRecovery={root=root,pos=MURIM_RAID_DEFENSE.hoverPos}
        end
        MURIM_RAID_DEFENSE.release()
        MURIM_RAID_DEFENSE.retreating=false
        MURIM_RAID_DEFENSE.tailorMode=false
        MURIM_RAID_DEFENSE.tailorAnchor=nil
        MURIM_RAID_DEFENSE.prevHP=hp
        local duration=os.clock()-(MURIM_RAID_DEFENSE.retreatStartedAt or os.clock())
        MURIM_RAID_DEFENSE.retreatStartedAt=0
        MURIM_RAID_DEFENSE.phase="HP recuperado; retomando combate"
        MURIM_TRACE.add("EVIDENCIA","SegurancaHP",string.format("Cura real confirmada: %.0f/%.0f HP em %.1fs de pausa. Defesa liberou combate na V18E.",hp,maxHP,duration))
        return false
    end
    if MURIM_RAID_DEFENSE.hoverRoot~=root then
        if MURIM_RAID_DEFENSE.tailorMode then
            MURIM_RAID_DEFENSE.hoverTailor(char,root,MURIM_RAID_DEFENSE.tailorAnchor)
        else
            MURIM_RAID_DEFENSE.release()
            MURIM_RAID_DEFENSE.hoverAbove(char,root,25)
        end
    end
    if MURIM_RAID_DEFENSE.prevHP and hp<MURIM_RAID_DEFENSE.prevHP-0.5 then
        if cerberus then MURIM_RAID_DEFENSE.cerberusFallback(char,root,hp,maxHP) end
        MURIM_RAID_DEFENSE.damageHits+=1
        MURIM_TRACE.add("AVISO","SegurancaHP",string.format(
            "Dano persistiu durante recuo vertical (%.0f -> %.0f). Altura NAO assegura imunidade; suspensao continua.",
            MURIM_RAID_DEFENSE.prevHP,hp),4,"dano-durante-recuo")
        -- Tentar elevar mais um pouco SE houver teto livre; nao atravessar colisao.
        if MURIM_RAID_DEFENSE.tailorMode and MURIM_RAID_DEFENSE.damageHits>=3 then
            MURIM_RAID_DEFENSE.damageHits=0
            -- Somente pequenos ajustes verticais; evitar distancia da cura anterior.
            local room=MURIM_RAID_DEFENSE.tailorAnchor
            local currentY=MURIM_RAID_DEFENSE.hoverPos and MURIM_RAID_DEFENSE.hoverPos.Y
            local extra=room and currentY and math.min(3,room.Y+20-currentY) or 0
            if extra>1 and MURIM_RAID_DEFENSE.clearance(char,root,extra+5)>=extra then
                MURIM_RAID_DEFENSE.hoverPos=MURIM_RAID_DEFENSE.hoverPos+Vector3.new(0,extra,0)
                if MURIM_RAID_DEFENSE.hover then
                    MURIM_RAID_DEFENSE.hover.Position=MURIM_RAID_DEFENSE.hoverPos
                end
                MURIM_RAID_DEFENSE.hoverRise=MURIM_RAID_DEFENSE.hoverRise+extra
                MURIM_TRACE.add("AVISO","TailorLeash",string.format(
                    "Dano durante a cura: subir mais %.1f, altura atual relativa ao marcador=%.1f/20; X/Z preservado. Combate suspenso.",
                    extra,MURIM_RAID_DEFENSE.hoverRise),4)
            else
                MURIM_TRACE.add("AVISO","TailorLeash",
                    "Dano persiste, mas altura 20/teto limita a subida curta. X/Z preservado; ataques seguem suspensos.",8)
            end
        elseif MURIM_RAID_DEFENSE.damageHits>=3 and MURIM_RAID_DEFENSE.hoverPos
            and MURIM_RAID_DEFENSE.hoverRise<43 then
            local desired=math.min(8,43-MURIM_RAID_DEFENSE.hoverRise)
            local clearance=MURIM_RAID_DEFENSE.clearance(char,root,desired+5)
            if clearance>=desired then
                MURIM_RAID_DEFENSE.hoverPos=MURIM_RAID_DEFENSE.hoverPos+Vector3.new(0,desired,0)
                MURIM_RAID_DEFENSE.hover.Position=MURIM_RAID_DEFENSE.hoverPos
                MURIM_RAID_DEFENSE.hoverRise=MURIM_RAID_DEFENSE.hoverRise+desired
                MURIM_RAID_DEFENSE.damageHits=0
                MURIM_TRACE.add("ACAO","SegurancaHP","Mesmo elevado recebeu dano: subindo mais 8 studs (espaco verificado).",7)
            end
        end
    end
    MURIM_RAID_DEFENSE.prevHP=hp
    if MURIM_RAID_DEFENSE.hoverPos and MURIM_RAID_DEFENSE.hoverRoot==root
        and (root.Position-MURIM_RAID_DEFENSE.hoverPos).Magnitude>4
        and os.clock()-MURIM_RAID_DEFENSE.lastSnapAt>0.8 then
        MURIM_RAID_DEFENSE.lastSnapAt=os.clock()
        root.CFrame=root.CFrame+ (MURIM_RAID_DEFENSE.hoverPos-root.Position)
        root.AssemblyLinearVelocity=Vector3.zero
    end
    local pauseDuration=os.clock()-(MURIM_RAID_DEFENSE.retreatStartedAt or os.clock())
    if MURIM_RAID_DEFENSE.tailorMode and pauseDuration>9
        and not MURIM_RAID_DEFENSE.longRetreatWarned then
        MURIM_RAID_DEFENSE.longRetreatWarned=true
        MURIM_TRACE.add("AVISO","TailorLeash",string.format(
            "Pausa de %.1fs no Tailor; risco de reset observado em pausa longa. Seguranca impede atacar antes de recuperar HP.",pauseDuration),6)
    end
    MURIM_RAID_DEFENSE.phase=string.format(
        MURIM_RAID_DEFENSE.tailorMode and "RECUO TAILOR CURTO; HP %.0f/%.0f; retoma %.0f"
            or "RECUO VERTICAL; HP %.0f/%.0f; retoma %.0f",hp,maxHP,resume)
    if os.clock()-MURIM_RAID_DEFENSE.lastWarnAt>22 then
        MURIM_RAID_DEFENSE.lastWarnAt=os.clock()
        MURIM_TRACE.add("INFO","SegurancaHP",string.format(
            "Defesa ativa. HP atual %.0f/%.0f, minimo %.0f para voltar. Se HP nao regenerar, manter combate pausado.",hp,maxHP,resume))
    end
    return true
end

-- V16 A04: percurso CONTINUO (sem instancias/telas), acender 3 lanternas e
-- usar esconderijos em caso de Watchman/procissao. Travessia por piso verificado.
MURIM_A04={
    responses={},processionUntil=0,searchIndex=1,
    phase="aguardando",lamps={},seenEnabled={},lampCount=0,attempts=setmetatable({},{__mode="k"}),
    lastTick=0,lastMove=0,lastNotice=0,pending=nil,firstHideDone=false,
    lastHideAt=0,hideUntil=0,hidePrompt=nil,hideAttempt=0,
    lastThreatDist=math.huge,recedingTicks=0,safeResumeUntil=0,
    lastPromptAttempt=setmetatable({},{__mode="k"}),
    reenabledSince={},
    -- V18P: Hide e uma tentativa, NAO prova que entrou no esconderijo.
    hideEntryPos=nil,hideEntryAnchored=false,hideEntryAt=0,
    hideClosestDist=math.huge,hideExitAt=0,hideExitPrompt=nil,
    hideAnchorPos=nil,hideExitRetries=0,
    -- V18P: estado de LOG; nao confundir interacao pcall com efeito do servidor.
    debugStatus="nao iniciou A04",debugDecision="aguardando A04",
    hideState="nao acionado",lastDebugAt=0,
    exitStartPos=nil,exitCheckAt=0,exitReportAt=0,
    exitSeenOpen=false,exitDoorZ=nil,
    comeOutVisible=false,comeOutAwaiting=false,comeOutAttempts=0,comeOutAttemptAt=0,
}
function MURIM_A04.reset()
    if MURIM_A04.stopRun then MURIM_A04.stopRun() end
    if MURIM_A04.cancelHold then MURIM_A04.cancelHold() end
    MURIM_A04.responses={}
    MURIM_A04.processionUntil=0; MURIM_A04.safeSince=nil; MURIM_A04.searchIndex=1
    MURIM_A04.raid=nil; MURIM_A04.character=nil
    MURIM_A04.route=nil; MURIM_A04.routeAt=0
    MURIM_A04.phase="procurando 3 lanternas"
    MURIM_A04.lamps={}; MURIM_A04.seenEnabled={}; MURIM_A04.lampCount=0
    MURIM_A04.attempts=setmetatable({},{__mode="k"})
    MURIM_A04.lastTick=0; MURIM_A04.lastMove=0; MURIM_A04.lastNotice=0
    MURIM_A04.pending=nil; MURIM_A04.firstHideDone=false
    MURIM_A04.lastHideAt=0; MURIM_A04.hideUntil=0; MURIM_A04.hidePrompt=nil; MURIM_A04.hideAttempt=0
    MURIM_A04.lastThreatDist=math.huge; MURIM_A04.recedingTicks=0; MURIM_A04.safeResumeUntil=0
    MURIM_A04.lastPromptAttempt=setmetatable({},{__mode="k"})
    MURIM_A04.reenabledSince={}
    MURIM_A04.hideEntryPos=nil;MURIM_A04.hideEntryAnchored=false
    MURIM_A04.hideEntryAt=0;MURIM_A04.hideClosestDist=math.huge
    MURIM_A04.hideExitAt=0;MURIM_A04.hideExitPrompt=nil
    MURIM_A04.hideAnchorPos=nil;MURIM_A04.hideExitRetries=0
    MURIM_A04.debugStatus="A04 reiniciada; tick ainda nao observado";MURIM_A04.debugDecision="aguardando"
    MURIM_A04.firstTickLogged=false
    MURIM_A04.hideState="nao acionado";MURIM_A04.lastDebugAt=0
    MURIM_A04.exitStartPos=nil;MURIM_A04.exitCheckAt=0;MURIM_A04.exitReportAt=0
    MURIM_A04.navOrigin=nil; MURIM_A04.pendingMove=nil; MURIM_A04.lastFloorFailure=0
    MURIM_A04.exitSeenOpen=false; MURIM_A04.exitDoorZ=nil
    MURIM_A04.comeOutVisible=false;MURIM_A04.comeOutAwaiting=false
    MURIM_A04.comeOutAttempts=0;MURIM_A04.comeOutAttemptAt=0
end
-- V18R: leitura SOMENTE do mundo atual para o diagnostico, mesmo com Auto OFF.
-- O contador historico do automatico nao equivale a situacao apos E manual.
function MURIM_A04.observeWorld()
    local model,origin=getActiveRaidInfo(player)
    local area=model and model:FindFirstChild("A04_WatchmanStreet",true)
    if not area or not origin then return "modelo A04 indisponivel" end
    local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root or math.abs(root.Position.X-origin.X)>180 then
        return "FORA DA RAID; dados A04 anteriores sao historicos, streaming nao e prova"
    end
    local total,disabled=0,0
    local gateZ=nil
    for _,obj in ipairs(area:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local a=(obj.ActionText or ""):lower()
            if a:find("light the shrine lamp",1,true) then
                total+=1
                if not obj.Enabled then disabled+=1 end
            end
        elseif obj:IsA("Model") and obj.Name=="HallowDoor"
            and obj:GetAttribute("Open")==true then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            local rel=part and part.Position.Z-origin.Z
            if rel and rel>=850 and rel<=955
                and (not gateZ or math.abs(rel-898)<math.abs(gateZ-898)) then
                gateZ=rel
            end
        end
    end
    return string.format("santuarios desabilitados=%d/%d (nao prova sozinho conclusao); "..
        "porta de saida A04 Open=true em %s",
        disabled,total,gateZ and string.format("Z+%.0f",gateZ) or "nao observada")
end
function MURIM_A04.scanThreat(root,origin)
    local folder=workspace:FindFirstChild("Murim_NPCs")
    local threat,dist,what=nil,math.huge,nil
    if not folder then return nil,math.huge,nil end
    for _,npc in ipairs(folder:GetChildren()) do
        if npc:IsA("Model") and npc.Parent then
            local n=npc.Name:lower()
            if n:find("watchman",1,true) or n:find("red sedan",1,true) or n:find("procession",1,true) then
                local part=npc.PrimaryPart or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart",true)
                if part and part.Position.Z-origin.Z>=510 and part.Position.Z-origin.Z<=985 then
                    local d=(part.Position-root.Position).Magnitude
                    if d<dist then threat,dist,what=npc,d,npc.Name end
                end
            end
        end
    end
    return threat,dist,what
end
-- V18J: movimentacao dedicada da A04. Na V18I, a 1a sondagem partia
-- acima de um teto, e a 2a (safeWarp) repetia a sondagem no teto.
-- Sondar abaixo do teto e mover APENAS sobre piso validado, sem reentrar
-- na safeWarp da A01. Nao altera os movimentos das A01-A03.
function MURIM_A04.advance(root,dest,why,validateLanding)
    if not root or not root.Parent or not dest then return false end
    MURIM_A04.checkLastMove(root)
    if MURIM_A04.pendingMove then return true end
    local delta=Vector3.new(dest.X-root.Position.X,0,dest.Z-root.Position.Z)
    if delta.Magnitude<2.8 then return true end
    local origin=MURIM_A04.navOrigin
    local original=root.Position
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={root.Parent}
    params.IgnoreWater=true
    pcall(function() MURIM_RAID_NAV.configure(root,params) end)

    -- V18M parava se nao houvesse piso exatamente a 30 studs.
    -- Testar uma rota central de SAIDA do Hide e distancias menores antes de
    -- concluir que o caminho esta bloqueado. Nunca mover sem piso real.
    local probes={}
    local function addProbe(v,tag)
        if v and (Vector3.new(v.X-original.X,0,v.Z-original.Z)).Magnitude>=3 then
            probes[#probes+1]={pos=v,tag=tag}
        end
    end
    local relOff=origin and (original.X-origin.X) or 0
    if not validateLanding and origin and math.abs(relOff)>14 and delta.Z>6 then
        local towardCenter=math.clamp(origin.X-original.X,-12,12)
        addProbe(Vector3.new(original.X+towardCenter,original.Y,
            original.Z+math.min(6,delta.Z)),"retomar corredor central")
        addProbe(Vector3.new(original.X+towardCenter,original.Y,original.Z),
            "sair lateralmente do esconderijo")
    end
    for _,step in ipairs({30,20,12,7,4}) do
        local length=math.min(step,delta.Magnitude)
        local forward=original+delta.Unit*length
        addProbe(forward,"passo "..tostring(step))
        if MURIM_RAID_NAV.failed[root] then
            local side=Vector3.new(-delta.Unit.Z,0,delta.Unit.X)*7
            addProbe(forward+side,"alternativa lateral +7")
            addProbe(forward-side,"alternativa lateral -7")
        end
    end
    local lastFailure="nenhuma superficie"
    local checked=0
    local selected,whySelected
    for _,candidate in ipairs(probes) do
        local px,pz=candidate.pos.X,candidate.pos.Z
        local ignored={root.Parent}
        params.FilterDescendantsInstances=ignored
        local surface=nil
        -- Uma sondagem nao pode ser tratada como valida se encontra teto,
        -- lampada, parede ou componente sem colisao em vez de piso.
        for _,lift in ipairs({2.5,6.5,10.5}) do
            local rayY=original.Y+lift
            for _=1,7 do
                local hit=workspace:Raycast(Vector3.new(px,rayY,pz),
                    Vector3.new(0,-75,0),params)
                checked+=1
                if not hit or not hit.Instance then
                    lastFailure="sem hit de piso em "..candidate.tag
                    break
                end
                local part=hit.Instance
                local n=part.Name:lower()
                local decorative=n:find("ceiling",1,true) or n:find("roof",1,true)
                    or n:find("overdoor",1,true) or n:find("canopy",1,true)
                    or n:find("lantern",1,true) or n:find("lamp",1,true)
                    or n:find("doorbeam",1,true) or n:find("seal",1,true)
                local landing=hit.Position+Vector3.new(0,3.5,0)
                local good=MURIM_RAID_NAV.support(root,hit,params)
                    and not decorative and math.abs(landing.Y-original.Y)<=23
                    and (landing-original).Magnitude<=34
                if good then
                    surface={landing=landing,name=part.Name,hit=hit}
                    break
                end
                -- Nao parar na primeira decoracao/parede; procurar a camada
                -- horizontal seguinte, com filtro local a cada tentativa.
                if not decorative then
                    lastFailure="normal ou colisao insegura: "..part.Name
                end
                ignored[#ignored+1]=part
                params.FilterDescendantsInstances=ignored
                rayY=hit.Position.Y-0.2
            end
            if surface then break end
        end
        if surface and (not validateLanding or validateLanding(surface.landing)) then
            selected=surface
            whySelected=candidate.tag
            break
        end
    end
    if not selected then
        MURIM_A04.lastFloorFailure=(MURIM_A04.lastFloorFailure or 0)+1
        MURIM_TRACE.add("AVISO","Watchman",string.format(
            "A04 sem piso para %s; %d sondagens em %d pontos, ultima causa=%s. Mantendo posicao sem salto.",
            tostring(why),checked,#probes,lastFailure),8)
        return false
    end
    MURIM_RAID_NAV.note("Pouso "..tostring(why)..": "..MURIM_RAID_NAV.describe(selected.hit))
    local landing=selected.landing
    root.CFrame=CFrame.new(landing)
    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    MURIM_A04.lastFloorFailure=0
    MURIM_A04.pendingMove={at=os.clock(),from=original,to=landing,tag=whySelected}
    MURIM_A01.lastMoveAt=os.clock()
    MURIM_A01.lastAction="Mover para A04 "..tostring(why)
    MURIM_TRACE.add("MOVIMENTO","AutoA04",string.format(
        "Destino %s; via=%s, piso=%s; pos=(%.0f,%.0f,%.0f).",
        tostring(why),tostring(whySelected),selected.name,landing.X,landing.Y,landing.Z))
    return true
end
-- V18R: a GUI do jogo mostra "Come out" quando ainda esta escondido.
-- NUNCA inferir saida a partir de root.CFrame. Nao invocar Hide como saida.
function MURIM_A04.checkLastMove(root)
    local previous=MURIM_A04.pendingMove
    if not previous or os.clock()-previous.at<0.35 then return end
    local d=(Vector3.new(root.Position.X,0,root.Position.Z)-
        Vector3.new(previous.to.X,0,previous.to.Z)).Magnitude
    if d>9 or root.Position.Y<previous.to.Y-8 then
        MURIM_RAID_NAV.reject(root,previous.to)
        MURIM_TRACE.add("AVISO","AutoA04",string.format(
            "Movimento nao persistiu: desvio %.1f studs; jogo pode ter "..
            "corrigido a posicao. Nao contar deslocamento nem declarar saida do Hide.",d),5)
    end
    MURIM_A04.pendingMove=nil
end

-- Detectar SOMENTE a acao de sair, nao textos de logs ou o botao de esconder.
-- A captura do usuario mostra 'Come out' no canto inferior direito.
function MURIM_A04.findComeOut()
    local roots={player:FindFirstChild("PlayerGui")}
    local okCore,core=pcall(function() return game:GetService("CoreGui") end)
    if okCore and core then roots[#roots+1]=core end
    for _,guiRoot in ipairs(roots) do
        if guiRoot then
            for _,obj in ipairs(guiRoot:GetDescendants()) do
                if (obj:IsA("GuiButton") or obj:IsA("TextLabel"))
                    and isHallowGuiVisible(obj) then
                    local raw=(obj:IsA("TextButton") or obj:IsA("TextLabel")) and obj.Text or ""
                    local txt=raw:lower():gsub("<[^>]+>",""):gsub("^%s+",""):gsub("%s+$","")
                    txt=txt:gsub("%s+"," ")
                    local name=(obj.Name or ""):lower()
                    local matches=(#txt<80 and (txt:find("%f[%a]come out%f[%A]") or txt:find("%f[%a]leave hiding%f[%A]")))
                        or txt=="sair do esconderijo" or txt=="sair de esconderijo"
                        or (obj:IsA("GuiButton") and (name=="comeout" or name=="unhide"))
                    if matches then
                        local button=obj:IsA("GuiButton") and obj or obj:FindFirstAncestorWhichIsA("GuiButton")
                        return obj,button
                    end
                end
            end
        end
    end
    return nil,nil
end

-- Uma unica tentativa por intervalo; resultado apenas quando a UI desaparecer.
function MURIM_A04.ensureComeOut(root,now)
    local label,button=MURIM_A04.findComeOut()
    MURIM_A04.comeOutVisible=(label~=nil)
    if not label then
        if MURIM_A04.comeOutAwaiting and now-(MURIM_A04.comeOutAttemptAt or 0)>=1 then
            MURIM_A04.hideState="Come out NAO visivel; saida visual (servidor nao comprovado)"
            MURIM_TRACE.add("EVIDENCIA","A04ComeOut",
                "O texto Come out deixou de aparecer apos tentativa de saida. "..
                "Isto confirma somente a GUI; nao inferir resultado pelo teleporte.",5)
            MURIM_A04.comeOutAwaiting=false
        elseif not MURIM_A04.comeOutAwaiting and (MURIM_A04.comeOutAttempts or 0)==0 then
            MURIM_A04.hideState="sem Hide automatico; Come out ausente"
        end
        return false
    end
    MURIM_A04.phase="COME OUT na tela: sair antes de tocar lanternas"
    MURIM_A04.hideState="COME OUT VISIVEL; personagem ainda no modo esconder"
    MURIM_A04.debugDecision="BLOQUEIO: Come out visivel; nao mover nem acionar lanternas"
    if now-(MURIM_A04.comeOutAttemptAt or 0)<2.5 then return true end
    if (MURIM_A04.comeOutAttempts or 0)>=4 then
        if now-MURIM_A04.comeOutAttemptAt<8 then return true end
        MURIM_A04.comeOutAttempts=0
    end
    MURIM_A04.comeOutAttempts+=1
    MURIM_A04.comeOutAttemptAt=now
    MURIM_A04.comeOutAwaiting=true
    local count=MURIM_A04.comeOutAttempts
    local ok,via=false,"indisponivel"
    -- Roblox nao oferece GuiButton:Activate(); usar input real ou evento no executor.
    if count==1 or count==4 then
        via="VirtualInputManager click no Come out"
        local target=button or label
        local abs=target.AbsolutePosition
        local size=target.AbsoluteSize
        local px=math.floor(abs.X+size.X*0.5)
        local py=math.floor(abs.Y+size.Y*0.5)
        ok=pcall(function()
            local vim=game:GetService("VirtualInputManager")
            vim:SendMouseButtonEvent(px,py,0,true,game,0)
            task.wait(0.09)
            vim:SendMouseButtonEvent(px,py,0,false,game,0)
        end)
    elseif button and typeof(firesignal)=="function" then
        via=count==2 and "firesignal Activated" or "firesignal MouseButton1Click"
        ok=pcall(function()
            if count==2 then firesignal(button.Activated)
            else firesignal(button.MouseButton1Click) end
        end)
    else
        via="VirtualInputManager click no texto Come out (fallback)"
        local px=math.floor(label.AbsolutePosition.X+label.AbsoluteSize.X*0.5)
        local py=math.floor(label.AbsolutePosition.Y+label.AbsoluteSize.Y*0.5)
        ok=pcall(function()
            local vim=game:GetService("VirtualInputManager")
            vim:SendMouseButtonEvent(px,py,0,true,game,0)
            task.wait(0.09)
            vim:SendMouseButtonEvent(px,py,0,false,game,0)
        end)
    end
    MURIM_TRACE.add(ok and "ACAO" or "AVISO","A04ComeOut",string.format(
        "Come out VISIVEL; tentativa=%d/4; metodo=%s; chamada=%s. "..
        "NENHUMA saida confirmada; aguardando sumir o controle da tela.",
        count,via,tostring(ok)),4)
    return true
end

-- V18P: observacao passiva. Objetivo: o diagnostico copiado explicar
-- POR QUE espera, se a entrada foi comprovada e se a saida persistiu.
function MURIM_A04.logSnapshot(root,origin,lamps,threatDist,threatName,now,reason)
    local closestLampDist,closestLampKey=math.huge,"-"
    for _,item in ipairs(lamps) do
        if item.prompt.Enabled and not MURIM_A04.lamps[item.key] and item.d<closestLampDist then
            closestLampDist=item.d
            closestLampKey=item.key
        end
    end
    local waitTime=math.max(0,MURIM_A04.hideUntil-now)
    local threatText=threatDist==math.huge and "sem NPC detectado" or string.format("%.0f studs",threatDist)
    local lampText=closestLampDist==math.huge and "nenhuma habilitada" or
        string.format("Z+%s a %.0f studs",closestLampKey,closestLampDist)
    local state=tostring(MURIM_A04.hideState)
    MURIM_A04.debugDecision=reason or MURIM_A04.debugDecision
    MURIM_A04.debugStatus=string.format(
        "posZ+%.0f; Hide=%s; decisao=%s; Watchman=%s; espera=%.0fs; "..
        "afastando=%d leituras; ComeOutGUI=%s; lamps=%d/3; proxima=%s; ultima falha piso=%d",
        root.Position.Z-origin.Z,state,tostring(MURIM_A04.debugDecision),
        threatText,waitTime,MURIM_A04.recedingTicks,
        MURIM_A04.comeOutVisible and "VISIVEL" or "ausente",
        MURIM_A04.lampCount,lampText,MURIM_A04.lastFloorFailure or 0)
    if now-(MURIM_A04.lastDebugAt or 0)>=7 then
        MURIM_A04.lastDebugAt=now
        MURIM_TRACE.add("DIAGNOSTICO","A04Estado",MURIM_A04.debugStatus)
    end
end

-- A04 observes live objects on every tick; disabled prompts alone are not completion.
function MURIM_A04.promptPosition(prompt)
    local parent=prompt.Parent
    if not parent then return nil end
    if parent:IsA("Attachment") then return parent.WorldPosition end
    if parent:IsA("BasePart") then return parent.Position end
    if parent:IsA("Model") then return parent:GetPivot().Position end
    local part=prompt:FindFirstAncestorWhichIsA("BasePart")
    return part and part.Position
end

function MURIM_A04.lit(prompt,area)
    local node=prompt
    while node and node~=area do
        local value=node:GetAttribute("Lit")
        if value~=nil then return value==true end
        node=node.Parent
    end
    return false
end

function MURIM_A04.readWorld(root,raid,origin)
    local area=raid:FindFirstChild("A04_WatchmanStreet",true)
    local world={area=area,lamps={},oil={},pickup={},hides={},gate=nil,count=0}
    if not area then return world end
    for _,obj in ipairs(area:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local pos=MURIM_A04.promptPosition(obj)
            if pos then
                local action=(obj.ActionText or ""):lower()
                local object=(obj.ObjectText or ""):lower()
                local item={prompt=obj,pos=pos,d=(pos-root.Position).Magnitude,
                    key=string.format("%.0f:%.0f:%.0f",pos.X-origin.X,pos.Y-origin.Y,pos.Z-origin.Z)}
                if action:find("light the shrine lamp",1,true)
                    or (object:find("street shrine",1,true) and action:find("light",1,true)) then
                    item.lit=MURIM_A04.lit(obj,area)
                    if item.lit then world.count+=1 end
                    table.insert(world.lamps,item)
                elseif action:find("refill your lantern",1,true) then
                    table.insert(world.oil,item)
                elseif (action:find("take",1,true) or action:find("pick",1,true))
                    and (action.." "..object):find("lantern",1,true) then
                    table.insert(world.pickup,item)
                elseif action=="hide" then
                    table.insert(world.hides,item)
                end
            end
        elseif obj:IsA("Model") and obj.Name=="HallowDoor" then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            local z=part and part.Position.Z-origin.Z
            local open=obj:GetAttribute("Open")==true
            if z and z>=850 and z<=955 and (not world.gate
                or (open and not world.gate.open) or (open==world.gate.open and z>world.gate.z)) then
                world.gate={model=obj,z=z,open=open}
            end
        end
    end
    for _,list in ipairs({world.lamps,world.oil,world.pickup,world.hides}) do
        table.sort(list,function(a,b) return a.d<b.d end)
    end
    if world.gate and world.gate.open and #world.lamps==3 then
        local disabled=0
        for _,item in ipairs(world.lamps) do if not item.prompt.Enabled then disabled+=1 end end
        if disabled==3 then world.count=3 end -- live door + all three prompts, not manual/auto attribution
    end
    return world
end

function MURIM_A04.threats(raid,origin)
    local result,seen={},{}
    local folders={raid}
    local npcs=workspace:FindFirstChild("Murim_NPCs")
    if npcs then table.insert(folders,npcs) end
    for _,folder in ipairs(folders) do
        for _,npc in ipairs(folder:GetDescendants()) do
            if npc:IsA("Model") and not seen[npc]
                and (npc.Parent==npcs or npc:FindFirstChildWhichIsA("Humanoid") or npc:GetAttribute("HallowId")~=nil) then
                seen[npc]=true
                local name=npc.Name:lower()
                local procession=name:find("sedan",1,true) or name:find("procession",1,true)
                if procession or name:find("watchman",1,true) or name:find("faceless",1,true) then
                    local part=npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                        or npc:FindFirstChildWhichIsA("BasePart",true)
                    if part and math.abs(part.Position.X-origin.X)<180
                        and part.Position.Z-origin.Z>=500 and part.Position.Z-origin.Z<=1020 then
                        table.insert(result,{model=npc,part=part,procession=not not procession})
                    end
                end
            end
        end
    end
    return result
end

-- Distances are conservative navigation margins, not claims about server detection rules.
function MURIM_A04.riskAt(pos,root,threats,holding)
    local worst,nearest=0,math.huge
    for _,t in ipairs(threats) do
        local offset=pos-t.part.Position
        local dist=offset.Magnitude
        nearest=math.min(nearest,dist)
        local radius=t.procession and 100 or (holding and 100 or 75)
        local facing=dist>0 and t.part.CFrame.LookVector:Dot(offset.Unit) or 1
        if dist<radius and (t.procession or facing>0.05 or dist<32) then
            local params=RaycastParams.new()
            params.FilterType=Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances={root.Parent,t.model}
            pcall(function() params.RespectCanCollide=true end)
            local hit=workspace:Raycast(t.part.Position,offset,params)
            if not hit or (hit.Position-pos).Magnitude<2 then
                worst=math.max(worst,1-dist/radius)
            end
        end
    end
    return worst,nearest
end

-- Local ground graph for streamed raid geometry. Does not depend on the
-- global navigation mesh reaching a distant exit beyond the loaded room.
function MURIM_A04.localRoute(root,dest,validEdge)
    local start=root.Position
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={root.Parent}
    params.IgnoreWater=true
    pcall(function() MURIM_RAID_NAV.configure(root,params) end)
    local function ground(x,z,y)
        local hit=workspace:Raycast(Vector3.new(x,y+3,z),Vector3.new(0,-12,0),params)
        if not MURIM_RAID_NAV.surface(root,hit) then return nil end
        local n=hit.Instance.Name:lower()
        if n:find("roof",1,true) or n:find("ceiling",1,true)
            or n:find("lantern",1,true) or n:find("lamp",1,true) then return nil end
        local pos=hit.Position+Vector3.new(0,3.5,0)
        if math.abs(pos.Y-y)>5 then return nil end
        return pos
    end
    local nodes={{x=0,z=0,pos=start,parent=nil}}
    local seen={["0:0"]=true}
    local best,bestScore=nil,math.huge
    local head=1
    while head<=#nodes and head<=225 do
        local node=nodes[head]
        for _,dir in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
            local x,z=node.x+dir[1],node.z+dir[2]
            local key=x..":"..z
            if math.abs(x)<=7 and math.abs(z)<=7 and not seen[key] then
                local pos=ground(start.X+x*4,start.Z+z*4,node.pos.Y)
                if pos and validEdge(node.pos,pos) then
                    seen[key]=true
                    local nextNode={x=x,z=z,pos=pos,parent=head}
                    table.insert(nodes,nextNode)
                    local score=Vector3.new(pos.X-dest.X,0,pos.Z-dest.Z).Magnitude
                    if score<bestScore then best,bestScore=#nodes,score end
                end
            end
        end
        head+=1
    end
    if not best or bestScore>=Vector3.new(start.X-dest.X,0,start.Z-dest.Z).Magnitude-0.1 then
        return nil,#nodes
    end
    local points={}
    while nodes[best].parent do
        table.insert(points,1,nodes[best].pos)
        best=nodes[best].parent
    end
    return {dest=dest,points=points,index=1},#nodes
end

function MURIM_A04.move(root,dest,why,threats,escape)
    local offset=Vector3.new(dest.X-root.Position.X,0,dest.Z-root.Position.Z)
    if offset.Magnitude<2 then return true end
    local currentRisk=MURIM_A04.riskAt(root.Position,root,threats,false)
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={root.Parent}
    pcall(function() MURIM_RAID_NAV.configure(root,params) end)
    local function validEdge(from,to)
        for _,alpha in ipairs({0.5,1}) do
            local pos=from+(to-from)*alpha
            if MURIM_A04.riskAt(pos,root,threats,false)>(escape and currentRisk+0.02 or 0) then return false end
        end
        -- Check center and both body edges; a clear center ray is not a clear doorway.
        local delta=to-from
        local flat=Vector3.new(delta.X,0,delta.Z)
        if flat.Magnitude<0.1 then return true end
        local side=Vector3.new(-flat.Z,0,flat.X).Unit*1.2
        for _,shift in ipairs({Vector3.zero,side,side*-1}) do
            local hit=workspace:Raycast(from+shift,delta,params)
            if hit and (hit.Position-(to+shift)).Magnitude>=0.7 then return false end
        end
        return true
    end
    local function validLanding(landing) return validEdge(root.Position,landing) end
    local function follow(route)
        while route.points[route.index] and
            (route.points[route.index]-root.Position).Magnitude<2.5 do route.index+=1 end
        local point=route.points[route.index]
        if not point then return nil end
        if (point-root.Position).Magnitude>14 then return false end
        return MURIM_A04.advance(root,point,why.." via rota local",validLanding)
    end
    -- Finish a detour before attempting the obstructed straight line again.
    local route=MURIM_A04.route
    if route and (route.dest-dest).Magnitude<=5 then
        local followed=follow(route)
        if followed then return true end
        MURIM_A04.route=nil
    else MURIM_A04.route=nil end
    local nextPos=root.Position+offset.Unit*math.min(12,offset.Magnitude)
    if validLanding(nextPos) and MURIM_A04.advance(root,nextPos,why,validLanding) then return true end
    local now=os.clock()
    if now-(MURIM_A04.routeAt or 0)<1 then return false end
    MURIM_A04.routeAt=now
    local nodes
    route,nodes=MURIM_A04.localRoute(root,dest,validEdge)
    if not route then
        MURIM_A04.navFailure="sem rota local: "..tostring(nodes).." pontos conectados"
        MURIM_TRACE.add("AVISO","A04Rota",MURIM_A04.navFailure,5)
        return false
    end
    MURIM_A04.route=route
    MURIM_A04.navFailure=nil
    MURIM_TRACE.add("MOVIMENTO","A04Rota",string.format(
        "Rota ao redor do bloqueio: %d pontos; %d pisos conectados; primeiro X=%.0f Z=%.0f",
        #route.points,nodes,route.points[1].X,route.points[1].Z),3)
    return follow(route) or false
end

function MURIM_A04.cancelHold()
    local pending=MURIM_A04.pending
    if pending and pending.connection then pending.connection:Disconnect() end
    if pending and pending.keyDown then
        pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(false,pending.inputKey,false,game) end)
    end
    if pending and pending.holding and pending.prompt.Parent then
        pcall(function() pending.prompt:InputHoldEnd() end)
    end
    MURIM_A04.pending=nil
end

function MURIM_A04.startPrompt(item,kind,now)
    local prompt=item.prompt
    if not prompt.Parent or not prompt.Enabled then return end
    local count=(MURIM_A04.attempts[prompt] or 0)+1
    MURIM_A04.attempts[prompt]=count
    MURIM_A04.lastPromptAttempt[prompt]=now
    local pending={prompt=prompt,key=item.key,kind=kind,at=now,
        holding=true,hold=math.max(0,prompt.HoldDuration)+0.2,attempt=count,triggered=false}
    MURIM_A04.pending=pending
    if prompt.Triggered then
        pending.connection=prompt.Triggered:Connect(function(who)
            if who==nil or who==player then pending.triggered=true end
        end)
    end
    -- First attempt: the specific prompt. Retry: actual configured key, as in
    -- the manual interaction. Neither method treats a successful call as success.
    local ok,err=pcall(function()
        if count%2==0 and prompt.KeyboardKeyCode and prompt.KeyboardKeyCode~=Enum.KeyCode.Unknown then
            pending.inputKey=prompt.KeyboardKeyCode
            pending.keyDown=true
            game:GetService("VirtualInputManager"):SendKeyEvent(true,pending.inputKey,false,game)
        else
            prompt:InputHoldBegin()
        end
    end)
    if not ok then
        MURIM_TRACE.add("ERRO","A04Prompt",tostring(err),5)
    end
    MURIM_A04.phase="segurando prompt: "..kind
end

function MURIM_A04.updatePrompt(root,world,now)
    local p=MURIM_A04.pending
    if not p then return false end
    if not p.prompt.Parent then
        -- Streaming/removal is not evidence of completing an objective.
        MURIM_A04.cancelHold()
        return false
    end
    local pos=MURIM_A04.promptPosition(p.prompt)
    if p.holding and (not pos or (root.Position-pos).Magnitude>p.prompt.MaxActivationDistance) then
        MURIM_A04.cancelHold()
        return false
    end
    if p.holding then
        if now-p.at<p.hold and p.prompt.Enabled then return true end
        if p.keyDown then
            pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(false,p.inputKey,false,game) end)
            p.keyDown=false
        end
        pcall(function() p.prompt:InputHoldEnd() end)
        p.holding=false
        p.releasedAt=now
        -- Alternate after a full real hold if the previous InputHold did not work.
        -- The required duration has already elapsed; never leave a background
        -- hold running after cancellation, toggle-off, death, or a new threat.
        if not p.triggered and p.prompt.Enabled and typeof(fireproximityprompt)=="function" then
            local ok,err=pcall(function() fireproximityprompt(p.prompt,0) end)
            if not ok then MURIM_TRACE.add("ERRO","A04Prompt",tostring(err),5) end
        end
        MURIM_TRACE.add("ACAO","A04Prompt",p.kind.." hold completo; tentativa "..p.attempt.."; aguardando efeito")
        return true
    end
    local lit=p.kind=="Street Shrine" and MURIM_A04.lit(p.prompt,world.area)
    local disabled=not p.prompt.Enabled
    if lit or disabled then
        -- Record response separately from confirmed Lit/exit door.
        MURIM_A04.responses[p.key]={at=now,kind=p.kind}
        if p.kind=="Street Shrine" and not MURIM_A04.firstHideDone then
            MURIM_A04.firstHideDone=true
            MURIM_A04.processionUntil=now+12
        end
        MURIM_TRACE.add("EVIDENCIA","A04Prompt",p.kind..": "..
            (lit and "Lit=true" or "Enabled=false; resposta observada, conclusao ainda nao confirmada"))
        MURIM_A04.cancelHold()
        return false
    end
    if now-p.releasedAt>=3 then
        MURIM_TRACE.add("AVISO","A04Prompt",p.kind.." sem efeito observado; repetir o MESMO prompt apos intervalo",5)
        MURIM_A04.cancelHold()
        return false
    end
    return true
end

function MURIM_A04.avoidThreat(root,world,threats,now)
    -- No automatic Hide. Only grounded retreat from an observed threat.
    -- No reachable hide: retreat along grounded positions away from the closest threat.
    local nearest=nil
    for _,t in ipairs(threats) do
        if not nearest or (t.part.Position-root.Position).Magnitude<
            (nearest.part.Position-root.Position).Magnitude then nearest=t end
    end
    if nearest then
        local away=Vector3.new(root.Position.X-nearest.part.Position.X,0,root.Position.Z-nearest.part.Position.Z)
        if away.Magnitude>0 then
            local dest=root.Position+away.Unit*10
            dest=Vector3.new(math.clamp(dest.X,MURIM_A04.navOrigin.X-45,MURIM_A04.navOrigin.X+45),
                dest.Y,math.clamp(dest.Z,MURIM_A04.navOrigin.Z+535,MURIM_A04.navOrigin.Z+955))
            return MURIM_A04.move(root,dest,"recuar da ameaca",threats,true)
        end
    end
    return false
end

function MURIM_A04.stopRun()
    local run=MURIM_A04.running
    MURIM_A04.running=nil
    if not run or not run.humanoid.Parent then return end
    if run.humanoid.WalkSpeed==run.speed then run.humanoid.WalkSpeed=run.originalSpeed end
    -- Stop only the movement owned by this controller.
    run.humanoid:Move(Vector3.zero,false)
    if run.root.Parent then run.humanoid:MoveTo(run.root.Position) end
end

function MURIM_A04.houndNear(root,origin)
    if root.Position.Z-origin.Z<850 then return false end
    local folder=workspace:FindFirstChild("Murim_NPCs")
    if not folder then return false end
    for _,npc in ipairs(folder:GetChildren()) do
        if npc:IsA("Model") and npc.Name:lower()=="the hound" then
            local part=npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
            if part and (part.Position-root.Position).Magnitude<120 then return true end
        end
    end
    return false
end

function MURIM_A04.escapeLanding(root,origin)
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={root.Parent}
    params.IgnoreWater=true
    pcall(function() MURIM_RAID_NAV.configure(root,params) end)
    local rayY=math.max(origin.Y-10,root.Position.Y+5)
    local function sample(x,z)
        local hit=workspace:Raycast(Vector3.new(x,rayY,z),Vector3.new(0,-65,0),params)
        if not MURIM_RAID_NAV.surface(root,hit)
            or hit.Position.Y<origin.Y-35 or hit.Position.Y>origin.Y+5 then return nil end
        local node=hit.Instance
        for _=1,8 do
            if not node then break end
            local name=node.Name:lower()
            if name=="pit" or name:find("spike",1,true) or name:find("trap",1,true)
                or name:find("roof",1,true) or name:find("ceiling",1,true) then return nil end
            node=node.Parent
        end
        return hit
    end
    for _,step in ipairs({28,24,20,16,12,8}) do
        local z=math.min(root.Position.Z+step,origin.Z+970)
        for _,dx in ipairs({0,-3,3}) do
            local x=origin.X+dx
            local hit=sample(x,z)
            if hit then
                local supported=true
                for _,off in ipairs({{1.5,0},{-1.5,0},{0,1.5},{0,-1.5}}) do
                    local side=sample(x+off[1],z+off[2])
                    if not side or math.abs(side.Position.Y-hit.Position.Y)>3 then supported=false;break end
                end
                if supported then
                    local ceiling=workspace:Raycast(hit.Position+Vector3.new(0,0.2,0),Vector3.new(0,5.5,0),params)
                    if not ceiling then return hit.Position+Vector3.new(0,3.5,0),hit.Instance.Name end
                end
            end
        end
    end
    return nil
end

function MURIM_A04.runExit(root,origin,now)
    local humanoid=root.Parent and root.Parent:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health<=0 then MURIM_A04.stopRun();return true end
    if root.Position.Z-origin.Z>=960 then
        MURIM_A04.stopRun()
        MURIM_A04.phase="fuga A04 concluida; transicao para A05"
        return true
    end
    if root.Anchored then
        MURIM_A04.phase="fuga bloqueada: personagem ancorado pelo jogo"
        return true
    end
    local run=MURIM_A04.running
    if run and (root.Position.Z-origin.Z<850
        or (run.expected and root.Position.Z<run.expected.Z-45)) then
        MURIM_A04.stopRun()
        MURIM_A04.phase="deslocamento para tras observado; relendo porta e santuarios"
        MURIM_TRACE.add("AVISO","A04Teleporte","Fuga invalidada por retorno ao checkpoint/correcao de posicao. Nao reutilizar rota antiga.",3)
        return false
    end
    if not run then
        run={root=root,humanoid=humanoid,originalSpeed=humanoid.WalkSpeed,
            speed=humanoid.WalkSpeed,origin=origin,lastWarp=-100}
        MURIM_A04.running=run
        MURIM_A04.route=nil
        humanoid:Move(Vector3.zero,false)
        humanoid:MoveTo(root.Position)
    end
    if now-run.lastWarp<0.25 then return true end
    run.lastWarp=now
    if run.expected then
        local errorDistance=(root.Position-run.expected).Magnitude
        if errorDistance>12 then
            MURIM_TRACE.add("AVISO","A04Teleporte",string.format("Posicao corrigida/deslocada %.0f studs apos salto; recalculando do ponto real.",errorDistance),3)
        end
    end
    local landing,floor=MURIM_A04.escapeLanding(root,origin)
    if not landing then
        MURIM_A04.phase="fuga: sem piso de pouso carregado; nao saltar no vazio"
        MURIM_TRACE.add("AVISO","A04Teleporte",MURIM_A04.phase,3)
        return true
    end
    root.CFrame=CFrame.new(landing)
    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    run.expected=landing
    MURIM_A04.phase="fuga: teleporte para A05"
    MURIM_A04.debugStatus=string.format("TELEPORTE FUGA; destino Z+%.0f; Y=%.0f; piso=%s",landing.Z-origin.Z,landing.Y,floor)
    MURIM_TRACE.add("MOVIMENTO","A04Teleporte",MURIM_A04.debugStatus)
    return true
end

function MURIM_A04.tick(root,raid,origin)
    if not root or not root.Parent or not raid or not origin then return true end
    local humanoid=root.Parent:FindFirstChildWhichIsA("Humanoid")
    if humanoid and humanoid.Health<=0 then MURIM_A04.cancelHold(); MURIM_A04.stopRun(); return true end
    local now=os.clock()
    if now-MURIM_A04.lastTick<0.15 then return true end
    MURIM_A04.lastTick=now
    if MURIM_A04.raid~=raid or MURIM_A04.character~=root.Parent then
        MURIM_A04.cancelHold()
        MURIM_A04.reset()
        MURIM_A04.raid=raid; MURIM_A04.character=root.Parent
    end
    MURIM_A04.navOrigin=origin
    -- A latched chase does not rescan thousands of props or stop for streaming.
    if MURIM_A04.running then return MURIM_A04.runExit(root,origin,now) end
    local world=MURIM_A04.readWorld(root,raid,origin)
    if not world.area then MURIM_A04.phase="aguardando streaming A04"; return true end
    local threats=MURIM_A04.threats(raid,origin)
    local risk,dist=MURIM_A04.riskAt(root.Position,root,threats,MURIM_A04.pending~=nil)
    local procession=false
    for _,t in ipairs(threats) do
        if t.procession and (t.part.Position-root.Position).Magnitude<120 then procession=true end
    end
    local precaution=now<(MURIM_A04.processionUntil or 0)
    local danger=risk>0 or procession
    local hidden=MURIM_A04.findComeOut()~=nil
    MURIM_A04.comeOutVisible=hidden
    MURIM_A04.lampCount=world.count
    MURIM_A04.lamps={}
    for _,item in ipairs(world.lamps) do if item.lit then MURIM_A04.lamps[item.key]=true end end
    MURIM_A04.checkLastMove(root)
    MURIM_A04.debugStatus=string.format("santuarios=%d; Lit=%d/3; ameacas=%d; risco=%.2f; oculto=%s; acao=%s",
        #world.lamps,world.count,#threats,risk,tostring(hidden),MURIM_A04.phase)
    if now-MURIM_A04.lastDebugAt>7 then
        MURIM_A04.lastDebugAt=now
        MURIM_TRACE.add("INFO","A04Estado",MURIM_A04.debugStatus)
    end
    if hidden then
        MURIM_A04.cancelHold()
        if danger or dist<85 then
            MURIM_A04.safeSince=nil
            MURIM_A04.phase="no abrigo: aguardando ameacas passarem"
            return true
        end
        MURIM_A04.safeSince=MURIM_A04.safeSince or now
        if now-MURIM_A04.safeSince<2 then return true end
        MURIM_A04.ensureComeOut(root,now)
        return true
    end
    MURIM_A04.safeSince=nil
    MURIM_A04.comeOutAttempts=0
    -- A completed street resumes at its open exit before considering retreat.
    if world.gate and world.gate.open then
        MURIM_A04.cancelHold()
        if root.Position.Z-origin.Z>=world.gate.z-4 or MURIM_A04.houndNear(root,origin) then
            return MURIM_A04.runExit(root,origin,now)
        end
        MURIM_A04.phase="porta Open=true: atravessando saida A04"
        if now-MURIM_A04.lastMove>=0.4 then
            MURIM_A04.lastMove=now
            if not MURIM_A04.move(root,Vector3.new(origin.X,root.Position.Y,origin.Z+970),"saida A04",threats,false) then
                MURIM_A04.phase="saida aberta; "..(MURIM_A04.navFailure or "caminho obstruido/ameacado; recalculando")
            end
        end
        return true
    end
    if risk>0 or procession then
        MURIM_A04.cancelHold()
        MURIM_A04.phase="evitando ameaca; sem Hide automatico"
        if now-MURIM_A04.lastMove>=0.4 then
            MURIM_A04.lastMove=now
            MURIM_A04.avoidThreat(root,world,threats,now)
        end
        return true
    end
    if MURIM_A04.updatePrompt(root,world,now) then return true end
    local chosen,kind=nil,nil
    local function available(item)
        return item.prompt.Enabled and now-(MURIM_A04.lastPromptAttempt[item.prompt] or -100)>4
    end
    if not chosen then
        for _,item in ipairs(world.lamps) do
            if not item.lit and available(item) then chosen=item;kind="Street Shrine";break end
        end
    end
    if chosen then
        MURIM_A04.phase="aproximando: "..kind.." "..chosen.key
        local reach=math.max(1,math.min(5,chosen.prompt.MaxActivationDistance-2))
        if chosen.d<=reach then
            if MURIM_A04.riskAt(root.Position,root,threats,true)==0 then
                MURIM_A04.startPrompt(chosen,kind,now)
            end
        elseif now-MURIM_A04.lastMove>=0.4 then
            MURIM_A04.lastMove=now
            if not MURIM_A04.move(root,chosen.pos,kind,threats,false) then
                MURIM_A04.phase="caminho ao Street Shrine bloqueado; recalculando rota"
                -- Geometry failure is not a threat: never trigger Hide here.
            end
        end
        return true
    end
    for _,item in ipairs(world.lamps) do
        if item.prompt.Enabled and not item.lit then
            MURIM_A04.phase="intervalo entre tentativas do santuario"
            return true
        end
    end
    -- Disabled/streamed-out lamps never create a fabricated 3/3.
    -- Keep surveying the whole street instead of stopping forever at Z+780.
    MURIM_A04.phase="inspecionando santuarios/saida; conclusao nao confirmada"
    if now-MURIM_A04.lastMove>=0.6 then
        MURIM_A04.lastMove=now
        local targets={610,690,770,895}
        local index=MURIM_A04.searchIndex or 1
        local dest=Vector3.new(origin.X,root.Position.Y,origin.Z+targets[index])
        if (Vector3.new(dest.X,0,dest.Z)-Vector3.new(root.Position.X,0,root.Position.Z)).Magnitude<8 then
            MURIM_A04.searchIndex=index%#targets+1
        else
            MURIM_A04.move(root,dest,"varredura A04",threats,false)
        end
    end
    return true
end


-- V18M: A05-A10. O mapa identifica modelos e objetos, NAO confirma as
-- condicoes dos objetivos posteriores. Em vez de ficar inerte, localizar
-- prompts de mecanica VALIDAMENTE habilitados e tentar aciona-los. So
-- atravessar portas explicitamente Open=true; sem saltar para uma proxima
-- sala com base apenas no Z ou em um modelo visual.
MURIM_LATE={phase="aguardando",lastTick=0,lastMove=0,lastNotice=0,
    attempts=setmetatable({},{__mode="k"}), pending=nil, passage=nil,lastIndex=0}
function MURIM_LATE.stopWalk()
    local walking=MURIM_LATE.walking
    MURIM_LATE.walking=nil
    if walking and walking.root.Parent and walking.humanoid.Parent then
        walking.humanoid:Move(Vector3.zero,false)
        walking.humanoid:MoveTo(walking.root.Position)
    end
end


-- Independent of Auto Raid: manual actions are observations, never automation success.
MURIM_LATE.encounter={registry=setmetatable({},{__mode="k"}),ids=setmetatable({},{__mode="k"}),
    nextId=0,seen={},events={},snapshot="A06 ainda nao observada",lastPoll=-1e9}
function MURIM_LATE.trackEncounterObject(obj)
    local name=obj.Name:lower()
    if obj:IsA("Model") or ((obj:IsA("BasePart") or obj:IsA("Attachment"))
        and (name:find("soul",1,true) or name:find("ring",1,true)
            or name:find("parry",1,true) or name:find("telegraph",1,true))) then
        MURIM_LATE.encounter.registry[obj]=true
    end
end
function MURIM_LATE.encounterEvent(message)
    local e=MURIM_LATE.encounter
    local line="["..os.date("%H:%M:%S").."] "..message:gsub("[\r\n]+"," "):sub(1,280)
    table.insert(e.events,line)
    if #e.events>2000 then table.remove(e.events,1) end
    MURIM_TRACE.add("OBSERVADO","ArenaA06",message)
end
function MURIM_TRACE.encounterDump(full)
    local e=MURIM_LATE.encounter
    return "[ARENA A06: observacao local; aparecimento nao prova invocador; ausencia nao prova morte]\n"
        ..e.snapshot.."\n"..MURIM_TRACE.section(e.events,full and math.huge or 1800).."\n\n"
        .. "[SALINHA A05: movimentos observados, autoria nao inferida]\n"
        ..MURIM_TRACE.section(MURIM_LATE.teahouseEvents or {},full and math.huge or 1200).."\n\n"
        .."[TELEPORTES: destinos e falhas]\n"..MURIM_TRACE.section(MURIM_RAID_NAV.events,full and math.huge or 1200).."\n\n"
        .."[CERBERUS: HUD / PARRY]\n"..tostring(MURIM_LATE.lastSoulHUD or "Aviso Three Souls ainda nao observado")
        .."\n"..MURIM_TRACE.section(MURIM_LATE.soulEvents or {},full and math.huge or 2400).."\n\n"
end
function MURIM_LATE.observeEncounter(root,origin,automatic)
    local e=MURIM_LATE.encounter
    if os.clock()-e.lastPoll<0.5 then return end
    e.lastPoll=os.clock()
    if not root or math.abs(root.Position.X-origin.X)>145
        or root.Position.Z-origin.Z<1090 or root.Position.Z-origin.Z>1245 then
        if e.active then
            MURIM_LATE.encounterEvent("Observador saiu da A06; resumo abaixo e historico.")
            e.snapshot="HISTORICO: "..e.snapshot
            e.active=false;e.seen={}
        end
        return
    end
    if not e.active or e.originZ~=origin.Z then
        e.seen={};e.originZ=origin.Z;e.peakSouls=0;e.distinctSouls=0;e.soulIds={}
    end
    e.active=true
    local seen,rows,souls,npcs={}, {},0,0
    for obj in pairs(e.registry) do
        if not obj.Parent or not obj:IsDescendantOf(workspace) then e.registry[obj]=nil;continue end
        if obj==root.Parent or obj:IsDescendantOf(root.Parent) then continue end
        local soul=obj.Name:lower():find("soul",1,true)~=nil
        local hum=obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid")
        if not soul and not hum then continue end
        -- A Soul model and its Soul-named parts are one observed object.
        local ancestor=obj.Parent
        local duplicate=false
        while ancestor and ancestor~=workspace do
            if ancestor.Name:lower():find("soul",1,true) and e.registry[ancestor] then
                duplicate=true;break
            end
            ancestor=ancestor.Parent
        end
        if duplicate then continue end
        local part=obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart",true)
        local pos=obj:IsA("Attachment") and obj.WorldPosition or (part and part.Position)
        if not pos or math.abs(pos.X-origin.X)>145 or math.abs(pos.Y-origin.Y)>130
            or pos.Z-origin.Z<1090 or pos.Z-origin.Z>1245 then continue end
        if not e.ids[obj] then e.nextId+=1;e.ids[obj]=e.nextId end
        local id=e.ids[obj]
        if soul and not e.soulIds[id] then e.soulIds[id]=true;e.distinctSouls+=1 end
        local health=hum and string.format("%.0f/%.0f",hum.Health,hum.MaxHealth) or "sem Humanoid"
        local alive=not hum or hum.Health>0
        if soul and alive then souls+=1 end
        if hum and hum.Health>0 then npcs+=1 end
        local row=string.format("#%d %s [%s] HP=%s dist=%.0f pos=(%.0f,%.0f,%.0f)",
            id,obj.Name:sub(1,55),obj.ClassName,health,(pos-root.Position).Magnitude,pos.X,pos.Y,pos.Z)
        seen[obj]={id=id,alive=alive,name=obj.Name}
        rows[#rows+1]=row
        local previous=e.seen[obj]
        if not previous then
            MURIM_LATE.encounterEvent("Presenca nova: "..row)
        elseif previous.alive and not alive then
            MURIM_LATE.encounterEvent("HP zero observado: #"..id.." "..obj.Name)
        end
    end
    for obj,previous in pairs(e.seen) do
        if not seen[obj] then
            MURIM_LATE.encounterEvent("Nao observado nesta amostra: #"..previous.id.." "..previous.name.."; streaming/remocao/fora de alcance, morte nao confirmada")
        end
    end
    e.seen=seen
    table.sort(rows)
    local hum=root.Parent:FindFirstChildOfClass("Humanoid")
    local hp=hum and hum.Health or 0
    if e.lastRoot==root and e.lastHP and hp<e.lastHP then
        if e.lastHP-hp>= (hum and hum.MaxHealth or 1)*0.10 then
            MURIM_LATE.encounterEvent(string.format("Dano ao jogador %.0f->%.0f; objetos nome Soul=%d; origem do dano desconhecida",e.lastHP,hp,souls))
        end
    end
    e.lastRoot=root;e.lastHP=hp
    e.peakSouls=math.max(e.peakSouls or 0,souls)
    e.snapshot=string.format("%s Auto=%s jogadorHP=%.0f NPCs vivos=%d objetos nome Soul=%d maximo simultaneo=%d distintos=%d (nao comprova inimigos); %d listados\n",
        os.date("%H:%M:%S"),tostring(automatic),hp,npcs,souls,e.peakSouls,e.distinctSouls,math.min(#rows,12))
        ..table.concat(rows,"\n",1,math.min(#rows,12))
end


function MURIM_LATE.observeTeahouse(root,raid,origin,automatic)
    if not root or not raid or math.abs(root.Position.X-origin.X)>145
        or root.Position.Z-origin.Z<960 or root.Position.Z-origin.Z>=1097 then return end
    local rows={}
    for _,obj in ipairs(raid:GetDescendants()) do
        if obj:IsA("Model") and obj.Name=="HallowDoor" then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            if part and part.Position.Z-origin.Z>=960 and part.Position.Z-origin.Z<=1112 then
                rows[#rows+1]=string.format("porta Z+%.0f Open=%s",part.Position.Z-origin.Z,tostring(obj:GetAttribute("Open")))
            end
        elseif obj:IsA("ProximityPrompt") then
            local pos=MURIM_A04.promptPosition(obj)
            if pos and pos.Z-origin.Z>=960 and pos.Z-origin.Z<1097 then
                rows[#rows+1]=(obj.ActionText or obj.Name).."="..tostring(obj.Enabled)
            end
        end
    end
    table.sort(rows)
    local state=table.concat(rows,"; ")
    local old=MURIM_LATE.teahousePosition
    if state~=MURIM_LATE.teahouseState or not old or (root.Position-old).Magnitude>=5 then
        MURIM_LATE.teahouseState=state;MURIM_LATE.teahousePosition=root.Position
        local line=string.format("[%s] Auto=%s pos=(%.0f,%.0f,%.0f) %s",os.date("%H:%M:%S"),tostring(automatic),
            root.Position.X,root.Position.Y,root.Position.Z,state):sub(1,360)
        local events=MURIM_LATE.teahouseEvents or {};MURIM_LATE.teahouseEvents=events
        table.insert(events,line);if #events>2000 then table.remove(events,1) end
    end
end

MURIM_LATE.soulState={samples=setmetatable({},{__mode="k"}),effects=setmetatable({},{__mode="k"}),hud={},lastHudAt=-1e9,lastTick=-1e9}
-- V19E: linha do tempo SOMENTE de log. Nada aqui envia input, move o personagem ou decide ataque/parry.
MURIM_LATE.timeline={lines={},lastTick=-1e9,lastAttr=-1e9}
MURIM_LATE.timelineKeys={"Stance","ParryReadyAt","Knocked","Ragdoll","Busy"}
MURIM_LATE.timelineClasses={"BasePart","Attachment","Beam","ParticleEmitter","Decal","SurfaceGui","BillboardGui","Highlight"}
function MURIM_LATE.serverTime()
    local ok,t=pcall(function() return workspace:GetServerTimeNow() end)
    return ok and type(t)=="number" and t or nil
end
function MURIM_LATE.stamp()
    local t=MURIM_LATE.serverTime()
    if not t then return os.date("%H:%M:%S") end
    return os.date("%H:%M:%S",math.floor(t))..string.format(".%03d",math.floor((t%1)*1000))
end
function MURIM_LATE.mark(message,secondary)
    local lines=MURIM_LATE.timeline.lines
    lines[#lines+1]={text="["..MURIM_LATE.stamp().."] "..tostring(message):gsub("[\r\n]+"," "),secondary=secondary or false}
    if #lines>20000 then table.remove(lines,1) end
end
function MURIM_LATE.attrText(value)
    return type(value)=="number" and string.format("%.3f",value) or tostring(value)
end
-- Salvar TXT recebe tudo, sem corte. So o Copiar log tem limite: prioriza golpes, dano e parry; linhas "txt" ficam so no arquivo.
function MURIM_TRACE.timelineDump(budget)
    local lines=MURIM_LATE.timeline.lines
    if #lines==0 then return "" end
    local title="[CERBERUS: LINHA DO TEMPO em ms no relogio do servidor; candidato de golpe nao prova origem do dano]\n"
    local out={}
    if not budget then
        for i,row in ipairs(lines) do out[i]=row.text end
        return title..table.concat(out,"\n").."\n\n"
    end
    local keep,used={},#title+2
    local function take(secondary,limit)
        for i=#lines,1,-1 do
            local row=lines[i]
            if row.secondary==secondary and not keep[i] then
                local size=math.min(#row.text,360)+1
                if used+size>limit then break end
                keep[i]=true;used+=size
            end
        end
    end
    take(false,math.floor(budget*0.65))
    take(true,budget)
    take(false,budget)
    for i,row in ipairs(lines) do
        if keep[i] then out[#out+1]=row.text:sub(1,360) end
    end
    return title..table.concat(out,"\n").."\n\n"
end
function MURIM_LATE.timelineBegin(tl,root,char,hum)
    tl.root=root;tl.refHP=hum and hum.Health or 0
    tl.attacks=setmetatable({},{__mode="k"});tl.attrs=setmetatable({},{__mode="k"})
    tl.attrCount={};tl.objects={}
    tl.endings={};tl.recentAttacks={};tl.player={};tl.souls=0;tl.nearestSoul=nil;tl.lastObject=nil
    for _,key in ipairs(MURIM_LATE.timelineKeys) do tl.player[key]=char:GetAttribute(key) end
    MURIM_LATE.mark(string.format("INICIO observacao A06: HP=%.0f Stance=%s",tl.refHP,tostring(tl.player.Stance)))
end
function MURIM_LATE.timelineDamage(tl,char)
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hum or not tl.refHP then return end
    local hp=hum.Health
    if hp>=tl.refHP then tl.refHP=hp;return end
    local lost=tl.refHP-hp
    -- Dano pequeno acumula ate 2% do HP, para veneno e sangramento aparecerem sem encher o log.
    if hp>0 and lost<math.max(1,hum.MaxHealth*0.02) then return end
    local serverNow=MURIM_LATE.serverTime()
    local candidate,gap=nil,0.6
    if serverNow then
        for _,attack in ipairs(tl.recentAttacks) do
            local distance=math.abs(serverNow-attack.impact)
            if distance<=gap then candidate,gap=attack,distance end
        end
    end
    local object=tl.lastObject and string.format("%s ha %.2fs",tl.lastObject.name,os.clock()-tl.lastObject.at) or "nenhum"
    MURIM_LATE.mark(string.format("DANO %.0f->%.0f (-%.0f) Stance=%s souls=%d soulMaisProxima=%s candidato=%s ultimoObjeto=%s",
        tl.refHP,hp,lost,tostring(char:GetAttribute("Stance")),tl.souls or 0,
        tl.nearestSoul and string.format("%.1f",tl.nearestSoul) or "nenhuma",
        candidate and string.format("%s Act=%s impacto %+.2fs",candidate.name,candidate.act,serverNow-candidate.impact) or "sem ataque com impacto a menos de 0.6s",
        object))
    tl.refHP=hp
end
function MURIM_LATE.timelineEnd(tl)
    local char=tl.root.Parent
    -- soulTick limpa o estado assim que o HP zera; o golpe final precisa ser lido aqui.
    MURIM_LATE.timelineDamage(tl,char)
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    MURIM_LATE.mark(string.format("FIM observacao A06: HP=%.0f",hum and hum.Health or 0))
    for _,connection in ipairs(tl.endings) do connection:Disconnect() end
    tl.endings={};tl.root=nil;tl.refHP=nil
end
function MURIM_LATE.timelineAttrs(tl,obj,label)
    local current=obj:GetAttributes()
    local previous=tl.attrs[obj]
    tl.attrs[obj]=current
    if not previous then
        local parts={}
        for key,value in pairs(current) do parts[#parts+1]=key.."="..MURIM_LATE.attrText(value) end
        table.sort(parts)
        MURIM_LATE.mark(label.." atributos: "..table.concat(parts," "),true)
        return
    end
    for key,value in pairs(current) do
        if previous[key]~=value and key~="Act" and key~="ActT" and key~="ActW" then
            local countKey=label.."|"..key
            tl.attrCount[countKey]=(tl.attrCount[countKey] or 0)+1
            -- Atributo que muda sem parar (medidor) fica completo no TXT e nao ocupa o Copiar log.
            MURIM_LATE.mark(label.." "..key..": "..MURIM_LATE.attrText(previous[key]).." -> "..MURIM_LATE.attrText(value),tl.attrCount[countKey]<=6 and true or "txt")
        end
    end
end
function MURIM_LATE.timelineTick(char)
    local tl=MURIM_LATE.timeline
    local now=os.clock()
    if now-tl.lastTick<0.03 then return end
    tl.lastTick=now
    local state=MURIM_LATE.soulState
    local root=state.root
    if not root or not char or root.Parent~=char then
        if tl.root then MURIM_LATE.timelineEnd(tl) end
        return
    end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if tl.root~=root then
        if tl.root then MURIM_LATE.timelineEnd(tl) end
        MURIM_LATE.timelineBegin(tl,root,char,hum)
    end
    local count,nearest=0,nil
    for obj in pairs(state.samples) do
        if obj.Parent then
            count+=1
            local distance=(obj.Position-root.Position).Magnitude
            if not nearest or distance<nearest then nearest=distance end
        end
    end
    tl.souls=count;tl.nearestSoul=nearest
    local seen=MURIM_LATE.encounter.seen
    local serverNow=MURIM_LATE.serverTime()
    for obj,info in pairs(seen) do
        if obj.Parent and obj:IsA("Model") then
            local act=obj:GetAttribute("Act")
            local actT=obj:GetAttribute("ActT")
            local key=tostring(act).."|"..tostring(actT)
            if act~=nil and type(actT)=="number" and tl.attacks[obj]~=key then
                tl.attacks[obj]=key
                local actW=obj:GetAttribute("ActW")
                local impact=type(actW)=="number" and actT+actW or nil
                local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
                MURIM_LATE.mark(string.format("ATAQUE #%d %s Act=%s W=%s impacto em %s dist=%s",info.id,info.name,tostring(act),
                    MURIM_LATE.attrText(actW),
                    impact and serverNow and string.format("%.3fs",impact-serverNow) or "?",
                    part and string.format("%.1f",(part.Position-root.Position).Magnitude) or "?"))
                if impact then
                    table.insert(tl.recentAttacks,{name=info.name,act=tostring(act),impact=impact})
                    if #tl.recentAttacks>12 then table.remove(tl.recentAttacks,1) end
                end
            end
        end
    end
    if now-tl.lastAttr>=0.2 then
        tl.lastAttr=now
        for obj,info in pairs(seen) do
            if obj.Parent then MURIM_LATE.timelineAttrs(tl,obj,"#"..tostring(info.id).." "..info.name) end
        end
    end
    for _,key in ipairs(MURIM_LATE.timelineKeys) do
        local value=char:GetAttribute(key)
        if tl.player[key]~=value then
            MURIM_LATE.mark("PERSONAGEM "..key..": "..MURIM_LATE.attrText(tl.player[key]).." -> "..MURIM_LATE.attrText(value))
            tl.player[key]=value
        end
    end
    MURIM_LATE.timelineDamage(tl,char)
end
function MURIM_LATE.timelineObject(obj,char)
    local tl=MURIM_LATE.timeline
    local root=MURIM_LATE.soulState.root
    if not root or tl.root~=root or not obj.Parent then return end
    local accepted=false
    for _,class in ipairs(MURIM_LATE.timelineClasses) do
        if obj:IsA(class) then accepted=true;break end
    end
    if not accepted then return end
    local parent=obj.Parent
    local pos
    if obj:IsA("BasePart") then pos=obj.Position
    elseif obj:IsA("Attachment") then pos=obj.WorldPosition
    elseif obj:IsA("Beam") and obj.Attachment0 then pos=obj.Attachment0.WorldPosition
    elseif parent:IsA("BasePart") then pos=parent.Position
    elseif parent:IsA("Attachment") then pos=parent.WorldPosition
    elseif (obj:IsA("SurfaceGui") or obj:IsA("BillboardGui")) and obj.Adornee and obj.Adornee:IsA("BasePart") then pos=obj.Adornee.Position
    end
    local distance=pos and (pos-root.Position).Magnitude
    if distance and distance>150 then return end
    local path=obj:GetFullName()
    -- Cenario carregado por streaming nao e efeito de combate.
    if path:find(".Dress.",1,true) or path:find(".Static.",1,true) then return end
    local key=obj.ClassName.."|"..obj.Name
    local now=os.clock()
    local record=tl.objects[key]
    local repeated=record~=nil and now-record.at<1
    local repeats=0
    if repeated then
        record.suppressed+=1
    else
        repeats=record and record.suppressed or 0
        tl.objects[key]={at=now,suppressed=0}
    end
    tl.lastObject={name=obj.Name,at=now}
    local detail,big="",false
    if obj:IsA("BasePart") then
        local size,color=obj.Size,obj.Color
        big=not obj.CanCollide and math.max(size.X,size.Y,size.Z)>=12
        detail=string.format(" tam=(%.1f,%.1f,%.1f) transp=%.2f cor=(%d,%d,%d) colide=%s",size.X,size.Y,size.Z,obj.Transparency,
            math.floor(color.R*255+0.5),math.floor(color.G*255+0.5),math.floor(color.B*255+0.5),tostring(obj.CanCollide))
    end
    local attributes={}
    for name,value in pairs(obj:GetAttributes()) do attributes[#attributes+1]=name.."="..MURIM_LATE.attrText(value) end
    table.sort(attributes)
    MURIM_LATE.mark(string.format("OBJETO %s %s dist=%s%s%s%s caminho=%s%s",obj.ClassName,obj.Name,
        distance and string.format("%.1f",distance) or "?",detail,
        #attributes>0 and " attrs="..table.concat(attributes,",") or "",
        repeats>0 and string.format(" (+%d iguais so no TXT)",repeats) or "",
        char and obj:IsDescendantOf(char) and "[meu personagem] " or "",path),repeated and "txt" or not big)
    -- Quanto tempo o objeto dura mostra a janela real do efeito (ex.: anel que fecha).
    local connection
    connection=obj.AncestryChanged:Connect(function(_,newParent)
        if newParent~=nil or not connection then return end
        connection:Disconnect();connection=nil
        pcall(function()
            local final=""
            if obj:IsA("BasePart") then final=string.format(" tamFinal=(%.1f,%.1f,%.1f)",obj.Size.X,obj.Size.Y,obj.Size.Z) end
            MURIM_LATE.mark(string.format("OBJETO sumiu %s viveu %.3fs%s",obj.Name,os.clock()-now,final),repeated and "txt" or true)
        end)
    end)
    tl.endings[#tl.endings+1]=connection
end
function MURIM_LATE.soulNote(message)
    local events=MURIM_LATE.soulEvents or {};MURIM_LATE.soulEvents=events
    table.insert(events,"["..MURIM_LATE.stamp().."] "..message:sub(1,300))
    if #events>2000 then table.remove(events,1) end
    pcall(MURIM_LATE.mark,message)
    MURIM_TRACE.add("CERBERUS","Parry",message)
end
function MURIM_LATE.soulBlocking(root)
    return MURIM_LATE.soulState.root==root and os.clock()<(MURIM_LATE.soulUntil or 0)
end
function MURIM_LATE.soulImpact(relative,velocity)
    local speed2=velocity:Dot(velocity)
    if relative.Magnitude<=6 then return true,0,"proximidade <=6" end
    if speed2<1 then return false,nil,"sem aproximacao mensuravel" end
    local eta=-relative:Dot(velocity)/speed2
    local miss=(relative+velocity*math.max(0,eta)).Magnitude
    return eta>=0 and eta<=0.12 and miss<=6,eta,"trajetoria estimada"
end
function MURIM_LATE.soulTick(root,origin,automatic,gui,ownGui,sendParry)
    local state=MURIM_LATE.soulState
    local now=os.clock()
    if now-state.lastTick<0.03 then return end
    state.lastTick=now
    local hum=root and root.Parent and root.Parent:FindFirstChildOfClass("Humanoid")
    local inside=root and math.abs(root.Position.X-origin.X)<145
        and root.Position.Z-origin.Z>=1097 and root.Position.Z-origin.Z<1236
    if not inside or not hum or hum.Health<=0 then
        if state.root then MURIM_LATE.soulNote("Observacao/parry encerrados: morte ou saida da A06.") end
        state.root=nil;state.samples=setmetatable({},{__mode="k"});state.hud={}
        MURIM_LATE.soulUntil=nil
        return
    end
    if state.root~=root then
        state.root=root;state.samples=setmetatable({},{__mode="k"});state.hud={}
        MURIM_LATE.soulUntil=nil
    end
    if gui and now-state.lastHudAt>=0.2 then
        state.lastHudAt=now
        local visible={}
        for _,obj in ipairs(gui:GetDescendants()) do
            if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and not obj:IsDescendantOf(ownGui)
                and isHallowGuiVisible(obj) then
                local txt=(obj.Text or ""):gsub("<[^>]+>",""):gsub("%s+"," ")
                local lower=txt:lower()
                if #txt<300 and (lower:find("three souls",1,true) or lower:find("parry",1,true)
                    or lower:find("hooves on stone",1,true) or lower:find("lamp is out",1,true)) then
                    local key=obj:GetFullName().."|"..txt;visible[key]=true
                    if not state.hud[key] then
                        MURIM_LATE.soulNote("HUD: "..txt.." | "..obj:GetFullName())
                        if lower:find("three souls",1,true) or lower:find("parry them",1,true) then
                            MURIM_LATE.lastSoulHUD="["..os.date("%H:%M:%S").."] "..txt
                            MURIM_LATE.soulUntil=now+8
                        end
                    end
                end
            end
        end
        state.hud=visible
    end
    local present={}
    for obj in pairs(MURIM_LATE.encounter.registry) do
        if obj.Name~="HBSoul" and obj:IsA("BasePart") and obj:IsDescendantOf(workspace)
            and (obj.Position-root.Position).Magnitude<100 and not state.effects[obj] then
            local name=obj.Name:lower()
            if name:find("ring",1,true) or name:find("parry",1,true) or name:find("telegraph",1,true) then
                state.effects[obj]=true
                MURIM_LATE.soulNote("Indicador proximo: "..obj:GetFullName().." Act="..tostring(obj:GetAttribute("Act"))
                    .." ActT="..tostring(obj:GetAttribute("ActT")).." ActW="..tostring(obj:GetAttribute("ActW")))
            end
        end
        if obj.Name~="HBSoul" or not obj:IsA("BasePart") or not obj:IsDescendantOf(workspace)
            or (obj.Position-root.Position).Magnitude>180 then continue end
        present[obj]=true
        MURIM_LATE.soulUntil=now+2
        local previous=state.samples[obj]
        local velocity=obj.AssemblyLinearVelocity
        if previous and now>previous.at then velocity=(obj.Position-previous.pos)/(now-previous.at) end
        local relative=obj.Position-root.Position
        local due,eta,basis=MURIM_LATE.soulImpact(relative,velocity-root.AssemblyLinearVelocity)
        local at=tonumber(obj:GetAttribute("ActT"))
        local windup=tonumber(obj:GetAttribute("ActW"))
        if at and windup and windup>0 then
            eta=at+windup-workspace:GetServerTimeNow()
            due=eta>=0 and eta<=0.12;basis="ActT+ActW replicado"
        end
        local sample=previous or {}
        if not previous then
            local attrs={}
            for _,name in ipairs({"Act","ActT","ActW","Parryable","Parried","Owner","Target"}) do
                local value=obj:GetAttribute(name)
                if value~=nil then attrs[#attrs+1]=name.."="..tostring(value) end
            end
            MURIM_LATE.soulNote(string.format("Soul %s dist=%.1f tamanho=(%.1f,%.1f,%.1f) %s",obj:GetFullName(),
                relative.Magnitude,obj.Size.X,obj.Size.Y,obj.Size.Z,table.concat(attrs," ")))
        end
        if due and not sample.sent and automatic and sendParry then
            local context={soul=obj,root=root,hp=hum.Health,distance=relative.Magnitude,eta=eta,basis=basis}
            local ok,reason=sendParry(context)
            if ok then
                sample.sent=true
                MURIM_LATE.soulNote(string.format("ParryDown enviado: dist=%.1f ETA=%.3f base=%s; NAO confirma defesa",relative.Magnitude,eta or -1,basis))
            elseif now-(sample.lastBlock or -1e9)>=0.5 then
                sample.lastBlock=now
                MURIM_LATE.soulNote("Parry bloqueado: "..tostring(reason).."; nova tentativa enquanto a janela estiver aberta")
            end
        end
        if previous and not sample.sent and (sample.minimum or math.huge)<8 and relative.Magnitude>(sample.minimum or math.huge)+6
            and not sample.missed then
            sample.missed=true
            MURIM_LATE.soulNote("Soul passou perto sem ParryDown; Auto="..tostring(automatic).."; timing ainda nao validado")
        end
        sample.minimum=math.min(sample.minimum or math.huge,relative.Magnitude)
        sample.pos=obj.Position;sample.at=now;state.samples[obj]=sample
    end
    for obj,sample in pairs(state.samples) do
        if not present[obj] then
            MURIM_LATE.soulNote("Soul deixou de ser observada; ParryDown enviado="..tostring(sample.sent==true).."; resultado nao comprovado")
            state.samples[obj]=nil
        end
    end
end

function MURIM_LATE.liveCerberus(root,raid,origin)
    local function alive(npc)
        if not npc or not npc.Parent or not npc:IsA("Model")
            or not npc.Name:lower():find("cerberus",1,true) then return false end
        local hum=npc:FindFirstChildOfClass("Humanoid")
        local part=npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
        return hum and hum.Health>0 and part
            and isHallowEnemyInArea(part.Position,origin,6)
            and math.abs(part.Position.X-origin.X)<145
    end
    if alive(MURIM_LATE.cerberusFocus) then return MURIM_LATE.cerberusFocus end
    MURIM_LATE.cerberusFocus=nil
    local npcs=workspace:FindFirstChild("Murim_NPCs")
    local folders={raid}
    if npcs then table.insert(folders,1,npcs) end
    for _,folder in ipairs(folders) do
        if folder then
            for _,npc in ipairs(folder:GetDescendants()) do
                if alive(npc) then
                    MURIM_LATE.cerberusFocus=npc
                    return npc
                end
            end
        end
    end
    return nil
end

function MURIM_LATE.teleportA05(root,dest)
    local humanoid=root.Parent and root.Parent:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health<=0 or root.Anchored then return false end
    -- Cancel any prior physical walking before using the verified CFrame mover.
    MURIM_LATE.stopWalk()
    humanoid:Move(Vector3.zero,false)
    MURIM_A04.navOrigin=MURIM_LATE.origin
    local moved=MURIM_A04.move(root,dest,"A05 teleporte",{},false)
    if not moved then
        MURIM_LATE.phase="A05: teleporte aguardando piso/passagem livre"
    end
    return moved
end

function MURIM_LATE.objects(area,raid,origin,index)
    local objects=area:GetDescendants()
    if index~=5 then return objects end
    local seen={}
    for _,obj in ipairs(objects) do seen[obj]=true end
    local function add(obj)
        if not seen[obj] then seen[obj]=true;table.insert(objects,obj) end
    end
    -- Boundary doors can be parented to the following room or raid root.
    for _,obj in ipairs(raid:GetDescendants()) do
        if obj:IsA("Model") and obj.Name=="HallowDoor" then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            if part then
                local z=part.Position.Z-origin.Z
                if z>=960 and z<=1112 and math.abs(part.Position.X-origin.X)<100
                    and math.abs(part.Position.Y-(origin.Y-20))<50 then add(obj) end
            end
        end
    end
    -- The log places The Proprietress in Murim_NPCs, not in A05_Teahouse.
    local npcs=workspace:FindFirstChild("Murim_NPCs")
    if npcs then
        for _,npc in ipairs(npcs:GetChildren()) do
            if npc:IsA("Model") and npc.Name:lower()=="the proprietress" then
                for _,obj in ipairs(npc:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local pos=MURIM_A04.promptPosition(obj)
                        if pos and pos.Z-origin.Z>=960 and pos.Z-origin.Z<1097
                            and math.abs(pos.X-origin.X)<100 then add(obj) end
                    end
                end
            end
        end
    end
    return objects
end

function MURIM_LATE.reset()
    MURIM_LATE.stopWalk()
    MURIM_LATE.cerberusFocus=nil
    MURIM_LATE.soulUntil=nil;MURIM_LATE.lastSoulMove=nil
    MURIM_LATE.phase="aguardando objetivo replicado"
    MURIM_LATE.lastTick=0;MURIM_LATE.lastMove=0;MURIM_LATE.lastNotice=0
    MURIM_LATE.attempts=setmetatable({},{__mode="k"});MURIM_LATE.pending=nil
    MURIM_LATE.passage=nil;MURIM_LATE.lastIndex=0
end
function MURIM_LATE.tick(root,raid,origin,index)
    if not root or not raid or not origin or index<5 or index>10 then return true end
    if index==6 and MURIM_LATE.liveCerberus(root,raid,origin) then
        MURIM_LATE.phase="Cerberus vivo: navegacao e oferendas suspensas"
        return true
    end
    MURIM_LATE.origin=origin
    local now=os.clock()
    if now-MURIM_LATE.lastTick<(index==5 and 0.25 or 1.1) then return true end
    MURIM_LATE.lastTick=now
    if MURIM_LATE.lastIndex~=index then
        MURIM_LATE.stopWalk()
        MURIM_LATE.lastIndex=index
        MURIM_LATE.pending=nil
        MURIM_LATE.passage=nil
    end
    local def=HALLOW_ROOM_DATA[index]
    local area=def and raid:FindFirstChild(def.name,true)
    if not area then
        MURIM_LATE.phase="area seguinte aguardando streaming"
        MURIM_TRACE.add("AVISO","AutoFases","A"..index.." nao carregada; sem teleporte especulativo.",15)
        return true
    end
    local objects=MURIM_LATE.objects(area,raid,origin,index)
    if index==5 then
        -- A real open exit overrides optional conversation and stale prompt waits.
        for _,obj in ipairs(objects) do
            if obj:IsA("Model") and obj.Name=="HallowDoor" and obj:GetAttribute("Open")==true then
                local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
                local z=part and part.Position.Z-origin.Z
                if z and z>=HALLOW_AREA_Z[6]-50 and z<=HALLOW_AREA_Z[6]+15 then
                    MURIM_LATE.pending=nil
                    MURIM_LATE.phase="A05: saida aberta; teleporte para A06"
                    if now-MURIM_LATE.lastMove>=0.3 then
                        MURIM_LATE.lastMove=now
                        MURIM_LATE.teleportA05(root,Vector3.new(origin.X,root.Position.Y,origin.Z+1102))
                    end
                    return true
                end
            end
        end
    end
    if MURIM_LATE.pending then
        local p=MURIM_LATE.pending
        if not p.prompt.Parent or not p.prompt.Enabled then
            MURIM_TRACE.add("EVIDENCIA","AutoFases","A"..index.." prompt "..p.action.." mudou de estado depois do uso; objetivo ainda depende da HUD.",4)
            MURIM_LATE.pending=nil
        elseif now-p.at>5.5 then
            MURIM_TRACE.add("AVISO","AutoFases","A"..index.." prompt "..p.action.." nao confirmou interacao; sem declarar sucesso.",6)
            MURIM_LATE.pending=nil
        else return true end
    end
    local rel=root.Position.Z-origin.Z
    if MURIM_LATE.passage and MURIM_LATE.passage.index~=index then
        MURIM_LATE.passage=nil
    end
    local candidates={}
    local barrierZ=nil
    -- Nao caminhar ate um prompt que esteja do outro lado de uma porta
    -- ainda fechada: o alcance do prompt nao comprova acesso fisico.
    for _,obj in ipairs(objects) do
        if obj:IsA("Model") and obj.Name=="HallowDoor" and obj:GetAttribute("Open")~=true then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            local z=part and part.Position.Z-origin.Z
            if z and z>rel+2 and (not barrierZ or z<barrierZ) then barrierZ=z end
        end
    end
    for _,obj in ipairs(objects) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local action=(obj.ActionText or ""):lower()
            local anchor=obj:FindFirstAncestorWhichIsA("BasePart")
            if anchor and math.abs(anchor.Position.X-origin.X)<125
                and anchor.Position.Z-origin.Z>=HALLOW_AREA_Z[index]-12
                and anchor.Position.Z-origin.Z<=HALLOW_AREA_Z[index+1]+12
                and (not barrierZ or anchor.Position.Z-origin.Z<=barrierZ-4)
                and not action:find("hide",1,true)
                and not action:find("refill",1,true) then
                candidates[#candidates+1]={prompt=obj,part=anchor,
                    action=obj.ActionText or "interagir",
                    dist=(anchor.Position-root.Position).Magnitude}
            end
        end
    end
    table.sort(candidates,function(a,b) return a.dist<b.dist end)
    -- Nao tentar prompts de uma sala adiante sem entrar nela.
    for _,c in ipairs(candidates) do
        local record=MURIM_LATE.attempts[c.prompt]
        local speech=index==5 and (c.action:lower()=="speak" or c.action:lower()=="talk")
        local allowed=not speech or (not record and c.part.Position.Z>=root.Position.Z-8)
        if allowed and (not record or record.count<2 or now-record.at>20) then
            MURIM_LATE.phase="A"..index.." interagir: "..c.action
            local reach=math.max(2,(c.prompt.MaxActivationDistance or 7)-1.5)
            if c.dist>reach then
                if now-MURIM_LATE.lastMove>(index==5 and 0.4 or 2) then
                    MURIM_LATE.lastMove=now
                    if index==5 then MURIM_LATE.teleportA05(root,c.part.Position)
                    else MURIM_A04.advance(root,c.part.Position,"A"..index.." prompt: "..c.action) end
                end
            else
                if index==5 then MURIM_LATE.stopWalk() end
                local ok,via=tryHallowGuestPrompt(c.prompt)
                MURIM_LATE.attempts[c.prompt]={count=record and (record.count<2 and record.count+1 or 1) or 1,at=now}
                MURIM_LATE.pending={prompt=c.prompt,action=c.action,at=now}
                MURIM_TRACE.add(ok and "ACAO" or "AVISO","AutoFases",
                    "A"..index.." tentando "..c.action.." via "..tostring(via).."; aguardando estado real.")
            end
            return true
        end
    end
    -- Porta liberada ja atravessada pode fechar atras de nos: continuar ate
    -- ultrapassar a fronteira da proxima sala, sem voltar ao inicio.
    if MURIM_LATE.passage then
        local p=MURIM_LATE.passage
        if rel>=p.goal-3 then
            MURIM_LATE.passage=nil
        elseif rel>=p.z+5 or (p.door and p.door.Parent and p.door:GetAttribute("Open")==true) then
            MURIM_LATE.phase="A"..index.." finalizando travessia da porta aberta"
            if now-MURIM_LATE.lastMove>(index==5 and 0.4 or 2) then
                MURIM_LATE.lastMove=now
                local target=Vector3.new(origin.X,root.Position.Y,origin.Z+p.goal)
                if index==5 then MURIM_LATE.teleportA05(root,target)
                else MURIM_A04.advance(root,target,"A"..index.." travessia confirmada") end
            end
            return true
        else
            MURIM_LATE.passage=nil
        end
    end
    -- Progredir SO se uma porta do modelo da sala estiver comprovadamente
    -- aberta. Antes dela, aproximar ao marcador sem atravessar porta fechada.
    local nextDoor=nil
    local nextDoorZ=math.huge
    for _,obj in ipairs(objects) do
        if obj:IsA("Model") and obj.Name=="HallowDoor" then
            local part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)
            local z=part and part.Position.Z-origin.Z
            if z and z>rel-8 and z<HALLOW_AREA_Z[index+1]+15 and z<nextDoorZ then
                nextDoor,nextDoorZ=obj,z
            end
        end
    end
    if nextDoor then
        local isOpen=nextDoor:GetAttribute("Open")==true
        local border=HALLOW_AREA_Z[index+1]
        local nearExit=(border-nextDoorZ)<=50
        local goal=isOpen and (nearExit and border+5 or nextDoorZ+12) or nextDoorZ-8
        if isOpen then
            MURIM_LATE.passage={index=index,door=nextDoor,z=nextDoorZ,goal=goal}
        end
        MURIM_LATE.phase=isOpen and "passando porta aberta A"..index
            or "aguardando porta da A"..index.." abrir"
        if rel<goal-3 and now-MURIM_LATE.lastMove>(index==5 and 0.4 or 2) then
            MURIM_LATE.lastMove=now
            local target=Vector3.new(origin.X,root.Position.Y,origin.Z+goal)
            if index==5 then MURIM_LATE.teleportA05(root,target)
            else MURIM_A04.advance(root,target,"A"..index.." porta observada") end
        end
        MURIM_TRACE.add("INFO","AutoFases",string.format(
            "A%d: porta Z+%.0f Open=%s; atual Z+%.0f; objetivo nao comprovado. %s",
            index,nextDoorZ,tostring(isOpen),rel,MURIM_LATE.phase),12)
        return true
    end
    if index==5 then
        -- Continue toward the observed boundary through collision-checked teleports.
        MURIM_LATE.phase="A05: teleporte pelo corredor para a porta do Cerberus"
        MURIM_LATE.teleportA05(root,Vector3.new(origin.X,root.Position.Y,origin.Z+1102))
        return true
    end
    MURIM_LATE.phase="A"..index.." sem prompt/porta liberada; aguardando estado real"
    MURIM_TRACE.add("INFO","AutoFases",string.format(
        "A%d: modelo presente, %d prompts de mecanica habilitados, nenhuma porta Open=true conhecida. Nao inventar objetivo nem saltar salas.",
        index,#candidates),20)
    return true
end

local function buildMaster()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local VirtualInputManager
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)


local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


-- Remote para enviar comandos de ataque
local function findCombatRemote()
    local murim = ReplicatedStorage:FindFirstChild("Murim")
    local remotes = murim and murim:FindFirstChild("Remotes")
    return remotes and remotes:FindFirstChild("CombatInput")
end
local combatRemote = findCombatRemote()


local function findArtifactRemote()
    local murim = ReplicatedStorage:FindFirstChild("Murim")
    local remotes = murim and murim:FindFirstChild("Remotes")
    return remotes and remotes:FindFirstChild("Artifact")
end
local artifactRemote = findArtifactRemote()


local hubUI = {}
local originalHitboxes = setmetatable({}, { __mode = "k" })
local selectedNPCNames = {} -- Nomes dos monstros selecionados [Name] = true/false
local knownNPCNames = {}    -- Monstros conhecidos e seus níveis [Name] = Level Number
local savedNPCPositions = {}-- Posições salvas dos monstros [Name] = CFrame (Auto Save)
local favoriteNPCNames = {} -- [Name] = true; priority targets for this session
local currentTarget = nil
local isAutoFarmBoss = false -- Ativa o farm automático de chefes
local selectedBossNames = {} -- Nomes dos chefes selecionados [Key/Name] = true/false
local bossCache = {}         -- [Key] = { Name, CFrame, TimeText, InFolder, Key, Level }
local activeBossTarget = nil
local bossProbeAt = {}
local lastBossCFrame = nil
local bossLootWaitUntil = 0
local updateBossTimers = nil


-- 🎃 Halloween Gate Raid Variables
local isAutoHallowRaid = false
local hallowDifficulty = "Normal"
local isHallowAutoRepeat = true
local isHallowPacifySeen = true
local lastSeenPacifyTime = 0
local lastRaidCombatTime = 0
local currentRaidRoomIndex = 1
local roomPatrolCooldown = 0
local toggleHallowRaidBtn = nil
local hallowStatusLabel = nil
local isHallowFoe = nil


local KNOWN_BOSSES = {
    {
        Key = "Ye Wuxian, the Stringless Bow",
        Name = "Ye Wuxian, the Stringless Bow",
        Alias = {"ye wuxian", "stringless bow", "wuxian"},
        Level = 95
    },
    {
        Key = "Qiongyu, the White-Jade Dragon",
        Name = "Qiongyu, the White-Jade Dragon",
        Alias = {"qiongyu", "white-jade dragon", "jade dragon", "white jade dragon"},
        Level = 92
    },
    {
        Key = "Patriarch Lou Kunshan",
        Name = "Patriarch Lou Kunshan",
        Alias = {"patriarch lou kunshan", "lou kunshan", "kunshan", "patriarch"},
        Level = 126
    },
    {
        Key = "HG_Cerberus",
        Name = "Cerberus Jiangshi",
        Alias = {"cerberus", "hg_cerberus", "three-headed", "yin gate", "สามหัว"},
        Level = 90
    },
    {
        Key = "HG_Matriarch",
        Name = "Hungry Ghost Matriarch",
        Alias = {"matriarch", "hg_matriarch", "hungry ghost matriarch", "empty belly", "แม่ผีหิว"},
        Level = 110
    }
}


local function resolveBossKey(rawName)
    if not rawName or rawName == "" then return nil end
    local lower = rawName:lower()
    for _, info in ipairs(KNOWN_BOSSES) do
        if info.Key:lower() == lower or info.Name:lower() == lower then
            return info.Key
        end
        for _, alias in ipairs(info.Alias or {}) do
            if lower:find(alias:lower(), 1, true) then
                return info.Key
            end
        end
    end
    for key, data in pairs(bossCache) do
        local kLow = key:lower()
        local dLow = (data.Name or ""):lower()
        if kLow == lower or dLow == lower or kLow:find(lower, 1, true) or lower:find(kLow, 1, true) then
            return key
        end
    end
    return rawName
end


local function checkIsBossName(name)
    if not name or name == "" then return false end
    local lower = name:lower()
    for _, info in ipairs(KNOWN_BOSSES) do
        if info.Key == name or info.Name == name or lower == info.Key:lower() or lower == info.Name:lower() then
            return true
        end
        for _, alias in ipairs(info.Alias or {}) do
            if lower:find(alias:lower(), 1, true) then
                return true
            end
        end
    end
    if name:find(",%s*the%s+") then
        return true
    end
    if lower:find("dragon") or lower:find("boss") or lower:find("patriarch") or lower:find("kunshan") or lower:find("cerberus") or lower:find("matriarch") then
        return true
    end
    if bossCache[name] then
        return true
    end
    return false
end


local bossEntityCache = setmetatable({}, { __mode = "k" })
local function checkIsBoss(npc)
    if not npc or not npc:IsA("Model") then return false, nil end
    local cached = bossEntityCache[npc]
    if cached ~= nil then
        if cached == false then return false, nil end
        return true, cached
    end
    local name = npc.Name
    if checkIsBossName(name) then
        local k = resolveBossKey(name) or name
        bossEntityCache[npc] = k
        return true, k
    end
    if npc:FindFirstChild("BossTimer", true) then
        bossEntityCache[npc] = name
        return true, name
    end
    bossEntityCache[npc] = false
    return false, nil
end


local npcLevelCache = setmetatable({}, { __mode = "k" })
local function getNPCLevel(npc)
        if not npc then return 0 end
    local cachedLvl = npcLevelCache[npc]
    if cachedLvl ~= nil then return cachedLvl end


        local attrLevel = npc:GetAttribute("Level") or npc:GetAttribute("Lv") or npc:GetAttribute("LevelValue")
        if typeof(attrLevel) == "number" then
        npcLevelCache[npc] = attrLevel
        return attrLevel
    end


        local levelVal = npc:FindFirstChild("Level") or npc:FindFirstChild("Lv") or npc:FindFirstChild("LevelValue")
        if levelVal and (levelVal:IsA("IntValue") or levelVal:IsA("NumberValue")) then
        npcLevelCache[npc] = levelVal.Value
                return levelVal.Value
        end


        local statsFolder = npc:FindFirstChild("Stats") or npc:FindFirstChild("Configuration") or npc:FindFirstChild("Data")
        if statsFolder then
                local lvl = statsFolder:FindFirstChild("Level") or statsFolder:FindFirstChild("Lv")
                if lvl and (lvl:IsA("IntValue") or lvl:IsA("NumberValue")) then
            npcLevelCache[npc] = lvl.Value
                        return lvl.Value
                end
        end


        local bKey = resolveBossKey(npc.Name)
        if bKey then
                for _, info in ipairs(KNOWN_BOSSES) do
                        if (info.Key == bKey or info.Name == bKey) and info.Level and info.Level > 0 then
                                npcLevelCache[npc] = info.Level
                                return info.Level
                        end
                end
        end


        local match = npc.Name:match("%d+")
        if match then
        local num = tonumber(match)
        npcLevelCache[npc] = num
        return num
    end


    for _, desc in ipairs(npc:GetDescendants()) do
        if desc:IsA("TextLabel") or desc:IsA("TextButton") then
            local lvlMatch = desc.Text:match("[Ll][Vv]%.?%s*(%d+)") or desc.Text:match("[Ll]evel%s*(%d+)")
            if lvlMatch then
                local num = tonumber(lvlMatch)
                if num and num > 0 then
                    npcLevelCache[npc] = num
                    return num
                end
            end
        end
    end


    npcLevelCache[npc] = 0
        return 0
end


local function getNPCRootPart(npc)
    if not npc or not npc:IsA("Model") then return nil end
    return npc:FindFirstChild("HumanoidRootPart")
        or npc.PrimaryPart
        or npc:FindFirstChild("Torso")
        or npc:FindFirstChild("UpperTorso")
        or npc:FindFirstChild("LowerTorso")
        or npc:FindFirstChild("Root")
        or npc:FindFirstChild("RootPart")
        or npc:FindFirstChild("Hitbox")
        or npc:FindFirstChild("Main")
        or npc:FindFirstChild("Base")
        or npc:FindFirstChild("Head")
        or npc:FindFirstChildWhichIsA("BasePart")
end


local function revealInvisibleNPC(npc)
    if not npc or not npc:IsA("Model") then return end
    pcall(function()
        for _, p in ipairs(npc:GetDescendants()) do
            if p:IsA("BasePart") then
                p.LocalTransparencyModifier = 0
                if p.Transparency >= 0.85 and p.Name ~= "HumanoidRootPart" then
                    p.Transparency = 0.25
                    p.Material = Enum.Material.ForceField
                    p.Color = Color3.fromRGB(190, 80, 255)
                end
            end
        end
        local hl = npc:FindFirstChild("MurimBossHighlight")
        if not hl then
            hl = Instance.new("Highlight")
            hl.Name = "MurimBossHighlight"
            hl.FillColor = Color3.fromRGB(180, 70, 255)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = npc
        end
    end)
end


isHallowFoe = function(npc)
    if not npc or not npc:IsA("Model") or not npc.Parent then return false end
    if Players:GetPlayerFromCharacter(npc) then return false end
    local hum = npc:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end


    -- Town / friendly NPCs with Talk or Interaction prompts must NEVER be foes!
    local prompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt and prompt.Enabled then
        local act = (prompt.ActionText or ""):lower()
        if act:find("talk") or act:find("shop") or act:find("buy") or act:find("cloth") or act:find("outfit") or act:find("chat") then
            return false
        end
    end


    if npc:GetAttribute("unhurt") or npc:GetAttribute("HallowNoBar") then
        return false
    end


    local name = npc.Name:lower()
    for _, ign in ipairs(HALLOW_IGNORE_KEYWORDS) do
        if name:find(ign, 1, true) then return false end
    end


    -- Raid boundary check: Raid is strictly located around X = 40000!
    -- Mobs outside the raid zone (X != 40000) are town / overworld NPCs and MUST be ignored!
    local p = npc.PrimaryPart or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
    if not p then return false end
    if math.abs(p.Position.X - 40000) > 3000 then
        return false
    end


    for _, kw in ipairs(HALLOW_FOE_KEYWORDS) do
        if name:find(kw, 1, true) then return true end
    end


    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and math.abs(hrp.Position.X - 40000) < 3000 then
        local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
        if npcsFolder and npc.Parent == npcsFolder then
            if (p.Position - hrp.Position).Magnitude < 300 then
                return true
            end
        end
    end


    return false
end


local friendlyCache = setmetatable({}, { __mode = "k" })
local function isFriendlyOrTalkable(npc)
    if not npc or not npc:IsA("Model") then return true end
    local cached = friendlyCache[npc]
    if cached ~= nil then return cached end


    -- Interactive dialogue/quest NPCs have prompts with Talk / Shop
    local prompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        local act = (prompt.ActionText or ""):lower()
        if act:find("talk") or act:find("shop") or act:find("buy") or act:find("chat") or act:find("outfit") or act:find("cloth") then
            friendlyCache[npc] = true
            return true
        end
    end


    if checkIsBoss(npc) or isHallowFoe(npc) then
        friendlyCache[npc] = false
        return false
    end


    -- 1. Any other ProximityPrompt
    if prompt then
        friendlyCache[npc] = true
        return true
    end


    -- 2. Dialog / DialogChoice objects
    if npc:FindFirstChildWhichIsA("Dialog", true) or npc:FindFirstChildWhichIsA("DialogChoice", true) then
        friendlyCache[npc] = true
        return true
    end


    -- 3. ClickDetector
    if npc:FindFirstChildWhichIsA("ClickDetector", true) then
        friendlyCache[npc] = true
        return true
    end


    -- 4. Dialogue / Interaction folders or objects
    for _, name in ipairs({"Interaction", "Dialog", "Dialogue", "Talk", "Quest", "Shop", "Conversation"}) do
        if npc:FindFirstChild(name, true) then
            friendlyCache[npc] = true
            return true
        end
    end


    -- 5. Check BillboardGuis / SurfaceGuis for talk / writ / quest prompts
    for _, desc in ipairs(npc:GetDescendants()) do
        if desc:IsA("BillboardGui") or desc:IsA("SurfaceGui") then
            local descName = desc.Name:lower()
            if descName:find("dialog") or descName:find("talk") or descName:find("quest") or descName:find("writ") or descName:find("prompt") or descName:find("interact") then
                friendlyCache[npc] = true
                return true
            end
            for _, label in ipairs(desc:GetDescendants()) do
                if label:IsA("TextLabel") then
                    local txt = label.Text:lower()
                    if txt:find("writ") or txt:find("talk") or txt:find("speak") or txt:find("quest") or txt:find("again every hour") or txt:find("hour") then
                        friendlyCache[npc] = true
                        return true
                    end
                end
            end
        end
    end


    friendlyCache[npc] = false
    return false
end


local function isAlive(npc)
        if not npc or not npc:IsA("Model") or not npc.Parent or not npc:IsDescendantOf(Workspace) then return false end
    if isFriendlyOrTalkable(npc) then return false end
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if not hum then return false end
        if hum.MaxHealth > 0 and hum.Health <= 0 then return false end
        if hum:GetState() == Enum.HumanoidStateType.Dead then return false end
    if npc:GetAttribute("Dead") == true or npc:GetAttribute("IsDead") == true then return false end
        local targetPart = getNPCRootPart(npc)
        return targetPart ~= nil
end


-- Pre-seed bossCache so Boss tab is NEVER blank!
for _, info in ipairs(KNOWN_BOSSES) do
    bossCache[info.Key] = {
        Key = info.Key,
        Name = info.Name,
        Level = info.Level,
        TimeText = "🔥 Chefe apareceu!",
        InFolder = false,
        CFrame = nil
    }
end


local isFarming = false
local isAutoLooting = true -- Auto Loot ativado por padrão
local isHitboxExpanded = true -- Hitbox expandida ativada por padrão
local isAutoParry = true -- Auto Parry ativado por padrão
local PARRY_DISTANCE = 18
local PARRY_WINDOW = 0.22
local PARRY_LEAD = 0.12
local isParrying = false
local handledAttacks = setmetatable({}, { __mode = "k" })


local isAutoArtifact = true -- Auto Artifact ativado por padrão
local artifactCooldown = 2.0 -- Intervalo de uso do artefato (segundos)
local lastArtifactUsed = 0
local artifactTask = nil


-- 🎁 Auto Loot & Loot Filter Configuration
local murimShared = nil
pcall(function()
    local murim = ReplicatedStorage:FindFirstChild("Murim") or ReplicatedStorage:WaitForChild("Murim", 5)
    murimShared = murim and (murim:FindFirstChild("Shared") or murim:WaitForChild("Shared", 5))
end)
local murimItems = nil
local murimConfig = nil
local murimBossKeys = nil
local murimItemColors = nil
if murimShared then
    pcall(function() murimItems = require(murimShared:WaitForChild("Items", 3)) end)
    pcall(function() murimConfig = require(murimShared:WaitForChild("Config", 3)) end)
    pcall(function() murimBossKeys = require(murimShared:WaitForChild("BossKeys", 3)) end)
    pcall(function() murimItemColors = require(murimShared:WaitForChild("ItemColors", 3)) end)
end


local heavenGradeThreshold = 4
if murimItems and murimItems.HeavenGrade then
    heavenGradeThreshold = tonumber(murimItems.HeavenGrade) or 4
end


local LOOT_FILTER_OPTIONS = {
    { text = "Todos (All)", minIdx = 1 },
    { text = "Incomum ou superior (Uncommon+)", minIdx = 2 },
    { text = "Raro ou superior (Rare+)", minIdx = 3 },
    { text = "Épico ou superior (Epic+)", minIdx = 4 },
    { text = "Lendário ou superior (Legendary+)", minIdx = 5 }
}
local currentLootFilterIdx = 1


local KEEP_CATS = {
    ["Currency"] = true,
    ["Quest"] = true,
    ["Collectible"] = true,
    ["Pet"] = true
}


local RARITY_MAP = {
    ["Common"] = 1,
    ["Uncommon"] = 2,
    ["Rare"] = 3,
    ["Epic"] = 4,
    ["Legendary"] = 5
}


local openedChests = setmetatable({}, { __mode = "k" })
local chestAttempts = setmetatable({}, { __mode = "k" })


local function isBossKey(id)
    if not murimBossKeys or type(id) ~= "string" then return false end
    local ok, res = pcall(function()
        if type(murimBossKeys.of) == "function" then
            return murimBossKeys.of(id) ~= nil
        end
        return false
    end)
    return ok and res or false
end


local chestCache = setmetatable({}, { __mode = "k" })
local function isChest(obj)
    if not obj then return false end
    local cached = chestCache[obj]
    if cached ~= nil then return cached end


    local name = obj.Name:lower()
    if name:find("chest") then
        chestCache[obj] = true
        return true
    end
    for _, prompt in ipairs(obj:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local action = (prompt.ActionText or ""):lower()
            local objText = (prompt.ObjectText or ""):lower()
            if action:find("open") or objText:find("chest") or prompt.Name:lower():find("chest") then
                chestCache[obj] = true
                return true
            end
        end
    end
    chestCache[obj] = false
    return false
end


local function shouldLootItem(drop)
    if not drop or not drop.Parent then return false end
    local personal = drop:GetAttribute("Personal")
    local owner = drop:GetAttribute("Owner")
    if personal == true and owner ~= player.UserId then
        return false
    end
    if currentLootFilterIdx <= 1 then
        return true
    end
    local itemId = drop:GetAttribute("ItemId")
    if not itemId then
        local p = drop:IsA("BasePart") and drop or drop:FindFirstChildWhichIsA("BasePart", true)
        if p then itemId = p:GetAttribute("ItemId") end
    end
    if type(itemId) ~= "string" then
        return true
    end
    local held = drop:GetAttribute("Held")
    if held and owner == player.UserId then
        return true
    end
    if drop:GetAttribute("Enchant") then
        return true
    end
    local grade = tonumber(drop:GetAttribute("Grade"))
    if grade and grade >= heavenGradeThreshold then
        return true
    end
    local seaColor = drop:GetAttribute("SeaColor")
    if type(seaColor) == "string" and murimItemColors and murimItemColors.tier then
        local ok, tier = pcall(murimItemColors.tier, seaColor)
        if ok and (tonumber(tier) or 0) >= 2 then
            return true
        end
    end
    local itemInfo = nil
    if murimItems and murimItems.get then
        local ok, info = pcall(murimItems.get, itemId)
        if ok and type(info) == "table" then
            itemInfo = info
        end
    end
    if itemInfo then
        if KEEP_CATS[itemInfo.cat] then
            return true
        end
        if isBossKey(itemInfo.id or itemId) then
            return true
        end
        local rIndex = 1
        if murimConfig and murimConfig.rarityIndex then
            local ok, idx = pcall(murimConfig.rarityIndex, itemInfo.rarity)
            if ok and tonumber(idx) then
                rIndex = tonumber(idx)
            end
        else
            rIndex = RARITY_MAP[itemInfo.rarity] or 1
        end
        return rIndex >= currentLootFilterIdx
    end
    return true
end


local mainTask = nil
local attackTask = nil
local folderConnections = {}
local externalConnections = {}
local destroyed = false
local refreshQueued = false
local npcSignature, tpSignature
local cachedTarget
local targetScanAt = 0
local TARGET_SCAN_INTERVAL = 0.15
local refreshNPCList
local function queueRefresh()
    if destroyed or refreshQueued then return end
    refreshQueued = true
    task.delay(0.1, function()
        refreshQueued = false
        if not destroyed and refreshNPCList then refreshNPCList() end
    end)
end
local function listSignature(names, levels)
    local parts = {}
    for name in pairs(names) do
        parts[#parts + 1] = string.format("%d:%s:%s", #name, name, tostring(levels[name] or 0))
    end
    table.sort(parts)
    return table.concat(parts, "|")
end


-- ⚙️ Tamanho da hitbox dos monstros (heightUnder, lyingRotation e farmPositionMode estão no escopo do arquivo)
local HITBOX_SIZE = Vector3.new(12, 12, 12)
local HITBOX_TRANSPARENCY = 0.7


--------------------------------------------------------------------------------
-- 🎨 1. Cria ScreenGui e coloca acima das demais interfaces
--------------------------------------------------------------------------------
local previousGui = playerGui:FindFirstChild("MurimMasterGui")
if previousGui then previousGui:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MurimMasterGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 2147483647 -- Força a janela a ficar acima das demais interfaces
screenGui.Parent = playerGui


local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 160, 0, 42)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -21)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "☰ Menu"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 15
toggleBtn.Parent = screenGui


local cornerToggle = Instance.new("UICorner")
cornerToggle.CornerRadius = UDim.new(0, 8)
cornerToggle.Parent = toggleBtn


local strokeToggle = Instance.new("UIStroke")
strokeToggle.Color = Color3.fromRGB(90, 80, 160)
strokeToggle.Thickness = 1.5
strokeToggle.Parent = toggleBtn


--------------------------------------------------------------------------------
-- 🎨 2. Main Frame janela principal
--------------------------------------------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 680)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -340)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.Visible = true
mainFrame.Parent = screenGui


local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 12)
cornerMain.Parent = mainFrame


local strokeMain = Instance.new("UIStroke")
strokeMain.Color = Color3.fromRGB(50, 50, 70)
strokeMain.Thickness = 1.5
strokeMain.Parent = mainFrame


-- Title Header Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)


local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Boxer_fighter_Test V2"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 15
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar


-- Arrastar a janela da interface
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position


        end
end)
titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
        end
end)
externalConnections[#externalConnections + 1] = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
end)


externalConnections[#externalConnections + 1] = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)


-- Botão de fechar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "−"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 14
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)


--------------------------------------------------------------------------------
-- 🎨 3. Conteúdo da interface
--------------------------------------------------------------------------------


local npcListHeader = Instance.new("TextLabel")
npcListHeader.Size = UDim2.new(1, -24, 0, 20)
npcListHeader.Position = UDim2.new(0, 12, 0, 52)
npcListHeader.BackgroundTransparency = 1
npcListHeader.Text = "🎯 Selecione os monstros para farmar:"
npcListHeader.TextColor3 = Color3.fromRGB(200, 200, 220)
npcListHeader.Font = Enum.Font.SourceSansBold
npcListHeader.TextSize = 13
npcListHeader.TextXAlignment = Enum.TextXAlignment.Left
npcListHeader.Parent = mainFrame


local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "NPCList"
scrollFrame.Size = UDim2.new(1, -24, 0, 140)
scrollFrame.Position = UDim2.new(0, 12, 0, 74)
scrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = mainFrame
Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0, 8)


local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 4)
uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 8)
end)


local tpHeaderLabel = Instance.new("TextLabel")
tpHeaderLabel.Name = "TPHeaderLabel"
tpHeaderLabel.Size = UDim2.new(1, -24, 0, 20)
tpHeaderLabel.Position = UDim2.new(0, 12, 0, 222)
tpHeaderLabel.BackgroundTransparency = 1
tpHeaderLabel.Text = "🌀 Teleporte para monstros (salvo automaticamente | maior → menor):"
tpHeaderLabel.TextColor3 = Color3.fromRGB(180, 160, 255)
tpHeaderLabel.Font = Enum.Font.SourceSansBold
tpHeaderLabel.TextSize = 13
tpHeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
tpHeaderLabel.Parent = mainFrame


local tpScrollFrame = Instance.new("ScrollingFrame")
tpScrollFrame.Name = "TPList"
tpScrollFrame.Size = UDim2.new(1, -24, 0, 120)
tpScrollFrame.Position = UDim2.new(0, 12, 0, 244)
tpScrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
tpScrollFrame.BorderSizePixel = 0
tpScrollFrame.ScrollBarThickness = 5
tpScrollFrame.Parent = mainFrame
Instance.new("UICorner", tpScrollFrame).CornerRadius = UDim.new(0, 8)


local tpListLayout = Instance.new("UIListLayout")
tpListLayout.Parent = tpScrollFrame
tpListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tpListLayout.Padding = UDim.new(0, 4)
tpListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tpScrollFrame.CanvasSize = UDim2.new(0, 0, 0, tpListLayout.AbsoluteContentSize.Y + 8)
end)


--------------------------------------------------------------------------------
-- 🎨 4. Controles e configurações
--------------------------------------------------------------------------------


local togglePositionModeBtn = Instance.new("TextButton")
togglePositionModeBtn.Name = "FarmPositionModeToggle"
togglePositionModeBtn.Size = UDim2.new(1, -24, 0, 32)
togglePositionModeBtn.Position = UDim2.new(0, 12, 1, -336)
togglePositionModeBtn.Font = Enum.Font.SourceSansBold
togglePositionModeBtn.TextSize = 13
togglePositionModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
togglePositionModeBtn.Parent = mainFrame
Instance.new("UICorner", togglePositionModeBtn).CornerRadius = UDim.new(0, 6)


local distLabel = Instance.new("TextLabel")
distLabel.Name = "DistanceLabel"
distLabel.Size = UDim2.new(1, -24, 0, 20)
distLabel.Position = UDim2.new(0, 12, 1, -298)
distLabel.BackgroundTransparency = 1
distLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
distLabel.Font = Enum.Font.SourceSansBold
distLabel.TextSize = 13
distLabel.Parent = mainFrame


local addDistBtn = Instance.new("TextButton")
addDistBtn.Size = UDim2.new(0, 152, 0, 28)
addDistBtn.Position = UDim2.new(0, 12, 1, -274)
addDistBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
addDistBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
addDistBtn.Text = "⬆️ +0.5 (mais alto)"
addDistBtn.Font = Enum.Font.SourceSansBold
addDistBtn.TextSize = 12
addDistBtn.Parent = mainFrame
Instance.new("UICorner", addDistBtn).CornerRadius = UDim.new(0, 6)


local subDistBtn = Instance.new("TextButton")
subDistBtn.Size = UDim2.new(0, 152, 0, 28)
subDistBtn.Position = UDim2.new(1, -164, 1, -274)
subDistBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
subDistBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
subDistBtn.Text = "⬇️ -0.5 (mais baixo)"
subDistBtn.Font = Enum.Font.SourceSansBold
subDistBtn.TextSize = 12
subDistBtn.Parent = mainFrame
Instance.new("UICorner", subDistBtn).CornerRadius = UDim.new(0, 6)


local function updateDistText()
        local modeThai = farmPositionMode == "Above" and "Flutuando acima (Above)" or "Abaixo do solo (Under)"
        distLabel.Text = string.format("📏 Distância [%s]: %.1f studs", modeThai, farmDistance)
        if farmPositionMode == "Above" then
                togglePositionModeBtn.Text = "🛸 Modo de posição: Flutuando acima (Above) ⬇️ olhando para o chão"
                togglePositionModeBtn.BackgroundColor3 = Color3.fromRGB(35, 125, 185)
                addDistBtn.Text = "⬆️ +0.5 (mais alto)"
                subDistBtn.Text = "⬇️ -0.5 (mais baixo)"
        else
                togglePositionModeBtn.Text = "⛏️ Modo de posição: Abaixo do solo (Under) ⬆️ olhando para cima"
                togglePositionModeBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 40)
                addDistBtn.Text = "⬆️ +0.5 (mais raso)"
                subDistBtn.Text = "⬇️ -0.5 (mais fundo)"
        end
end
updateFarmPositionDisplay = updateDistText
updateDistText()


togglePositionModeBtn.MouseButton1Click:Connect(function()
        if farmPositionMode == "Above" then
                updateFarmSettings("Under", farmDistance)
        else
                updateFarmSettings("Above", farmDistance)
        end
end)


addDistBtn.MouseButton1Click:Connect(function()
        updateFarmSettings(nil, farmDistance + 0.5)
end)


subDistBtn.MouseButton1Click:Connect(function()
        updateFarmSettings(nil, farmDistance - 0.5)
end)


local toggleHitboxBtn = Instance.new("TextButton")
toggleHitboxBtn.Size = UDim2.new(1, -24, 0, 32)
toggleHitboxBtn.Position = UDim2.new(0, 12, 1, -240)
toggleHitboxBtn.BackgroundColor3 = Color3.fromRGB(40, 110, 150)
toggleHitboxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHitboxBtn.Text = "🎯 Expandir hitbox dos monstros (Hitbox: ON)"
toggleHitboxBtn.Font = Enum.Font.SourceSansBold
toggleHitboxBtn.TextSize = 13
toggleHitboxBtn.Parent = mainFrame
Instance.new("UICorner", toggleHitboxBtn).CornerRadius = UDim.new(0, 6)


local toggleLootBtn = Instance.new("TextButton")
toggleLootBtn.Size = UDim2.new(1, -24, 0, 32)
toggleLootBtn.Position = UDim2.new(0, 12, 1, -202)
toggleLootBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
toggleLootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleLootBtn.Text = "🎁 Coleta automática de itens (Auto Loot: ON)"
toggleLootBtn.Font = Enum.Font.SourceSansBold
toggleLootBtn.TextSize = 13
toggleLootBtn.Parent = mainFrame
Instance.new("UICorner", toggleLootBtn).CornerRadius = UDim.new(0, 6)


local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1, -24, 0, 36)
startBtn.Position = UDim2.new(0, 12, 1, -162)
startBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 65)
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Text = "Iniciar farm"
startBtn.Font = Enum.Font.SourceSansBold
startBtn.TextSize = 14
startBtn.Parent = mainFrame
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 6)


local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, -24, 0, 34)
stopBtn.Position = UDim2.new(0, 12, 1, -120)
stopBtn.BackgroundColor3 = Color3.fromRGB(170, 75, 30)
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.Text = "Parar tudo"
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 14
stopBtn.Parent = mainFrame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)


local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(1, -24, 0, 34)
destroyBtn.Position = UDim2.new(0, 12, 1, -80)
destroyBtn.BackgroundColor3 = Color3.fromRGB(140, 35, 35)
destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyBtn.Text = "🗑️ Fechar e remover interface (Destroy)"
destroyBtn.Font = Enum.Font.SourceSansBold
destroyBtn.TextSize = 14
destroyBtn.Parent = mainFrame
Instance.new("UICorner", destroyBtn).CornerRadius = UDim.new(0, 6)


--------------------------------------------------------------------------------
-- ⚙️ 5. Cálculos e funções de farm
--------------------------------------------------------------------------------


do
-- Presentation only: all existing callbacks and farming logic stay unchanged.
-- Use the same positioning style as the original GUI.
local windowWidth, windowHeight = 460, 680
local camera = Workspace.CurrentCamera
if camera then
    local viewport = camera.ViewportSize
    if viewport.X > 0 and viewport.Y > 0 then
        windowWidth = math.min(windowWidth, math.max(240, viewport.X - 24))
        windowHeight = math.min(windowHeight, math.max(240, viewport.Y - 72))
    end
end
mainFrame.Size = UDim2.new(0, windowWidth, 0, windowHeight)
mainFrame.Position = UDim2.new(0.5, -windowWidth / 2, 0.5, -windowHeight / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 20, 29)
strokeMain.Color = Color3.fromRGB(55, 65, 87)


titleBar.Size = UDim2.new(1, 0, 0, 56)
titleBar.BackgroundColor3 = Color3.fromRGB(24, 29, 41)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.Size = UDim2.new(1, -76, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(231, 235, 248)
titleLabel.TextSize = 16
titleLabel.TextWrapped = true
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -44, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(106, 46, 58)
toggleBtn.Position = UDim2.new(0, 16, 0.5, -21)


local function sectionHeading(label, parent, text)
    label.Parent = parent
    label.Position = UDim2.new(0, 12, 0, 8)
    label.Size = UDim2.new(1, -24, 0, 28)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(199, 210, 235)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
end
local function newHeading(parent, text)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSansBold
    sectionHeading(label, parent, text)
end
local function placeButton(button, parent, xScale, xOffset, y, widthScale, widthOffset)
    button.Parent = parent
    button.Position = UDim2.new(xScale, xOffset, 0, y)
    button.Size = UDim2.new(widthScale, widthOffset, 0, 44)
    button.BorderSizePixel = 0
    button.TextSize = 14
    button.TextWrapped = true
end


-- PTBR MOBILE: abas horizontais com arraste por toque.
local tabsBar = Instance.new("ScrollingFrame")
tabsBar.Name = "Tabs"
tabsBar.Position = UDim2.new(0, 10, 0, 60)
tabsBar.Size = UDim2.new(1, -20, 0, 49)
tabsBar.BackgroundTransparency = 1
tabsBar.BorderSizePixel = 0
tabsBar.ScrollingDirection = Enum.ScrollingDirection.X
tabsBar.ScrollingEnabled = true
tabsBar.ElasticBehavior = Enum.ElasticBehavior.Never
tabsBar.ScrollBarThickness = 3
tabsBar.ScrollBarImageColor3 = Color3.fromRGB(125, 160, 220)
tabsBar.CanvasSize = UDim2.fromOffset(0, 0)
tabsBar.Active = true
tabsBar.Parent = mainFrame
local pagesHost = Instance.new("Frame")
pagesHost.Name = "Pages"
pagesHost.Position = UDim2.new(0, 10, 0, 116)
pagesHost.Size = UDim2.new(1, -20, 1, -174)
pagesHost.BackgroundTransparency = 1
pagesHost.ClipsDescendants = true
pagesHost.Parent = mainFrame
local pages, tabs = {}, {}
local function showPage(index)
    for i, page in pairs(pages) do
        page.Visible = i == index
        if tabs[i] then
            tabs[i].BackgroundColor3 = i == index and Color3.fromRGB(72, 86, 147) or Color3.fromRGB(30, 37, 51)
            tabs[i].TextColor3 = i == index and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(165, 179, 205)
        end
    end
    if index == 2 and typeof(updateBossTimers) == "function" then
        task.defer(function()
            pcall(updateBossTimers)
        end)
    end
end
local function makePage(name, index, caption)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundColor3 = Color3.fromRGB(25, 30, 42)
    page.BorderSizePixel = 0
    page.Visible = false
    page.Parent = pagesHost
    Instance.new("UICorner", page).CornerRadius = UDim.new(0, 10)
    pages[index] = page
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.fromOffset(104, 39)
    tab.Position = UDim2.fromOffset((index - 1) * 110 + 2, 2)
    tabsBar.CanvasSize = UDim2.fromOffset(math.max(tabsBar.CanvasSize.X.Offset, index * 110 + 8), 0)
    tab.BorderSizePixel = 0
    tab.Font = Enum.Font.SourceSansBold
    tab.TextSize = 12
    tab.Text = caption
    tab.TextWrapped = true
    tab.Parent = tabsBar
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 8)
    tabs[index] = tab
    tab.Activated:Connect(function()
        if os.clock() < (tabsBar:GetAttribute("NavIgnoreUntil") or 0) then return end
        showPage(index)
    end)
    return page
end


local npcPage = makePage("Monsters", 1, "Monstros")
sectionHeading(npcListHeader, npcPage, "Selecione os monstros • ★ prioriza os favoritos")


--------------------------------------------------------------------------------
-- ⚔️ Boss Page (Index 2)
--------------------------------------------------------------------------------
local function getCFrameFromAnchor(anchor)
    if not anchor then return nil end
    if anchor:IsA("BasePart") then return anchor.CFrame end
    if anchor:IsA("Model") then return anchor:GetPivot() end
    if anchor:IsA("CFrameValue") then return anchor.Value end
    if anchor:IsA("Vector3Value") then return CFrame.new(anchor.Value) end
    if anchor:IsA("ObjectValue") and anchor.Value then
        local t = anchor.Value
        if t:IsA("BasePart") then return t.CFrame end
        if t:IsA("Model") then return t:GetPivot() end
    end
    return nil
end


local function parseBossInfo(bossItem)
    local bossName = bossItem.Name
    local timeText = "N/A"
    local cf = nil


    local anchor = bossItem:FindFirstChild("Anchor") or bossItem
    if anchor then
        cf = getCFrameFromAnchor(anchor)
        local bossTimer = (bossItem:FindFirstChild("Anchor") and bossItem.Anchor:FindFirstChild("BossTimer"))
            or bossItem:FindFirstChild("BossTimer")
            or bossItem:FindFirstChildWhichIsA("BillboardGui", true)
            or bossItem:FindFirstChildWhichIsA("SurfaceGui", true)
        if bossTimer then
            local textLabels = {}
            for _, desc in ipairs(bossTimer:GetDescendants()) do
                if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and desc.Text ~= "" then
                    table.insert(textLabels, desc)
                end
            end
            if #textLabels > 0 then
                local nameObj = nil
                local timerObj = nil
                for _, lbl in ipairs(textLabels) do
                    local txt = lbl.Text
                    if txt:find("%d+[%smh:]") or txt:find("เกิดแล้ว") then
                        timerObj = lbl
                    else
                        nameObj = lbl
                    end
                end
                if nameObj then bossName = nameObj.Text end
                if timerObj then timeText = timerObj.Text end
            end


            for _, desc in ipairs(bossTimer:GetDescendants()) do
                if desc:IsA("ValueBase") then
                    local rawVal = desc.Value
                    if type(rawVal) == "number" then
                        if rawVal <= 0 then
                            timeText = "🔥 Chefe apareceu!"
                        elseif rawVal >= 60 then
                            local mins = math.floor(rawVal / 60)
                            local secs = math.floor(rawVal % 60)
                            timeText = string.format("%dm %02ds", mins, secs)
                        else
                            timeText = string.format("%.1fs", rawVal)
                        end
                    else
                        timeText = tostring(rawVal)
                    end
                    break
                end
            end
        end
    end
    
    return bossName, timeText, cf
end


do
local bossPage = makePage("Bosses", 2, "Chefes")
newHeading(bossPage, "Caça automática aos chefes e monitoramento de respawn")


local toggleBossBtn = Instance.new("TextButton")
toggleBossBtn.Name = "ToggleBossFarmBtn"
toggleBossBtn.Size = UDim2.new(1, -24, 0, 36)
toggleBossBtn.Position = UDim2.new(0, 12, 0, 44)
toggleBossBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
toggleBossBtn.Text = "⚔️ Caçar chefes automaticamente (Auto Boss: OFF)"
toggleBossBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBossBtn.TextSize = 13
toggleBossBtn.Font = Enum.Font.SourceSansBold
toggleBossBtn.Parent = bossPage
Instance.new("UICorner", toggleBossBtn).CornerRadius = UDim.new(0, 6)


local bossSubHeading = Instance.new("TextLabel")
bossSubHeading.Size = UDim2.new(1, -24, 0, 20)
bossSubHeading.Position = UDim2.new(0, 12, 0, 84)
bossSubHeading.BackgroundTransparency = 1
bossSubHeading.Text = "Escolha os chefes • teleporta ao nascer • retorna ao farm após derrotar"
bossSubHeading.TextColor3 = Color3.fromRGB(165, 179, 205)
bossSubHeading.TextSize = 11
bossSubHeading.Font = Enum.Font.SourceSans
bossSubHeading.TextXAlignment = Enum.TextXAlignment.Left
bossSubHeading.Parent = bossPage


local bossScrollFrame = Instance.new("ScrollingFrame")
bossScrollFrame.Name = "BossScrollFrame"
bossScrollFrame.Size = UDim2.new(1, -24, 1, -112)
bossScrollFrame.Position = UDim2.new(0, 12, 0, 106)
bossScrollFrame.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
bossScrollFrame.BorderSizePixel = 0
bossScrollFrame.ScrollBarThickness = 4
bossScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
bossScrollFrame.Parent = bossPage
Instance.new("UICorner", bossScrollFrame).CornerRadius = UDim.new(0, 6)


local bossListLayout = Instance.new("UIListLayout")
bossListLayout.SortOrder = Enum.SortOrder.LayoutOrder
bossListLayout.Padding = UDim.new(0, 6)
bossListLayout.Parent = bossScrollFrame


bossListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    bossScrollFrame.CanvasSize = UDim2.new(0, 0, 0, bossListLayout.AbsoluteContentSize.Y + 10)
end)


toggleBossBtn.MouseButton1Click:Connect(function()
    isAutoFarmBoss = not isAutoFarmBoss
    if isAutoFarmBoss then
        toggleBossBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 60)
        toggleBossBtn.Text = "⚔️ Caçar chefes automaticamente (Auto Boss: ON)"
    else
        toggleBossBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
        toggleBossBtn.Text = "⚔️ Caçar chefes automaticamente (Auto Boss: OFF)"
        activeBossTarget = nil
    end
end)


updateBossTimers = function()
    -- 1. Ensure known bosses are pre-seeded in bossCache and have CFrames from savedNPCPositions
    for _, info in ipairs(KNOWN_BOSSES) do
        local key = info.Key
        if not bossCache[key] then
            bossCache[key] = {
                Key = key,
                Name = info.Name,
                Level = info.Level,
                TimeText = "🔥 Chefe apareceu!",
                InFolder = false,
                CFrame = nil
            }
        end
        if not bossCache[key].CFrame then
            bossCache[key].CFrame = savedNPCPositions[key] or savedNPCPositions[info.Name]
        end
    end


    -- 2. Scan Workspace.Murim_BossTimers (countdown timer objects when bosses are dead)
    local bossFolder = Workspace:FindFirstChild("Murim_BossTimers")
    local activeInFolder = {}


    if bossFolder then
        for _, item in pairs(bossFolder:GetChildren()) do
            local bName, tText, cf = parseBossInfo(item)
            local key = resolveBossKey(bName) or resolveBossKey(item.Name) or item.Name
            activeInFolder[key] = true


            if not bossCache[key] then
                bossCache[key] = {
                    Key = key,
                    Name = bName or key,
                }
            end
            if bName and bName ~= "" and bossCache[key].Name == key then
                bossCache[key].Name = bName
            end
            if cf then
                bossCache[key].CFrame = cf
                savedNPCPositions[key] = cf
                savedNPCPositions[bName or key] = cf
            elseif not bossCache[key].CFrame then
                bossCache[key].CFrame = savedNPCPositions[key] or savedNPCPositions[bName or key]
            end
            bossCache[key].TimeText = tText
            bossCache[key].InFolder = true
        end
    end


    -- 3. Scan Workspace.Murim_NPCs (live bosses currently spawned in the world)
    local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if npc:IsA("Model") and isAlive(npc) then
                local isBoss, bKey = checkIsBoss(npc)
                if isBoss and bKey then
                    revealInvisibleNPC(npc)
                    local part = getNPCRootPart(npc)
                    local cf = part and part.CFrame
                    if not bossCache[bKey] then
                        bossCache[bKey] = {
                            Key = bKey,
                            Name = npc.Name,
                            Level = getNPCLevel(npc)
                        }
                    end
                    if cf then
                        bossCache[bKey].CFrame = cf
                        savedNPCPositions[bKey] = cf
                        savedNPCPositions[npc.Name] = cf
                    end
                    bossCache[bKey].TimeText = "🔥 Chefe apareceu!"
                    bossCache[bKey].InFolder = false
                end
            end
        end
    end


    -- 4. Check savedNPCPositions for any previously recorded bosses
    for name, cf in pairs(savedNPCPositions) do
        if checkIsBossName(name) then
            local bKey = resolveBossKey(name) or name
            if not bossCache[bKey] then
                bossCache[bKey] = {
                    Key = bKey,
                    Name = name,
                    Level = knownNPCNames[name] or 0,
                    TimeText = "🔥 Chefe apareceu!",
                    InFolder = false,
                    CFrame = cf
                }
            elseif not bossCache[bKey].CFrame then
                bossCache[bKey].CFrame = cf
            end
        end
    end


    -- 5. Any boss not in Murim_BossTimers is considered alive/spawned
    for key, data in pairs(bossCache) do
        if not activeInFolder[key] then
            data.InFolder = false
            data.TimeText = "🔥 Chefe apareceu!"
            if not data.CFrame then
                data.CFrame = savedNPCPositions[key] or savedNPCPositions[data.Name]
            end
        end
    end


    if not bossScrollFrame or not bossScrollFrame.Parent then return end


    -- Sort bosses by Level descending, then Name
    local sortedBosses = {}
    for key, data in pairs(bossCache) do
        table.insert(sortedBosses, data)
    end
    table.sort(sortedBosses, function(a, b)
        local la = a.Level or 0
        local lb = b.Level or 0
        if la == lb then
            return (a.Name or a.Key) < (b.Name or b.Key)
        end
        return la > lb
    end)


    local existingCards = {}
    for _, child in pairs(bossScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            existingCards[child.Name] = child
        end
    end


    for idx, data in ipairs(sortedBosses) do
        local key = data.Key
        local card = existingCards[key]
        local isSelected = selectedBossNames[key] == true
        local isSpawned = data.TimeText and (data.TimeText:find("apareceu") or data.TimeText:find("เกิดแล้ว"))


        if not card then
            card = Instance.new("Frame")
            card.Name = key
            card.Size = UDim2.new(1, -6, 0, 42)
            card.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            card.BorderSizePixel = 0
            card.Parent = bossScrollFrame


            local cardCorner = Instance.new("UICorner")
            cardCorner.CornerRadius = UDim.new(0, 6)
            cardCorner.Parent = card


            local selectBtn = Instance.new("TextButton")
            selectBtn.Name = "SelectBtn"
            selectBtn.Size = UDim2.new(0.50, -5, 1, 0)
            selectBtn.Position = UDim2.new(0, 8, 0, 0)
            selectBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            selectBtn.TextSize = 13
            selectBtn.Font = Enum.Font.SourceSansBold
            selectBtn.TextXAlignment = Enum.TextXAlignment.Left
            selectBtn.TextTruncate = Enum.TextTruncate.AtEnd
            selectBtn.BackgroundTransparency = 1
            selectBtn.Parent = card


            local valLabel = Instance.new("TextLabel")
            valLabel.Name = "ValLabel"
            valLabel.Size = UDim2.new(0.30, -5, 1, 0)
            valLabel.Position = UDim2.new(0.50, 0, 0, 0)
            valLabel.TextColor3 = Color3.fromRGB(85, 255, 127)
            valLabel.TextSize = 12
            valLabel.Font = Enum.Font.SourceSansBold
            valLabel.TextXAlignment = Enum.TextXAlignment.Right
            valLabel.BackgroundTransparency = 1
            valLabel.Parent = card


            local tpBtn = Instance.new("TextButton")
            tpBtn.Name = "TPBtn"
            tpBtn.Size = UDim2.new(0.18, -6, 0, 26)
            tpBtn.Position = UDim2.new(0.82, 0, 0.5, -13)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 240)
            tpBtn.Text = "TP"
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.Font = Enum.Font.SourceSansBold
            tpBtn.TextSize = 12
            tpBtn.Parent = card


            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = tpBtn


            selectBtn.MouseButton1Click:Connect(function()
                selectedBossNames[key] = not selectedBossNames[key]
                pcall(updateBossTimers)
            end)


            tpBtn.MouseButton1Click:Connect(function()
                local currentData = bossCache[key]
                local targetCF = (currentData and currentData.CFrame)
                    or savedNPCPositions[key]
                    or (currentData and savedNPCPositions[currentData.Name])
                if targetCF then
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = targetCF * CFrame.new(0, 4, 0)
                        tpBtn.Text = "✅"
                        task.delay(1, function()
                            if tpBtn and tpBtn.Parent then tpBtn.Text = "TP" end
                        end)
                    end
                else
                    tpBtn.Text = "❌ Aguardando coordenadas"
                    task.delay(1.5, function()
                        if tpBtn and tpBtn.Parent then tpBtn.Text = "TP" end
                    end)
                end
            end)
        end


        card.LayoutOrder = idx


        local selectBtn = card:FindFirstChild("SelectBtn")
        local valLabel = card:FindFirstChild("ValLabel")
        local tpBtn = card:FindFirstChild("TPBtn")


        if selectBtn and valLabel then
            local lvlStr = (data.Level and data.Level > 0) and string.format(" [Lv.%d]", data.Level) or ""
            local newSelTxt = (isSelected and "[✓] " or "[ ] ") .. (data.Name or key) .. lvlStr
            if selectBtn.Text ~= newSelTxt then selectBtn.Text = newSelTxt end
            local newTimeTxt = data.TimeText or "🔥 Chefe apareceu!"
            if valLabel.Text ~= newTimeTxt then valLabel.Text = newTimeTxt end


            if isSpawned then
                if valLabel.TextColor3 ~= Color3.fromRGB(255, 80, 80) then
                    valLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                end
                local targetBg = isSelected and Color3.fromRGB(75, 30, 35) or Color3.fromRGB(55, 25, 30)
                if card.BackgroundColor3 ~= targetBg then card.BackgroundColor3 = targetBg end
            else
                if valLabel.TextColor3 ~= Color3.fromRGB(85, 255, 127) then
                    valLabel.TextColor3 = Color3.fromRGB(85, 255, 127)
                end
                local targetBg = isSelected and Color3.fromRGB(30, 60, 45) or Color3.fromRGB(35, 35, 45)
                if card.BackgroundColor3 ~= targetBg then card.BackgroundColor3 = targetBg end
            end
        end


        if tpBtn then
            local hasCF = data.CFrame or savedNPCPositions[key] or (data.Name and savedNPCPositions[data.Name])
            if hasCF then
                if tpBtn.BackgroundColor3 ~= Color3.fromRGB(0, 140, 240) then
                    tpBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 240)
                end
                if tpBtn.Text ~= "✅" and not tpBtn.Text:find("❌") and tpBtn.Text ~= "TP" then
                    tpBtn.Text = "TP"
                end
            else
                if tpBtn.BackgroundColor3 ~= Color3.fromRGB(70, 70, 85) then
                    tpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
                end
                if tpBtn.Text ~= "✅" and not tpBtn.Text:find("❌") and tpBtn.Text ~= "Aguardando coordenadas" then
                    tpBtn.Text = "Aguardando coordenadas"
                end
            end
        end
    end


    local totalCards = #sortedBosses
    local layoutH = bossListLayout.AbsoluteContentSize.Y
    if layoutH <= 0 then layoutH = totalCards * 48 end
    bossScrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(layoutH + 10, totalCards * 48 + 10))
end


externalConnections[#externalConnections + 1] = Workspace.ChildAdded:Connect(function(child)
    if child.Name == "Murim_BossTimers" then updateBossTimers() end
end)


task.spawn(function()
    while not destroyed do
        pcall(updateBossTimers)
        task.wait(1)
    end
end)
end


local tpPage = makePage("Teleport", 3, "Pontos de teleporte")
sectionHeading(tpHeaderLabel, tpPage, "Pontos de teleporte • salvamento automático • nível maior → menor")
scrollFrame.Parent = npcPage
tpScrollFrame.Parent = tpPage
for _, list in ipairs({scrollFrame, tpScrollFrame}) do
    list.Position = UDim2.new(0, 12, 0, 44)
    list.Size = UDim2.new(1, -24, 1, -56)
    list.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
    list.ScrollBarImageColor3 = Color3.fromRGB(114, 131, 171)
    list.CanvasSize = UDim2.new(0, 0, 0, 0)


end


--------------------------------------------------------------------------------
-- ☯️ Hongmeng & Wild Qi Page (Index 7)
--------------------------------------------------------------------------------
local HongmengConfig = {
    Enabled = false,
    AutoTeleportWildQi = false,
    DiscordWebhook = "",
    DiscordNotify = true,
}
hubUI.HongmengConfig = HongmengConfig


local GradeColors = {
    [99] = Color3.fromRGB(255, 60, 100), -- WildQi Special
    [7]  = Color3.fromRGB(180, 40, 40),   -- Void
    [6]  = Color3.fromRGB(220, 170, 40),  -- Mist/Fog
    [5]  = Color3.fromRGB(130, 50, 200),  -- Thunder
    [0]  = Color3.fromRGB(60, 100, 160)   -- General
}


local GradeNames = {
    [99] = "★ WildQi (Special Target)",
    [7]  = "Grade 7 (Void)",
    [6]  = "Grade 6 (Mist/Fog)",
    [5]  = "Grade 5 (Thunder)",
}


do
local hongmengPage = makePage("Hongmeng", 7, "Hongmeng")
newHeading(hongmengPage, "Ritual Hongmeng e pontos de surgimento de Wild Qi")


local hongmengBody = Instance.new("Frame")
hongmengBody.Name = "HongmengBody"
hongmengBody.Position = UDim2.new(0, 0, 0, 44)
hongmengBody.Size = UDim2.new(1, 0, 1, -44)
hongmengBody.BackgroundTransparency = 1
hongmengBody.Parent = hongmengPage


-- Sub-tabs Bar
local hTabBar = Instance.new("Frame")
hTabBar.Name = "HTabBar"
hTabBar.Size = UDim2.new(1, -24, 0, 30)
hTabBar.Position = UDim2.new(0, 12, 0, 0)
hTabBar.BackgroundTransparency = 1
hTabBar.Parent = hongmengBody


local autoTabBtn = Instance.new("TextButton")
autoTabBtn.Name = "AutoTabBtn"
autoTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
autoTabBtn.Position = UDim2.new(0, 0, 0, 0)
autoTabBtn.BackgroundColor3 = Color3.fromRGB(72, 86, 147)
autoTabBtn.Text = "Auto Hongmeng"
autoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoTabBtn.TextSize = 13
autoTabBtn.Font = Enum.Font.SourceSansBold
autoTabBtn.Parent = hTabBar
Instance.new("UICorner", autoTabBtn).CornerRadius = UDim.new(0, 6)


local wildQiTabBtn = Instance.new("TextButton")
wildQiTabBtn.Name = "WildQiTabBtn"
wildQiTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
wildQiTabBtn.Position = UDim2.new(0.52, 0, 0, 0)
wildQiTabBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
wildQiTabBtn.Text = "Wild Qi List"
wildQiTabBtn.TextColor3 = Color3.fromRGB(165, 179, 205)
wildQiTabBtn.TextSize = 13
wildQiTabBtn.Font = Enum.Font.SourceSansBold
wildQiTabBtn.Parent = hTabBar
Instance.new("UICorner", wildQiTabBtn).CornerRadius = UDim.new(0, 6)


-- Sub-pages
local autoPage = Instance.new("Frame")
autoPage.Name = "AutoPage"
autoPage.Size = UDim2.new(1, -24, 1, -38)
autoPage.Position = UDim2.new(0, 12, 0, 36)
autoPage.BackgroundTransparency = 1
autoPage.Visible = true
autoPage.Parent = hongmengBody


local wildQiPage = Instance.new("Frame")
wildQiPage.Name = "WildQiPage"
wildQiPage.Size = UDim2.new(1, -24, 1, -38)
wildQiPage.Position = UDim2.new(0, 12, 0, 36)
wildQiPage.BackgroundTransparency = 1
wildQiPage.Visible = false
wildQiPage.Parent = hongmengBody


-- 1. Auto Page Controls
local toggleHBtn = Instance.new("TextButton")
toggleHBtn.Name = "ToggleHBtn"
toggleHBtn.Size = UDim2.new(1, 0, 0, 38)
toggleHBtn.Position = UDim2.new(0, 0, 0, 4)
toggleHBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
toggleHBtn.Text = "AUTO HONGMENG: OFF"
toggleHBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHBtn.TextSize = 13
toggleHBtn.Font = Enum.Font.SourceSansBold
toggleHBtn.Parent = autoPage
Instance.new("UICorner", toggleHBtn).CornerRadius = UDim.new(0, 6)


local statusHLabel = Instance.new("TextLabel")
statusHLabel.Name = "StatusHLabel"
statusHLabel.Size = UDim2.new(1, 0, 0, 56)
statusHLabel.Position = UDim2.new(0, 0, 0, 48)
statusHLabel.BackgroundTransparency = 1
statusHLabel.Text = "Status: desativado\n(Verifica condições e envia comandos remotos automaticamente)"
statusHLabel.TextColor3 = Color3.fromRGB(170, 180, 205)
statusHLabel.TextSize = 12
statusHLabel.Font = Enum.Font.SourceSans
statusHLabel.TextWrapped = true
statusHLabel.Parent = autoPage


local searchHBtn = Instance.new("TextButton")
searchHBtn.Name = "SearchHBtn"
searchHBtn.Size = UDim2.new(1, 0, 0, 34)
searchHBtn.Position = UDim2.new(0, 0, 0, 110)
searchHBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 160)
searchHBtn.Text = "Iniciar Auto H com dados do ritual"
searchHBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
searchHBtn.TextSize = 13
searchHBtn.Font = Enum.Font.SourceSansBold
searchHBtn.Parent = autoPage
Instance.new("UICorner", searchHBtn).CornerRadius = UDim.new(0, 6)


do
    local guideBox = Instance.new("Frame")
    guideBox.Name = "GuideBox"
    guideBox.Size = UDim2.new(1, 0, 0, 110)
    guideBox.Position = UDim2.new(0, 0, 0, 154)
    guideBox.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
    guideBox.BorderSizePixel = 0
    guideBox.Parent = autoPage
    Instance.new("UICorner", guideBox).CornerRadius = UDim.new(0, 6)


    local guideLabel = Instance.new("TextLabel")
    guideLabel.Size = UDim2.new(1, -16, 1, -12)
    guideLabel.Position = UDim2.new(0, 8, 0, 6)
    guideLabel.BackgroundTransparency = 1
    guideLabel.Text = "• Detecta e decodifica automaticamente os remotes de Hongmeng\n• Fase Weave: gira os selos conforme o ritmo\n• Fase Hold: alterna a direção das setas e reage imediatamente\n• Fase Trib: calcula o tempo e usa Ward contra raios automaticamente"
    guideLabel.TextColor3 = Color3.fromRGB(145, 160, 185)
    guideLabel.TextSize = 11
    guideLabel.Font = Enum.Font.SourceSans
    guideLabel.TextWrapped = true
    guideLabel.TextXAlignment = Enum.TextXAlignment.Left
    guideLabel.TextYAlignment = Enum.TextYAlignment.Top
    guideLabel.Parent = guideBox
end


-- 2. Wild Qi Page Controls
local refreshQiBtn = Instance.new("TextButton")
refreshQiBtn.Name = "RefreshQiBtn"
refreshQiBtn.Size = UDim2.new(0.48, -4, 0, 30)
refreshQiBtn.Position = UDim2.new(0, 0, 0, 4)
refreshQiBtn.BackgroundColor3 = Color3.fromRGB(40, 110, 180)
refreshQiBtn.Text = "🔄 Refresh List"
refreshQiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshQiBtn.TextSize = 12
refreshQiBtn.Font = Enum.Font.SourceSansBold
refreshQiBtn.Parent = wildQiPage
Instance.new("UICorner", refreshQiBtn).CornerRadius = UDim.new(0, 4)


local autoWarpQiBtn = Instance.new("TextButton")
autoWarpQiBtn.Name = "AutoWarpQiBtn"
autoWarpQiBtn.Size = UDim2.new(0.48, -4, 0, 30)
autoWarpQiBtn.Position = UDim2.new(0.52, 4, 0, 4)
autoWarpQiBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
autoWarpQiBtn.Text = "AUTO BEST: OFF"
autoWarpQiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoWarpQiBtn.TextSize = 12
autoWarpQiBtn.Font = Enum.Font.SourceSansBold
autoWarpQiBtn.Parent = wildQiPage
Instance.new("UICorner", autoWarpQiBtn).CornerRadius = UDim.new(0, 4)


local webhookBox = Instance.new("TextBox")
webhookBox.Name = "DiscordWebhook"
webhookBox.Size = UDim2.new(1, 0, 0, 28)
webhookBox.Position = UDim2.new(0, 0, 0, 40)
webhookBox.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
webhookBox.TextColor3 = Color3.fromRGB(240, 240, 240)
webhookBox.PlaceholderText = "Discord Webhook URL · pressione Enter"
webhookBox.ClearTextOnFocus = false
webhookBox.MultiLine = false
webhookBox.TextSize = 11
webhookBox.Font = Enum.Font.SourceSans
webhookBox.TextXAlignment = Enum.TextXAlignment.Left
webhookBox.Parent = wildQiPage
Instance.new("UICorner", webhookBox).CornerRadius = UDim.new(0, 4)


local webhookStatus = Instance.new("TextLabel")
webhookStatus.Size = UDim2.new(1, 0, 0, 20)
webhookStatus.Position = UDim2.new(0, 0, 0, 72)
webhookStatus.BackgroundTransparency = 1
webhookStatus.TextColor3 = Color3.fromRGB(170, 180, 200)
webhookStatus.TextSize = 11
webhookStatus.Font = Enum.Font.SourceSans
webhookStatus.Text = "Insira webhook para alertas dos graus 11 / 12 / 13"
webhookStatus.TextXAlignment = Enum.TextXAlignment.Left
webhookStatus.Parent = wildQiPage


local qiScrollList = Instance.new("ScrollingFrame")
qiScrollList.Name = "ScrollList"
qiScrollList.Size = UDim2.new(1, 0, 1, -100)
qiScrollList.Position = UDim2.new(0, 0, 0, 96)
qiScrollList.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
qiScrollList.BorderSizePixel = 0
qiScrollList.ScrollBarThickness = 4
qiScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
qiScrollList.Parent = wildQiPage
Instance.new("UICorner", qiScrollList).CornerRadius = UDim.new(0, 6)


local qiListLayout = Instance.new("UIListLayout")
qiListLayout.Parent = qiScrollList
qiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
qiListLayout.Padding = UDim.new(0, 4)


-- Sub-tab toggling
autoTabBtn.MouseButton1Click:Connect(function()
    autoPage.Visible = true
    wildQiPage.Visible = false
    autoTabBtn.BackgroundColor3 = Color3.fromRGB(72, 86, 147)
    autoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    wildQiTabBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
    wildQiTabBtn.TextColor3 = Color3.fromRGB(165, 179, 205)
end)


local scanAllWildQi, refreshQiButtons


wildQiTabBtn.MouseButton1Click:Connect(function()
    autoPage.Visible = false
    wildQiPage.Visible = true
    wildQiTabBtn.BackgroundColor3 = Color3.fromRGB(72, 86, 147)
    wildQiTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoTabBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
    autoTabBtn.TextColor3 = Color3.fromRGB(165, 179, 205)
    if refreshQiButtons then refreshQiButtons() end
end)


-- Scanner Logic
local lastQiScanTime = 0
local cachedQiList = {}
scanAllWildQi = function(force)
    local now = os.clock()
    if not force and (now - lastQiScanTime < 0.6) and #cachedQiList > 0 then
        return cachedQiList
    end
    lastQiScanTime = now
    local folder = Workspace:FindFirstChild("Murim_WildQi")
    local qiList = {}
    if not folder then
        cachedQiList = qiList
        return qiList
    end


    for _, desc in ipairs(folder:GetDescendants()) do
        if desc.Name == "WildQi" or desc.Name:find("WildQi") then
            local targetPart = desc:IsA("BasePart") and desc or (desc:IsA("Model") and (desc.PrimaryPart or desc:FindFirstChildWhichIsA("BasePart", true)))
            if targetPart then
                table.insert(qiList, {
                    Target = targetPart,
                    Grade = tonumber(desc:GetAttribute("Grade"))
                        or tonumber(targetPart:GetAttribute("Grade"))
                        or tonumber(desc.Parent:GetAttribute("Grade")) or 99,
                    Name = "WildQi (Direct Target)"
                })
            end
        elseif desc:IsA("BasePart") and desc.Name == "QiSpot" and desc:GetAttribute("Wild") == true then
            local grade = tonumber(desc:GetAttribute("Grade")) or 0
            table.insert(qiList, {
                Target = desc,
                Grade = grade,
                Name = GradeNames[grade] or ("QiSpot Grade " .. tostring(grade))
            })
        end
    end


    table.sort(qiList, function(a, b)
        return a.Grade > b.Grade
    end)


    cachedQiList = qiList
    return qiList
end


refreshQiButtons = function()
    if not qiScrollList or not qiScrollList.Parent then return end
    for _, child in ipairs(qiScrollList:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end


    local qiList = scanAllWildQi()


    if #qiList == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 40)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Text = "Nenhum ponto de Wild Qi encontrado no mapa agora"
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.TextSize = 12
        emptyLabel.Font = Enum.Font.SourceSans
        emptyLabel.Parent = qiScrollList
        qiScrollList.CanvasSize = UDim2.new(0, 0, 0, 50)
        return
    end


    for i, item in ipairs(qiList) do
        local btnColor = GradeColors[item.Grade] or GradeColors[0]


        local itemBtn = Instance.new("TextButton")
        itemBtn.Name = "QiItem_" .. tostring(i)
        itemBtn.Size = UDim2.new(1, -6, 0, 32)
        itemBtn.BackgroundColor3 = btnColor
        itemBtn.Text = string.format("[%d] %s - clique para teletransportar", i, item.Name)
        itemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemBtn.TextSize = 12
        itemBtn.Font = Enum.Font.SourceSansBold
        itemBtn.LayoutOrder = i
        itemBtn.Parent = qiScrollList


        local itemCorner = Instance.new("UICorner", itemBtn)
        itemCorner.CornerRadius = UDim.new(0, 4)


        itemBtn.MouseButton1Click:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and item.Target and item.Target.Parent then
                char.HumanoidRootPart.CFrame = (item.Target:IsA("Model") and item.Target:GetPivot() or item.Target.CFrame) + Vector3.new(0, 3, 0)
                itemBtn.Text = "✅ Teleporte realizado!"
                task.delay(1.5, function()
                    if itemBtn and itemBtn.Parent then
                        itemBtn.Text = string.format("[%d] %s - clique para teletransportar", i, item.Name)
                    end
                end)
            end
        end)
    end


    qiScrollList.CanvasSize = UDim2.new(0, 0, 0, (#qiList * 36) + 10)
end


do
-- Discord Webhook Task
local HttpService = game:GetService("HttpService")
local sendRequest = request or http_request or (syn and syn.request)
local notified = setmetatable({}, {__mode = "k"})
local webhookRevision = 0
local retryAt = 0


webhookBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local url = webhookBox.Text:match("^%s*(.-)%s*$")
    if url ~= "" and not url:match("^https://discord%.com/api/webhooks/%d+/[%w_-]+$")
        and not url:match("^https://discord%.com/api/v%d+/webhooks/%d+/[%w_-]+$") then
        webhookStatus.Text = "URL inválida · use uma URL de webhook do Discord"
        return
    end
    if url ~= "" and type(sendRequest) ~= "function" then
        webhookStatus.Text = "Este executor não possui envio HTTP"
        return
    end
    HongmengConfig.DiscordWebhook = url
    HongmengConfig.DiscordNotify = url ~= ""
    webhookRevision = webhookRevision + 1
    table.clear(notified)
    retryAt = 0
    webhookStatus.Text = url == "" and "Notificações do Discord desativadas" or "Notificações ativas · aguardando Wild Qi grau 11–13"
end)


task.spawn(function()
    while not destroyed do
        if HongmengConfig.DiscordNotify and HongmengConfig.DiscordWebhook ~= "" and time() >= retryAt then
            if type(sendRequest) ~= "function" then
                warn("[Wild Qi] Discord requires an executor with an HTTP request function.")
                break
            end
            local batch, lines, included = {}, {}, {}
            for _, item in ipairs(scanAllWildQi()) do
                local grade = item.Grade
                local target = item.Target
                if (grade == 11 or grade == 12 or grade == 13)
                    and notified[target] ~= grade and not included[target] then
                    included[target] = true
                    table.insert(batch, {target = target, grade = grade})
                    local position = target.Position
                    table.insert(lines, string.format("Wild Qi Grade %d · (%.0f, %.0f, %.0f)",
                        grade, position.X, position.Y, position.Z))
                    if #batch >= 10 then break end
                end
            end
            if #batch > 0 then
                table.insert(lines, "Place ID: " .. tostring(game.PlaceId))
                table.insert(lines, "Server ID: " .. game.JobId)
                local revision = webhookRevision
                local url = HongmengConfig.DiscordWebhook
                url = url .. (string.find(url, "?", 1, true) and "&" or "?") .. "wait=true"
                local ok, response = pcall(sendRequest, {
                    Url = url,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode({
                        content = table.concat(lines, "\n"),
                        allowed_mentions = {parse = {}}
                    })
                })
                if destroyed then return end
                if revision ~= webhookRevision then continue end
                local status = ok and type(response) == "table" and tonumber(response.StatusCode)
                if status and status >= 200 and status < 300 then
                    for _, entry in ipairs(batch) do
                        notified[entry.target] = entry.grade
                    end
                    retryAt = time() + 5
                    webhookStatus.Text = "Enviado ao Discord · " .. tostring(#batch) .. " pontos"
                else
                    local delay = 30
                    if status == 429 then
                        local decoded, body = pcall(HttpService.JSONDecode, HttpService, response.Body or "")
                        if decoded and type(body) == "table" then
                            delay = math.max(delay, tonumber(body.retry_after) or 0)
                        end
                    elseif status == 401 or status == 403 or status == 404 then
                        HongmengConfig.DiscordNotify = false
                        webhookStatus.Text = "Webhook rejeitado · informe outra URL e pressione Enter"
                    end
                    warn("[Wild Qi] Discord delivery failed; retrying later. HTTP " .. tostring(status))
                    retryAt = time() + delay
                    if HongmengConfig.DiscordNotify then
                        webhookStatus.Text = "Falha ao enviar · nova tentativa em " .. tostring(delay) .. " segundos"
                    end
                end
            end
        end
        task.wait(5)
    end
end)
end


-- Hongmeng Rules & Remote
local hmRules = nil
pcall(function()
    local murim = ReplicatedStorage:FindFirstChild("Murim") or ReplicatedStorage:WaitForChild("Murim", 5)
    local shared = murim and (murim:FindFirstChild("Shared") or murim:WaitForChild("Shared", 5))
    hmRules = shared and require(shared:WaitForChild("Hongmeng", 5))
end)
local opposite = {U = "D", D = "U", L = "R", R = "L"}
local wardWindowStart = (hmRules and hmRules.Trib and hmRules.Trib.window and hmRules.Trib.window[1]) or -0.15
local wardWindowEnd = (hmRules and hmRules.Trib and hmRules.Trib.window and hmRules.Trib.window[2]) or 0.15
local wardCooldown = (hmRules and hmRules.Trib and hmRules.Trib.wardCooldown) or 0.5
local wardTargetOffset = (wardWindowStart + wardWindowEnd) / 2
local hmPhase, hmWeave, hmSeq
local hmBolts = {}
local hmPos, hmSentPos = 1, 0
local hmLastSeal, hmLastWard = -math.huge, -math.huge
local hmInWindow = false
local lastWarpTime = 0
local wardStatus = "Aguardando sinal do raio"
local wardSent, wardMissed = 0, 0


local function resetHongmeng(nextPhase)
    hmPhase, hmWeave, hmSeq = nextPhase, nil, nil
    table.clear(hmBolts)
    hmInWindow = false
    hmLastSeal, hmLastWard = -math.huge, -math.huge
    wardSent, wardMissed = 0, 0
    wardStatus = "Aguardando sinal do raio"
end


local function receiveHongmeng(msg)
    if type(msg) ~= "table" then return end
    local op = msg.op
    if op == "start" then
        resetHongmeng("gather")
    elseif op == "result" or op == "seat" then
        resetHongmeng(nil)
    elseif op == "phase" and msg.phase ~= hmPhase then
        resetHongmeng(msg.phase)
    elseif op == "weave" then
        hmWeave, hmPhase = msg, "weave"
    elseif op == "weaveEnd" then
        hmWeave = nil
    elseif op == "seq" then
        hmSeq, hmPhase, hmPos, hmSentPos = msg, "hold", 1, 0
    elseif op == "seqKey" and hmSeq and type(msg.pos) == "number" then
        hmPos = math.max(hmPos, msg.pos + 1)
    elseif op == "seqDone" then
        hmSeq = nil
    elseif op == "warded" then
        wardStatus = "O jogo confirmou a defesa"
    elseif op == "unwarded" then
        wardMissed = wardMissed + 1
        wardStatus = "O jogo informou falha na defesa"
    elseif op == "trib" then
        hmPhase = "trib"
    elseif op == "bolt" and type(msg.land) == "number" then
        hmPhase = "trib"
        table.insert(hmBolts, msg.land)
        table.sort(hmBolts)
    end
end


local boundHongmengRemote = nil
local function bindHongmengRemote()
    local murim = ReplicatedStorage:FindFirstChild("Murim")
    local remotes = murim and murim:FindFirstChild("Remotes")
    local remote = remotes and remotes:FindFirstChild("Hongmeng")
    if remote == boundHongmengRemote then return end
    resetHongmeng(nil)
    boundHongmengRemote = remote
    if boundHongmengRemote and boundHongmengRemote:IsA("RemoteEvent") then
        externalConnections[#externalConnections + 1] = boundHongmengRemote.OnClientEvent:Connect(receiveHongmeng)
    end
end
bindHongmengRemote()
local remotesFolder = ReplicatedStorage:FindFirstChild("Murim") and ReplicatedStorage.Murim:FindFirstChild("Remotes")
if remotesFolder then
    externalConnections[#externalConnections + 1] = remotesFolder.ChildAdded:Connect(bindHongmengRemote)
    externalConnections[#externalConnections + 1] = remotesFolder.ChildRemoved:Connect(bindHongmengRemote)
end


local function setHongmengEnabled(enabled)
    HongmengConfig.Enabled = enabled
    if HongmengConfig.Enabled then
        toggleHBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 60)
        toggleHBtn.Text = "AUTO HONGMENG: ON"
        statusHLabel.Text = "Status: detectando a formação e enviando comandos..."
    else
        toggleHBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
        toggleHBtn.Text = "AUTO HONGMENG: OFF"
        statusHLabel.Text = "Status: desativado"
    end
end


toggleHBtn.Activated:Connect(function()
    setHongmengEnabled(not HongmengConfig.Enabled)
end)


searchHBtn.Activated:Connect(function()
    setHongmengEnabled(true)
end)


autoWarpQiBtn.MouseButton1Click:Connect(function()
    HongmengConfig.AutoTeleportWildQi = not HongmengConfig.AutoTeleportWildQi
    autoWarpQiBtn.BackgroundColor3 = HongmengConfig.AutoTeleportWildQi and Color3.fromRGB(40, 160, 60) or Color3.fromRGB(160, 40, 40)
    autoWarpQiBtn.Text = HongmengConfig.AutoTeleportWildQi and "AUTO BEST: ON" or "AUTO BEST: OFF"
end)


refreshQiBtn.MouseButton1Click:Connect(function()
    refreshQiButtons()
end)


-- Murim_WildQi folder listeners
task.spawn(function()
    local wildQiFolder = Workspace:WaitForChild("Murim_WildQi", 10)
    if wildQiFolder and not destroyed then
        externalConnections[#externalConnections + 1] = wildQiFolder.DescendantAdded:Connect(function(desc)
            if desc.Name == "WildQi" or (desc:IsA("BasePart") and desc.Name == "QiSpot") then
                task.defer(refreshQiButtons)
            end
        end)
        externalConnections[#externalConnections + 1] = wildQiFolder.DescendantRemoving:Connect(function(desc)
            if desc.Name == "WildQi" or (desc:IsA("BasePart") and desc.Name == "QiSpot") then
                task.defer(refreshQiButtons)
            end
        end)
    end
end)


-- Heartbeat loop for Hongmeng Solver and Auto Best Qi Teleport
externalConnections[#externalConnections + 1] = RunService.Heartbeat:Connect(function()
    if destroyed then return end
    local now = tick()


    -- 1. Teleporte automático para pontos de Wild Qi
    if HongmengConfig.AutoTeleportWildQi and (now - lastWarpTime >= 1.5) then
        lastWarpTime = now
        local qiList = scanAllWildQi()
        if qiList[1] and qiList[1].Target then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local targetCFrame = qiList[1].Target:IsA("Model") and qiList[1].Target:GetPivot() or qiList[1].Target.CFrame
                char.HumanoidRootPart.CFrame = targetCFrame + Vector3.new(0, 3, 0)
            end
        end
    end


    if not HongmengConfig.Enabled then return end
    if not boundHongmengRemote or not boundHongmengRemote:IsA("RemoteEvent") then
        if statusHLabel.Text ~= "Aguardando remote Hongmeng" then
            statusHLabel.Text = "Aguardando remote Hongmeng"
        end
        return
    end
    local t = Workspace:GetServerTimeNow()
    local newHText = hmPhase and ("Fase " .. hmPhase) or "Aguardando dados do ritual do jogo"
    if statusHLabel.Text ~= newHText then
        statusHLabel.Text = newHText
    end
    if hmPhase == "weave" and hmWeave and t < hmWeave.ends then
        local ring = hmWeave.rings[hmWeave.active]
        if not ring then return end
        local chaos = hmWeave.chaos
        local runeAngle = ring.base + ring.w * (t - ring.tBase) + ring.key
        local darkAngle = chaos.base + chaos.w * (t - chaos.tBase)
        local ready = gateDistance(runeAngle) <= 4 and gateDistance(darkAngle) > chaos.width / 2
        if ready and not hmInWindow and t - hmLastSeal >= 0.22 then
            boundHongmengRemote:FireServer({op = "seal", t = t})
            hmLastSeal, hmInWindow = t, true
        elseif not ready then
            hmInWindow = false
        end
    elseif hmPhase == "hold" and hmSeq and t < hmSeq.deadline and hmPos ~= hmSentPos then
        local key = hmSeq.keys[hmPos]
        if opposite[key] then
            local dir = hmSeq.inv[hmPos] and opposite[key] or key
            boundHongmengRemote:FireServer({op = "key", dir = dir})
            hmSentPos = hmPos
        end
    elseif hmPhase == "trib" then
        while hmBolts[1] and t > hmBolts[1] + wardWindowEnd do
            table.remove(hmBolts, 1)
            wardStatus = "Falha no tempo de envio · dados atrasados ou recarga ativa"
        end
        if hmBolts[1] then
            local remaining = hmBolts[1] + wardTargetOffset - t
            if remaining <= 0 then
                local cooldown = wardCooldown
                if t - hmLastWard >= cooldown then
                    boundHongmengRemote:FireServer({op = "ward", t = t})
                    hmLastWard = t
                    wardSent = wardSent + 1
                    table.remove(hmBolts, 1)
                    wardStatus = "Ward enviado · aguardando resultado do jogo"
                else
                    wardStatus = "Aguardando recarga"
                end
            else
                wardStatus = string.format("Enviando Ward em %.2f segundos", remaining)
            end
        end
        statusHLabel.Text = string.format("Trib · enviados %d · falhas %d\n%s", wardSent, wardMissed, wardStatus)
    end
end)
end


--------------------------------------------------------------------------------
-- 🎃 Halloween Page (Index 8) - The Hungry Ghost Gate Auto Raid
--------------------------------------------------------------------------------
do
local halloweenPage = makePage("Halloween", 8, "🎃 Halloween")
newHeading(halloweenPage, "🎃 The Hungry Ghost Gate • Auto Raid")


local hallowBody = Instance.new("ScrollingFrame")
hallowBody.Name = "HallowContent"
hallowBody.Position = UDim2.new(0, 0, 0, 44)
hallowBody.Size = UDim2.new(1, 0, 1, -56)
hallowBody.BackgroundTransparency = 1
hallowBody.BorderSizePixel = 0
hallowBody.ScrollBarThickness = 4
hallowBody.CanvasSize = UDim2.new(0, 0, 0, 500)
hallowBody.Parent = halloweenPage


toggleHallowRaidBtn = Instance.new("TextButton")
toggleHallowRaidBtn.Name = "ToggleHallowRaidBtn"
toggleHallowRaidBtn.Font = Enum.Font.SourceSansBold
toggleHallowRaidBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHallowRaidBtn.TextSize = 13
toggleHallowRaidBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 60)
toggleHallowRaidBtn.Text = "🎃 Raid automático de Hungry Ghost Gate (Auto: OFF)"
Instance.new("UICorner", toggleHallowRaidBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleHallowRaidBtn, hallowBody, 0, 12, 0, 1, -24)


local diffLabel = Instance.new("TextLabel")
diffLabel.Size = UDim2.new(1, -24, 0, 22)
diffLabel.Position = UDim2.new(0, 12, 0, 44)
diffLabel.BackgroundTransparency = 1
diffLabel.Text = "🎯 Selecione a dificuldade (Difficulty):"
diffLabel.TextColor3 = Color3.fromRGB(210, 220, 240)
diffLabel.Font = Enum.Font.SourceSansBold
diffLabel.TextSize = 13
diffLabel.TextXAlignment = Enum.TextXAlignment.Left
diffLabel.Parent = hallowBody


local diffBtns = {}
local diffNames = {"Normal", "Hard", "Hardcore"}
local function updateDiffUI()
    for _, dName in ipairs(diffNames) do
        local btn = diffBtns[dName]
        if btn then
            if hallowDifficulty == dName then
                btn.BackgroundColor3 = Color3.fromRGB(75, 95, 180)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                btn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
                btn.TextColor3 = Color3.fromRGB(170, 180, 200)
            end
        end
    end
end


for i, dName in ipairs(diffNames) do
    local btn = Instance.new("TextButton")
    btn.Name = "Diff_" .. dName
    btn.Size = UDim2.new(1 / 3, -8, 0, 30)
    btn.Position = UDim2.new((i - 1) / 3, 12 + (i - 1) * 4, 0, 70)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Text = dName
    btn.Parent = hallowBody
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    diffBtns[dName] = btn
    btn.MouseButton1Click:Connect(function()
        hallowDifficulty = dName
        MURIM_TRACE.add("INFO", "Dificuldade", "Selecionada no painel: " .. dName)
        updateDiffUI()
    end)
end
updateDiffUI()


local toggleHallowRepeatBtn = Instance.new("TextButton")
toggleHallowRepeatBtn.Font = Enum.Font.SourceSansBold
toggleHallowRepeatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHallowRepeatBtn.TextSize = 13
toggleHallowRepeatBtn.BackgroundColor3 = Color3.fromRGB(45, 110, 70)
toggleHallowRepeatBtn.Text = "🔄 Repetir raid ao concluir: Ligado (ON)"
Instance.new("UICorner", toggleHallowRepeatBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleHallowRepeatBtn, hallowBody, 0, 12, 108, 1, -24)


toggleHallowRepeatBtn.MouseButton1Click:Connect(function()
    isHallowAutoRepeat = not isHallowAutoRepeat
    if isHallowAutoRepeat then
        toggleHallowRepeatBtn.Text = "🔄 Repetir raid ao concluir: Ligado (ON)"
        toggleHallowRepeatBtn.BackgroundColor3 = Color3.fromRGB(45, 110, 70)
    else
        toggleHallowRepeatBtn.Text = "🔄 Repetir raid ao concluir: Desligado (OFF)"
        toggleHallowRepeatBtn.BackgroundColor3 = Color3.fromRGB(80, 55, 65)
    end
end)


local toggleHallowSeenBtn = Instance.new("TextButton")
toggleHallowSeenBtn.Font = Enum.Font.SourceSansBold
toggleHallowSeenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHallowSeenBtn.TextSize = 13
toggleHallowSeenBtn.BackgroundColor3 = Color3.fromRGB(60, 85, 140)
toggleHallowSeenBtn.Text = "👁️ Pacificar fantasmas automaticamente (Auto Pacify / Seen: ON)"
Instance.new("UICorner", toggleHallowSeenBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleHallowSeenBtn, hallowBody, 0, 12, 146, 1, -24)


toggleHallowSeenBtn.MouseButton1Click:Connect(function()
    isHallowPacifySeen = not isHallowPacifySeen
    if isHallowPacifySeen then
        toggleHallowSeenBtn.Text = "👁️ Pacificar fantasmas automaticamente (Auto Pacify / Seen: ON)"
        toggleHallowSeenBtn.BackgroundColor3 = Color3.fromRGB(60, 85, 140)
    else
        toggleHallowSeenBtn.Text = "👁️ Pacificar fantasmas automaticamente (Auto Pacify / Seen: OFF)"
        toggleHallowSeenBtn.BackgroundColor3 = Color3.fromRGB(75, 60, 70)
    end
end)


local tpHallowGateBtn = Instance.new("TextButton")
tpHallowGateBtn.Font = Enum.Font.SourceSansBold
tpHallowGateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpHallowGateBtn.TextSize = 13
tpHallowGateBtn.BackgroundColor3 = Color3.fromRGB(110, 60, 150)
tpHallowGateBtn.Text = "⚡ Teleporte até o livro de registro (Guest Ledger)"
Instance.new("UICorner", tpHallowGateBtn).CornerRadius = UDim.new(0, 6)
placeButton(tpHallowGateBtn, hallowBody, 0, 12, 184, 1, -24)


tpHallowGateBtn.MouseButton1Click:Connect(function()
    if hubUI.isBusy and hubUI.isBusy() then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local _, ledgerPart = findGuestLedger()
        if ledgerPart then
            hrp.CFrame = ledgerPart.CFrame * CFrame.new(0, 2, -4) * CFrame.Angles(0, math.rad(180), 0)
        else
            hrp.CFrame = HALLOW_GATE_CFRAME
            task.wait(0.4)
            local _, lp2 = findGuestLedger()
            if lp2 then
                hrp.CFrame = lp2.CFrame * CFrame.new(0, 2, -4) * CFrame.Angles(0, math.rad(180), 0)
            end
        end
        tpHallowGateBtn.Text = "⚡ Teleporte realizado!"
        task.wait(1)
        if not destroyed and tpHallowGateBtn.Parent then
            tpHallowGateBtn.Text = "⚡ Teleporte até o livro de registro (Guest Ledger)"
        end
    end
end)


local hallowPosBtn = Instance.new("TextButton")
hallowPosBtn.Name = "HallowPosToggle"
hallowPosBtn.Font = Enum.Font.SourceSansBold
hallowPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hallowPosBtn.TextSize = 13
Instance.new("UICorner", hallowPosBtn).CornerRadius = UDim.new(0, 6)
placeButton(hallowPosBtn, hallowBody, 0, 12, 226, 1, -24)


local function updateHallowPosBtn()
    if farmPositionMode == "Above" then
        hallowPosBtn.Text = "🛸 Posição para atacar fantasmas: Flutuando acima (Above) ⬇️ olhando para o chão"
        hallowPosBtn.BackgroundColor3 = Color3.fromRGB(35, 125, 185)
    else
        hallowPosBtn.Text = "⛏️ Posição para atacar fantasmas: Abaixo do solo (Under) ⬆️ olhando para cima"
        hallowPosBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 40)
    end
end
updateHallowPosBtn()


hallowPosBtn.MouseButton1Click:Connect(function()
    if farmPositionMode == "Above" then
        updateFarmSettings("Under", farmDistance)
    else
        updateFarmSettings("Above", farmDistance)
    end
    updateHallowPosBtn()
end)


local prevDisplayCb = updateFarmPositionDisplay
updateFarmPositionDisplay = function()
    if prevDisplayCb then pcall(prevDisplayCb) end
    pcall(updateHallowPosBtn)
end


local hallowStatusBox = Instance.new("Frame")
hallowStatusBox.Name = "StatusBox"
hallowStatusBox.Size = UDim2.new(1, -24, 0, 52)
hallowStatusBox.Position = UDim2.new(0, 12, 0, 268)
hallowStatusBox.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
hallowStatusBox.BorderSizePixel = 0
hallowStatusBox.Parent = hallowBody
Instance.new("UICorner", hallowStatusBox).CornerRadius = UDim.new(0, 6)


hallowStatusLabel = Instance.new("TextLabel")
hallowStatusLabel.Name = "StatusLabel"
hallowStatusLabel.Size = UDim2.new(1, -16, 1, -8)
hallowStatusLabel.Position = UDim2.new(0, 8, 0, 4)
hallowStatusLabel.BackgroundTransparency = 1
hallowStatusLabel.Text = "💤 Automação de Halloween desativada"
hallowStatusLabel.TextColor3 = Color3.fromRGB(240, 200, 90)
hallowStatusLabel.Font = Enum.Font.SourceSansBold
hallowStatusLabel.TextSize = 13
hallowStatusLabel.TextWrapped = true
hallowStatusLabel.Parent = hallowStatusBox


local hallowInfo = Instance.new("TextLabel")
hallowInfo.Size = UDim2.new(1, -24, 0, 140)
hallowInfo.Position = UDim2.new(0, 12, 0, 328)
hallowInfo.BackgroundColor3 = Color3.fromRGB(28, 33, 46)
hallowInfo.TextColor3 = Color3.fromRGB(180, 195, 215)
hallowInfo.Font = Enum.Font.SourceSans
hallowInfo.TextSize = 12
hallowInfo.TextXAlignment = Enum.TextXAlignment.Left
hallowInfo.TextYAlignment = Enum.TextYAlignment.Top
hallowInfo.TextWrapped = true
hallowInfo.Text = "📌 Como funciona o sistema automático:\n"
    .. "• Escolha acima do inimigo (Above) ou abaixo do chão (Under)\n"
    .. "• No modo Above, fica de bruços olhando para o chão; evita superfícies e ataques dos fantasmas\n"
    .. "• Expande a hitbox dos fantasmas para 60 studs em todas as salas\n"
    .. "• Ignora automaticamente fantasmas invulneráveis (The Faceless Watchman & Red Sedan)\n"
    .. "• Ataca o chefe da sala 6 (Cerberus [Lv.90]) e o chefe final da sala 9 (Matriarch [Lv.110])\n"
    .. "• Colisao do personagem preservada na raid para evitar quedas atraves do chao"
hallowInfo.Parent = hallowBody
Instance.new("UICorner", hallowInfo).CornerRadius = UDim.new(0, 6)
local pad = Instance.new("UIPadding", hallowInfo)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.PaddingTop = UDim.new(0, 8)


toggleHallowRaidBtn.MouseButton1Click:Connect(function()
    MURIM_TRACE.add("ACAO", "Halloween", "Botao Auto Raid pressionado.")
    if not isAutoHallowRaid and isFarming then
        if hallowStatusLabel then hallowStatusLabel.Text = "⚠️ Pare o farm de monstros antes de iniciar Halloween." end
        return
    end
    isAutoHallowRaid = not isAutoHallowRaid
    if not isAutoHallowRaid then MURIM_A04.cancelHold(); MURIM_A04.stopRun(); MURIM_LATE.stopWalk() end
    MURIM_TRACE.active = isAutoHallowRaid
    MURIM_TRACE.stageTo(isAutoHallowRaid and ("Ativado: " .. hallowDifficulty) or "Desativado")
    if isAutoHallowRaid then
        HallowEntryState.lastPromptAt = 0
        HallowEntryState.promptAttempts = 0
        HallowEntryState.lastChoiceAt = 0
        HallowEntryState.choiceAttempts = 0
        HallowEntryState.awaitingEntryUntil = 0
        HallowEntryState.lastSeenDialogAt = 0
        HallowEntryState.manualChoiceWarned = false
        HallowEntryState.wasInsideRaid = false
        HallowEntryState.verifiedRoomIndex = nil
        HallowEntryState.verifiedRoomAt = 0
        HallowEntryState.sawCombatInRoom = false
        HallowEntryState.lastRaidSnapshotAt = 0
        HallowEntryState.lastRaidWarningAt = 0
        HallowEntryState.lastRoomScanAt = 0
        HallowEntryState.lastRoomScanReason = "ainda nao inspecionado"
        HallowEntryState.fallSince = 0
        HallowEntryState.lastFallWarnAt = 0
        HallowEntryState.lastGroundedY = nil
        currentRaidRoomIndex = 1
        MURIM_RAID_DEFENSE.reset()
        MURIM_A02.reset()
        lastRaidCombatTime = os.clock()
        toggleHallowRaidBtn.Text = "🎃 Raid automático de Hungry Ghost Gate (Auto: ON)"
        toggleHallowRaidBtn.BackgroundColor3 = Color3.fromRGB(35, 140, 75)
        hallowStatusLabel.Text = "🚀 Iniciando raid automático Hungry Ghost Gate..."
    else
        MURIM_RAID_DEFENSE.reset()
        HallowEntryState.wasInsideRaid = false
        HallowEntryState.verifiedRoomIndex = nil
        HallowEntryState.sawCombatInRoom = false
        currentRaidRoomIndex = 1
        toggleHallowRaidBtn.Text = "🎃 Raid automático de Hungry Ghost Gate (Auto: OFF)"
        toggleHallowRaidBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 60)
        hallowStatusLabel.Text = "💤 Raid automático Hungry Ghost Gate desativado"
    end
end)
end


local settingsPage = makePage("Settings", 9, "Configurações")
newHeading(settingsPage, "Configurações do farm")
local settingsBody = Instance.new("ScrollingFrame")
settingsBody.Name = "SettingsContent"
settingsBody.Position = UDim2.new(0, 0, 0, 44)
settingsBody.Size = UDim2.new(1, 0, 1, -56)
settingsBody.BackgroundTransparency = 1
settingsBody.BorderSizePixel = 0
settingsBody.ScrollBarThickness = 4
settingsBody.CanvasSize = UDim2.new(0, 0, 0, 480)
settingsBody.Parent = settingsPage
placeButton(togglePositionModeBtn, settingsBody, 0, 12, 0, 1, -24)
distLabel.Parent = settingsBody
distLabel.Position = UDim2.new(0, 12, 0, 36)
distLabel.Size = UDim2.new(1, -24, 0, 24)
distLabel.TextXAlignment = Enum.TextXAlignment.Left
distLabel.TextSize = 13
placeButton(addDistBtn, settingsBody, 0, 12, 64, 0.5, -16)
placeButton(subDistBtn, settingsBody, 0.5, 4, 64, 0.5, -16)
placeButton(toggleHitboxBtn, settingsBody, 0, 12, 106, 1, -24)
placeButton(toggleLootBtn, settingsBody, 0, 12, 148, 1, -24)


local toggleLootFilterBtn = Instance.new("TextButton")
toggleLootFilterBtn.Name = "LootFilterToggle"
toggleLootFilterBtn.Font = Enum.Font.SourceSansBold
toggleLootFilterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleLootFilterBtn.TextSize = 13
Instance.new("UICorner", toggleLootFilterBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleLootFilterBtn, settingsBody, 0, 12, 190, 1, -24)
local function displayLootFilter()
    local opt = LOOT_FILTER_OPTIONS[currentLootFilterIdx]
    toggleLootFilterBtn.Text = "🎁 Filtro de itens: " .. (opt and opt.text or "Todos (All)")
    toggleLootFilterBtn.BackgroundColor3 = currentLootFilterIdx > 1 and Color3.fromRGB(40, 140, 80) or Color3.fromRGB(90, 60, 110)
end
toggleLootFilterBtn.MouseButton1Click:Connect(function()
    currentLootFilterIdx = (currentLootFilterIdx % #LOOT_FILTER_OPTIONS) + 1
    displayLootFilter()
end)
displayLootFilter()


local toggleParryBtn = Instance.new("TextButton")
toggleParryBtn.Name = "AutoParryToggle"
toggleParryBtn.Font = Enum.Font.SourceSansBold
toggleParryBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleParryBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleParryBtn, settingsBody, 0, 12, 238, 1, -24)
local function displayParry()
    toggleParryBtn.Text = isAutoParry and "🛡️ Defesa automática (Auto Parry: ON)" or "🛡️ Defesa automática (Auto Parry: OFF)"
    toggleParryBtn.BackgroundColor3 = isAutoParry and Color3.fromRGB(40, 110, 150) or Color3.fromRGB(90, 60, 110)
end
toggleParryBtn.MouseButton1Click:Connect(function()
    isAutoParry = not isAutoParry
    if not isAutoParry and isParrying then
        combatRemote = combatRemote or findCombatRemote()
        if combatRemote then pcall(function() combatRemote:FireServer("ParryUp", nil) end) end
        isParrying = false
    end
    displayParry()
end)
displayParry()


local toggleArtifactBtn = Instance.new("TextButton")
toggleArtifactBtn.Name = "AutoArtifactToggle"
toggleArtifactBtn.Font = Enum.Font.SourceSansBold
toggleArtifactBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleArtifactBtn).CornerRadius = UDim.new(0, 6)
placeButton(toggleArtifactBtn, settingsBody, 0, 12, 286, 1, -24)
local function displayArtifact()
    toggleArtifactBtn.Text = isAutoArtifact and "📿 Uso automático de artefato (Auto Artifact: ON)" or "📿 Uso automático de artefato (Auto Artifact: OFF)"
    toggleArtifactBtn.BackgroundColor3 = isAutoArtifact and Color3.fromRGB(40, 110, 150) or Color3.fromRGB(90, 60, 110)
end
toggleArtifactBtn.MouseButton1Click:Connect(function()
    isAutoArtifact = not isAutoArtifact
    displayArtifact()
end)
displayArtifact()


-- Anti-idle input approach adapted from Infinite Yield's antiafk command:
-- https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source
-- Keep other scripts' Idled connections intact; own connection is cleaned up by cleanup().
local antiAFKEnabled = true
local antiAFKButton = Instance.new("TextButton")
antiAFKButton.Name = "AntiAFKToggle"
antiAFKButton.Font = Enum.Font.SourceSansBold
antiAFKButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", antiAFKButton).CornerRadius = UDim.new(0, 6)
placeButton(antiAFKButton, settingsBody, 0, 12, 334, 1, -24)
local function displayAntiAFK()
    antiAFKButton.Text = antiAFKEnabled and "Prevenção de AFK (Anti-AFK: ON)" or "Prevenção de AFK (Anti-AFK: OFF)"
    antiAFKButton.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(40, 110, 150) or Color3.fromRGB(90, 60, 110)
end
antiAFKButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    displayAntiAFK()
end)
displayAntiAFK()
externalConnections[#externalConnections + 1] = player.Idled:Connect(function()
    if destroyed or not antiAFKEnabled or (hubUI.isBusy and hubUI.isBusy()) then return end
    -- No polling loop; send a press/release only when Roblox reports idle.
    local ok, message = pcall(function()
        for _, pressed in ipairs({true, false}) do
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, pressed, game, 0)
        end
    end)
    if not ok then
        -- Attempt release even if the initial input failed.
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end)
        antiAFKEnabled = false
        displayAntiAFK()
        antiAFKButton.Text = "Anti-AFK: o executor não permite enviar entradas"
        warn("[Murim Anti-AFK] " .. tostring(message))
    end
end)
placeButton(destroyBtn, settingsBody, 0, 12, 382, 1, -24)


-- Keep Start/Stop accessible from every page.
local footer = Instance.new("Frame")
footer.Name = "PersistentControls"
footer.Position = UDim2.new(0, 12, 1, -50)
footer.Size = UDim2.new(1, -24, 0, 38)
footer.BackgroundTransparency = 1
footer.Parent = mainFrame
placeButton(startBtn, footer, 0, 0, 0, 0.5, -4)
placeButton(stopBtn, footer, 0.5, 4, 0, 0.5, -4)
-- PTBR MOBILE: reflow dos controles e canvas para permitir arrastar no celular.
local function mobileButton(btn, y, h)
    if not btn then return end
    btn.Position = UDim2.new(btn.Position.X.Scale, btn.Position.X.Offset, 0, y)
    btn.Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, 0, h or 46)
    btn.TextWrapped = true
    btn.TextScaled = false
    btn.TextSize = 13
    btn.AutoButtonColor = true
end
mobileButton(togglePositionModeBtn, 0, 52)
distLabel.Position = UDim2.new(0, 12, 0, 57)
distLabel.Size = UDim2.new(1, -24, 0, 27)
mobileButton(addDistBtn, 90, 44)
mobileButton(subDistBtn, 90, 44)
mobileButton(toggleHitboxBtn, 143, 46)
mobileButton(toggleLootBtn, 196, 46)
mobileButton(toggleLootFilterBtn, 249, 46)
mobileButton(toggleParryBtn, 302, 46)
mobileButton(toggleArtifactBtn, 355, 46)
mobileButton(antiAFKButton, 408, 46)
mobileButton(destroyBtn, 461, 46)
settingsBody.CanvasSize = UDim2.fromOffset(0, 526)
settingsBody.ScrollingDirection = Enum.ScrollingDirection.Y
settingsBody.ScrollingEnabled = true
settingsBody.Active = true
settingsBody.ScrollBarThickness = 9
settingsBody.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable

-- O raid Halloween tinha textos grandes e componentes com apenas 36 px de altura.
local hallowScroll = pages[8] and pages[8]:FindFirstChild("HallowContent")
if hallowScroll then
    hallowScroll.ScrollingEnabled = true
    hallowScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    hallowScroll.Active = true
    hallowScroll.ScrollBarThickness = 9
    hallowScroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
    local layoutPositions = {
        ToggleHallowRaidBtn = {0, 52},
    }
    for _, obj in ipairs(hallowScroll:GetChildren()) do
        if obj:IsA("TextButton") then
            obj.TextWrapped = true
            obj.TextSize = 13
            if obj.Size.Y.Offset < 42 then
                obj.Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, 42)
            end
        end
    end
    -- Reflow por linhas: preserva os três botões de dificuldade lado a lado.
    -- Para textos longos, amplia a altura em vez de sobrepor outros controles.
    local rows = {}
    for _, obj in ipairs(hallowScroll:GetChildren()) do
        if obj:IsA("GuiObject") and obj.Visible then
            if obj:IsA("TextButton") then
                obj.TextWrapped = true
                obj.TextSize = 13
                obj.Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, math.max(46, obj.Size.Y.Offset))
            elseif obj:IsA("TextLabel") and obj.TextWrapped then
                obj.Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, math.max(200, obj.Size.Y.Offset))
            elseif obj:IsA("Frame") then
                obj.Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, math.max(78, obj.Size.Y.Offset))
            end
            local oldY = obj.Position.Y.Offset
            if not rows[oldY] then rows[oldY] = {} end
            table.insert(rows[oldY], obj)
        end
    end
    local keys = {}
    for y in pairs(rows) do table.insert(keys, y) end
    table.sort(keys)
    local cursor = 0
    for _, originalY in ipairs(keys) do
        local maxH = 0
        for _, obj in ipairs(rows[originalY]) do
            obj.Position = UDim2.new(obj.Position.X.Scale, obj.Position.X.Offset, 0, cursor)
            maxH = math.max(maxH, obj.Size.Y.Offset)
        end
        cursor = cursor + maxH + 10
    end
    hallowScroll.CanvasSize = UDim2.fromOffset(0, cursor + 16)
end

local function updateMobileViewport()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local v = cam.ViewportSize
    if v.X <= 0 or v.Y <= 0 then return end
    local w = math.min(470, math.max(210, v.X - 16))
    local h = math.min(710, math.max(240, v.Y - 36))
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Size = UDim2.fromOffset(w, h)
    mainFrame.Position = UDim2.fromScale(0.5, 0.5)
    local mobile = v.X < 700 or v.Y < 700
    toggleBtn.Size = UDim2.fromOffset(mobile and 112 or 160, 42)
    toggleBtn.Position = UDim2.fromOffset(9, math.max(16, math.floor(v.Y * .48)))
    for _, list in ipairs({scrollFrame, tpScrollFrame}) do
        list.ScrollBarThickness = mobile and 10 or 6
        list.Active = true
        list.ScrollingEnabled = true
        list.ScrollingDirection = Enum.ScrollingDirection.Y
        list.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
    end
    local bs = pages[2] and pages[2]:FindFirstChild("BossScrollFrame")
    if bs then bs.Active = true; bs.ScrollBarThickness = mobile and 10 or 6 end
end
updateMobileViewport()
local cam = Workspace.CurrentCamera
if cam then
    externalConnections[#externalConnections+1] = cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateMobileViewport)
end

hubUI.makePage = makePage
hubUI.showPage = showPage
hubUI.settingsBody = settingsBody
showPage(1)
end




local function restoreHitboxes()
    for part, props in pairs(originalHitboxes) do
        if part.Parent then
            pcall(function()
                part.Size = props.Size
                part.Transparency = props.Transparency
                part.CanCollide = props.CanCollide
                part.Material = props.Material
            end)
        end
        originalHitboxes[part] = nil
    end
end




local function applyHitboxToNPC(npc)
        if not isHitboxExpanded and not isAutoHallowRaid then return end
    if not npc or not npc:IsA("Model") or isFriendlyOrTalkable(npc) then return end


    if checkIsBossName(npc.Name) or (isHallowFoe and isHallowFoe(npc)) then
        revealInvisibleNPC(npc)
    end


        local hrp = getNPCRootPart(npc)
        if hrp then
        if hrp.Size == HITBOX_SIZE and hrp.Transparency == HITBOX_TRANSPARENCY and hrp.CanCollide == false then
            return
        end
                pcall(function()
                        if not originalHitboxes[hrp] then
                originalHitboxes[hrp] = {
                    Size = hrp.Size, Transparency = hrp.Transparency,
                    CanCollide = hrp.CanCollide, Material = hrp.Material,
                }
            end
            hrp.Size = HITBOX_SIZE
                        hrp.Transparency = HITBOX_TRANSPARENCY
                        hrp.CanCollide = false
                        hrp.Material = Enum.Material.ForceField
                end)
        end
end


local function updateAllHitboxes()
        local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
        if not npcsFolder then return end


        for _, npc in ipairs(npcsFolder:GetChildren()) do
                applyHitboxToNPC(npc)
        end
end


local function interactWithDrop(dropItem)
        if not dropItem or not dropItem.Parent then return end


        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        local hrp = character.HumanoidRootPart


        local targetPart = dropItem:IsA("BasePart") and dropItem or (dropItem:IsA("Model") and dropItem.PrimaryPart) or dropItem:FindFirstChildWhichIsA("BasePart", true)
        if not targetPart then return end


        hrp.CFrame = targetPart.CFrame * CFrame.new(0, 2, 0)
        task.wait(0.05)
    if destroyed or (not isFarming and not isAutoHallowRaid) or not dropItem.Parent or (hubUI.isBusy and hubUI.isBusy()) then return end


    if typeof(firetouchinterest) == "function" then
        pcall(function()
            firetouchinterest(hrp, targetPart, 0)
            task.wait(0.01)
            firetouchinterest(hrp, targetPart, 1)
        end)
    end


    local descendants = dropItem:GetDescendants()
    local hadPrompt = false
        for _, desc in ipairs(descendants) do
        if destroyed or (not isFarming and not isAutoHallowRaid) or (hubUI.isBusy and hubUI.isBusy()) then return end
                if desc:IsA("TouchTransmitter") or desc.Name == "TouchInterest" then
                        if typeof(firetouchinterest) == "function" then
                                pcall(function()
                                        firetouchinterest(hrp, desc.Parent, 0)
                                        task.wait(0.01)
                                        firetouchinterest(hrp, desc.Parent, 1)
                                end)
                        end
                elseif desc:IsA("ProximityPrompt") and desc.Enabled then
            hadPrompt = true
                        if typeof(fireproximityprompt) == "function" then
                                pcall(function() fireproximityprompt(desc) end)
                        else
                                pcall(function()
                                    desc:InputHoldBegin()
                                    task.wait(math.max(0.1, desc.HoldDuration or 0) + 0.1)
                                    desc:InputHoldEnd()
                                end)
                        end
                        task.wait(0.1)
                end
        end


    if isChest(dropItem) then
        chestAttempts[dropItem] = (chestAttempts[dropItem] or 0) + 1
        if not hadPrompt or chestAttempts[dropItem] >= 4 then
            openedChests[dropItem] = os.clock() + 20
        else
            openedChests[dropItem] = os.clock() + 1.2
        end
    end
end


local function findBossInNPCs(key, data)
    local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
    if not npcsFolder then return nil end
    local targetName = (data.Name or key):lower()
    local keyLower = key:lower()


    -- 1. Check exact or substring match
    for _, npc in ipairs(npcsFolder:GetChildren()) do
        if isAlive(npc) then
            local nName = npc.Name:lower()
            if nName == targetName or nName:find(targetName, 1, true) or targetName:find(nName, 1, true)
               or nName:find(keyLower, 1, true) or keyLower:find(nName, 1, true) then
                return npc
            end
        end
    end


    -- 2. Check aliases from KNOWN_BOSSES
    for _, info in ipairs(KNOWN_BOSSES) do
        if info.Key == key or info.Name == key or (data and (info.Key == data.Name or info.Name == data.Name)) then
            for _, alias in ipairs(info.Alias or {}) do
                local aLow = alias:lower()
                for _, npc in ipairs(npcsFolder:GetChildren()) do
                    if isAlive(npc) and npc.Name:lower():find(aLow, 1, true) then
                        return npc
                    end
                end
            end
        end
    end


    -- 2. Word token match (e.g. "White-Jade Dragon" matches "White-Jade" or "Dragon")
    local words = {}
    for w in targetName:gmatch("[%a%d]+") do
        if #w >= 3 and w ~= "the" and w ~= "boss" then
            table.insert(words, w)
        end
    end
    for w in keyLower:gmatch("[%a%d]+") do
        if #w >= 3 and w ~= "the" and w ~= "boss" then
            table.insert(words, w)
        end
    end


    if #words > 0 then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if isAlive(npc) then
                local nName = npc.Name:lower()
                for _, word in ipairs(words) do
                    if nName:find(word, 1, true) then
                        return npc
                    end
                end
            end
        end
    end


    return nil
end


local function getBossChest()
    local searchContainers = {}
    local dropsFolder = Workspace:FindFirstChild("Murim_Drops")
    if dropsFolder then searchContainers[#searchContainers + 1] = dropsFolder end
    for _, name in ipairs({"Murim_Chests", "Chests", "Drops", "Debris"}) do
        local f = Workspace:FindFirstChild(name)
        if f then searchContainers[#searchContainers + 1] = f end
    end
    searchContainers[#searchContainers + 1] = Workspace


    local bossDeathPos = lastBossCFrame and lastBossCFrame.Position


    for _, container in ipairs(searchContainers) do
        for _, obj in ipairs(container:GetChildren()) do
            if obj and obj.Parent then
                local objName = obj.Name
                local isBossNamed = (objName == "LootChest_Boss")
                    or (objName:find("LootChest_Boss", 1, true) ~= nil)
                    or (objName:find("BossChest", 1, true) ~= nil)
                    or (objName:find("LootChest", 1, true) ~= nil and objName:find("Boss", 1, true) ~= nil)
                    or (objName:find("Chest", 1, true) ~= nil and objName:find("Boss", 1, true) ~= nil)


                local part = obj:IsA("BasePart") and obj
                    or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)))


                local isNearBoss = false
                if part and bossDeathPos and isChest(obj) then
                    local dist = (part.Position - bossDeathPos).Magnitude
                    if dist <= 120 then
                        isNearBoss = true
                    end
                end


                if (isBossNamed or isNearBoss) and part then
                    local cooldown = openedChests[obj]
                    if not cooldown or os.clock() >= cooldown then
                        local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                        return obj, part, prompt
                    end
                end
            end
        end
    end
    return nil, nil, nil
end


local activeBossProbeCount = 0
local function chooseBossTarget()
    if not isAutoFarmBoss then return nil, false, nil end
    local now = os.clock()


    -- Check if we currently have an active boss
    if activeBossTarget then
        local data = bossCache[activeBossTarget.Key]
        if data and selectedBossNames[activeBossTarget.Key] then
            local npc = findBossInNPCs(activeBossTarget.Key, data)
            if npc and isAlive(npc) then
                revealInvisibleNPC(npc)
                local part = getNPCRootPart(npc)
                if part then
                    lastBossCFrame = part.CFrame
                    return part.CFrame, true, npc
                end
            end
        end
        -- Boss died or despawned!
        if lastBossCFrame then
            bossLootWaitUntil = os.clock() + 6.0
        end
        activeBossTarget = nil
        cachedTarget = nil
        targetScanAt = 0
        activeBossProbeCount = 0
    end


    -- Find any selected boss that is spawned
    for key, isSelected in pairs(selectedBossNames) do
        if isSelected then
            local data = bossCache[key]
            if data and data.TimeText and (data.TimeText:find("apareceu") or data.TimeText:find("เกิดแล้ว")) then
                local probeTime = bossProbeAt[key] or 0
                if now >= probeTime then
                    local npc = findBossInNPCs(key, data)
                    if npc and isAlive(npc) then
                        revealInvisibleNPC(npc)
                        activeBossTarget = { Key = key, NPC = npc, Name = data.Name }
                        activeBossProbeCount = 0
                        local part = getNPCRootPart(npc)
                        if part then
                            return part.CFrame, true, npc
                        end
                    elseif data.CFrame then
                        return data.CFrame, false, nil
                    end
                end
            end
        end
    end


    return nil, false, nil
end


local function getHighestLevelTarget()
    local now = os.clock()
    if now < targetScanAt then
        if cachedTarget and isAlive(cachedTarget) and getNPCLevel(cachedTarget) > 0 then
            local part = getNPCRootPart(cachedTarget)
            return part.CFrame, true, cachedTarget
        elseif not cachedTarget then
            return nil, false, nil
        end
    end
    targetScanAt = now + TARGET_SCAN_INTERVAL
        local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
        local highestLevel = 0
        local bestCFrame = nil
        local bestNPCObj = nil
    local bestIsFavorite = false


        local hasSelection = false
        for _, isSelected in pairs(selectedNPCNames) do
                if isSelected then hasSelection = true break end
        end


    -- If user is running Auto Farm Boss and did not select any regular monsters,
    -- do not randomly attack NPCs when the boss is dead! Wait for the next boss.
    if isAutoFarmBoss and not hasSelection then
        cachedTarget = nil
        return nil, false, nil
    end


        if npcsFolder then
                for _, npc in ipairs(npcsFolder:GetChildren()) do
            local level = getNPCLevel(npc)
                        if level > 0 and (favoriteNPCNames[npc.Name] or not hasSelection or selectedNPCNames[npc.Name]) and isAlive(npc) then
                                local isFavorite = favoriteNPCNames[npc.Name] == true
                                local targetPart = getNPCRootPart(npc)
                                
                                if targetPart then
                                        if (isFavorite and not bestIsFavorite) or (isFavorite == bestIsFavorite and level > highestLevel) then
                        bestIsFavorite = isFavorite
                                                highestLevel = level
                                                bestCFrame = targetPart.CFrame
                                                bestNPCObj = npc
                                        end
                                end
                        end
                end
        end


        cachedTarget = bestNPCObj
        if bestCFrame then
                return bestCFrame, true, bestNPCObj
        end
        return nil, false, nil
end


local function refreshTPButtons()
    local signature = listSignature(savedNPCPositions, knownNPCNames)
    if signature == tpSignature then return end
    tpSignature = signature
        for _, child in ipairs(tpScrollFrame:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
        end


        local sortedList = {}
        for npcName, cf in pairs(savedNPCPositions) do
                local level = knownNPCNames[npcName] or 0
                table.insert(sortedList, {Name = npcName, Level = level, CFrame = cf})
        end


        table.sort(sortedList, function(a, b)
                if a.Level == b.Level then return a.Name < b.Name end
                return a.Level > b.Level
        end)


        for idx, item in ipairs(sortedList) do
                local levelText = item.Level > 0 and string.format(" [Lv.%d]", item.Level) or " [NPC]"
                local displayText = "🌀 Teletransportar para: " .. item.Name .. levelText


                local tpBtn = Instance.new("TextButton")
                tpBtn.Name = "TP_" .. item.Name
                tpBtn.Size = UDim2.new(1, -8, 0, 28)
                tpBtn.LayoutOrder = idx
                tpBtn.BackgroundColor3 = item.Level > 0 and Color3.fromRGB(90, 50, 140) or Color3.fromRGB(45, 75, 120)
                tpBtn.Text = displayText
                tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                tpBtn.Font = Enum.Font.SourceSansBold
                tpBtn.TextSize = 13
                tpBtn.Parent = tpScrollFrame
                Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 5)


                tpBtn.MouseButton1Click:Connect(function()
            if hubUI.isBusy and hubUI.isBusy() then return end
                        local character = player.Character
                        local hrp = character and character:FindFirstChild("HumanoidRootPart")
                        if hrp and savedNPCPositions[item.Name] then
                                hrp.CFrame = savedNPCPositions[item.Name]
                                tpBtn.Text = "⚡ Teleporte realizado!"
                                task.wait(1)
                if not destroyed and tpBtn.Parent then tpBtn.Text = displayText end
                        end
                end)
        end
end


-- Salva coordenadas de monstros e NPCs (exibidas na aba Teleporte)
local function autoSaveNPCPosition(npc)
        if not npc or not npc:IsA("Model") then return end
        
        local lvl = getNPCLevel(npc)
        knownNPCNames[npc.Name] = math.max(knownNPCNames[npc.Name] or 0, lvl)


        local targetPart = getNPCRootPart(npc)
        if targetPart then
                if not savedNPCPositions[npc.Name] then
                        savedNPCPositions[npc.Name] = targetPart.CFrame
                        queueRefresh()
                end
        end


    local isBoss, bKey = checkIsBoss(npc)
    if isBoss and bKey then
        revealInvisibleNPC(npc)
        if not bossCache[bKey] then
            bossCache[bKey] = {
                Key = bKey,
                Name = npc.Name,
                Level = lvl
            }
        end
        if targetPart then
            bossCache[bKey].CFrame = targetPart.CFrame
            savedNPCPositions[bKey] = targetPart.CFrame
        end
        if not bossCache[bKey].InFolder then
            bossCache[bKey].TimeText = "🔥 Chefe apareceu!"
        end
    end
end


local function stopAll()
    MURIM_RAID_DEFENSE.reset()
    isAutoHallowRaid = false
    MURIM_TRACE.active = false
    MURIM_TRACE.stageTo("Farm encerrado")
    currentRaidRoomIndex = 1
    if toggleHallowRaidBtn and toggleHallowRaidBtn.Parent then
        toggleHallowRaidBtn.Text = "🎃 Raid automático de Hungry Ghost Gate (Auto: OFF)"
        toggleHallowRaidBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 60)
    end
    if hallowStatusLabel and hallowStatusLabel.Parent then
        hallowStatusLabel.Text = "💤 Automação de Halloween desativada"
    end
    activeBossTarget = nil
    activeBossProbeCount = 0
    lastBossCFrame = nil
    bossLootWaitUntil = 0
        isFarming = false
    currentTarget = nil
    cachedTarget = nil
    targetScanAt = 0
    pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game) end)


        if mainTask then task.cancel(mainTask) mainTask = nil end
        if attackTask then task.cancel(attackTask) attackTask = nil end


        startBtn.Text = "Iniciar farm"
        startBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 65)


    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and (part.Name == "HumanoidRootPart" or part.Name:find("Torso") or part.Name:find("Leg") or part.Name:find("Arm") or part.Name == "Head") then
                part.CanCollide = true
            end
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum and hum.Health > 0 then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end


local function useArtifact(aimPosition)
    if not isAutoArtifact or (hubUI.isBusy and hubUI.isBusy()) then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end


    local aim = aimPosition
    if not aim then
        if currentTarget and isAlive(currentTarget) then
            local targetPart = getNPCRootPart(currentTarget)
            if targetPart then aim = targetPart.Position end
        end
    end
    if not aim then
        aim = hrp.Position + hrp.CFrame.LookVector * 25
    end


    artifactRemote = artifactRemote or findArtifactRemote()
    if artifactRemote then
        pcall(function()
            artifactRemote:FireServer({
                op = "Use",
                aim = aim
            })
        end)
    end
end


local function startFarming()
    if isFarming then return end
    if isAutoHallowRaid then
        startBtn.Text = "⚠️ Desative o Halloween antes de iniciar o farm comum"
        return
    end
    combatRemote = findCombatRemote()
    if not combatRemote then
        startBtn.Text = "CombatInput não encontrado • tente novamente"
        return
    end
        isFarming = true
        startBtn.Text = "🔄 Em execução..."
        startBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 100)


        if mainTask then task.cancel(mainTask) end
        if attackTask then task.cancel(attackTask) end


        mainTask = task.spawn(function()
                while isFarming do
            if hubUI.isBusy and hubUI.isBusy() then
                currentTarget = nil
                if startBtn.Text ~= "Farm pausado • minijogo em andamento" then
                    startBtn.Text = "Farm pausado • minijogo em andamento"
                end
                task.wait(0.15)
                continue
            end
            local character = player.Character
                        local hrp = character and character:FindFirstChild("HumanoidRootPart")


                        if hrp then
                local bossCF, bossAlive, bossObj = chooseBossTarget()
                local targetCF, aliveStatus, npcObj
                local isBoss = false


                if bossCF and bossAlive and bossObj then
                    targetCF = bossCF
                    aliveStatus = true
                    npcObj = bossObj
                    isBoss = true
                    local bTxt = "Atacando chefe: " .. tostring(npcObj.Name)
                    if startBtn.Text ~= bTxt then startBtn.Text = bTxt end
                elseif bossCF and not bossAlive then
                    -- Boss is spawned, teleport to its anchor position so client streams it in!
                    activeBossProbeCount = (activeBossProbeCount or 0) + 1
                    if activeBossProbeCount > 15 then
                        for key, isSelected in pairs(selectedBossNames) do
                            if isSelected and bossCache[key] and bossCache[key].CFrame == bossCF then
                                bossProbeAt[key] = os.clock() + 20
                            end
                        end
                        activeBossProbeCount = 0
                    else
                        hrp.CFrame = bossCF * CFrame.new(0, 4, 0)
                        if startBtn.Text ~= "Teleportando até o chefe..." then startBtn.Text = "Teleportando até o chefe..." end
                        task.wait(0.25)
                        continue
                    end
                else
                    -- Check Boss Chest FIRST before targeting normal monsters!
                    local bossChestObj, bossChestPart = getBossChest()
                    if isAutoLooting and bossChestObj and bossChestPart then
                        currentTarget = nil
                        local bTxt = "🎁 Abrindo baú do chefe: " .. tostring(bossChestObj.Name)
                        if startBtn.Text ~= bTxt then startBtn.Text = bTxt end
                        interactWithDrop(bossChestObj)
                        task.wait(0.1)
                        continue
                    end


                    -- Check if we recently killed a boss and are waiting for the boss chest to spawn
                    if isAutoLooting and os.clock() < bossLootWaitUntil and lastBossCFrame then
                        currentTarget = nil
                        if startBtn.Text ~= "⏳ Aguardando o baú do chefe aparecer..." then
                            startBtn.Text = "⏳ Aguardando o baú do chefe aparecer..."
                        end
                        hrp.CFrame = lastBossCFrame * CFrame.new(0, 3, 0)
                        task.wait(0.25)
                        continue
                    end


                    if startBtn.Text ~= "Farmando..." then startBtn.Text = "Farmando..." end
                    targetCF, aliveStatus, npcObj = getHighestLevelTarget()
                end


                local isNearBossLoot = lastBossCFrame and os.clock() < (bossLootWaitUntil + 5.0)
                local favoriteReady = isBoss or (not isNearBossLoot and aliveStatus and npcObj and favoriteNPCNames[npcObj.Name])
                local dropsFolder = Workspace:FindFirstChild("Murim_Drops")
                                local validDrop = nil
                                
                                if isAutoLooting and dropsFolder and not favoriteReady then
                                        local bestItem = nil
                                        local bestChest = nil
                                        local bestItemDist = math.huge
                                        local bestChestDist = math.huge
                                        local hrpPos = hrp.Position


                                        for _, drop in ipairs(dropsFolder:GetChildren()) do
                                                if drop and drop.Parent then
                                                        local part = drop:IsA("BasePart") and drop or (drop:IsA("Model") and drop.PrimaryPart) or drop:FindFirstChildWhichIsA("BasePart", true)
                                                        if part then
                                                                local dist = (part.Position - hrpPos).Magnitude
                                                                if isChest(drop) then
                                                                        local cooldown = openedChests[drop]
                                                                        if not cooldown or os.clock() >= cooldown then
                                                                                local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt", true)
                                                                                if prompt and prompt.Enabled and dist < bestChestDist then
                                                                                        bestChest = drop
                                                                                        bestChestDist = dist
                                                                                end
                                                                        end
                                                                else
                                                                        if shouldLootItem(drop) and dist < bestItemDist then
                                                                                bestItem = drop
                                                                                bestItemDist = dist
                                                                        end
                                                                end
                                                        end
                                                end
                                        end


                                        -- Always prioritize dropped items first! Chests only opened when ground is clear of loot.
                                        validDrop = bestItem or bestChest
                                end


                                if validDrop then
                                        currentTarget = nil
                                        interactWithDrop(validDrop)
                                        task.wait(0.08)
                                else


                                        if aliveStatus and targetCF and npcObj then
                                                currentTarget = npcObj
                                                hrp.CFrame = targetCF * getFarmOffsetCFrame()
                                                hrp.AssemblyLinearVelocity = Vector3.zero
                                                hrp.AssemblyAngularVelocity = Vector3.zero
                                        else
                                                currentTarget = nil
                        -- If we were away fighting a boss or died, and no selected monsters are currently loaded:
                        -- Teleport back to the monster's saved position so streaming loads them!
                        local returnCF = nil
                        for name, isFav in pairs(favoriteNPCNames) do
                            if isFav and savedNPCPositions[name] and (knownNPCNames[name] or 0) > 0 then
                                returnCF = savedNPCPositions[name]
                                break
                            end
                        end
                        if not returnCF then
                            for name, isSel in pairs(selectedNPCNames) do
                                if isSel and savedNPCPositions[name] and (knownNPCNames[name] or 0) > 0 then
                                    returnCF = savedNPCPositions[name]
                                    break
                                end
                            end
                        end
                        if returnCF then
                            hrp.CFrame = returnCF
                            if startBtn.Text ~= "Voltando ao ponto de farm..." then
                                startBtn.Text = "Voltando ao ponto de farm..."
                            end
                            task.wait(0.35)
                        elseif isAutoFarmBoss then
                            if startBtn.Text ~= "Aguardando próximo respawn do chefe..." then
                                startBtn.Text = "Aguardando próximo respawn do chefe..."
                            end
                        end
                                        end
                                        task.wait(0.03)
                                end
                        else
                                task.wait(0.5)
                        end
                end
        end)


        attackTask = task.spawn(function()
                while isFarming do
                        if not (hubUI.isBusy and hubUI.isBusy()) and currentTarget and isAlive(currentTarget) then
                                pcall(function()
                                        combatRemote:FireServer("Attack")
                                end)
                pcall(function()
                    local prompt = currentTarget:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt and prompt.Enabled and typeof(fireproximityprompt) == "function" then
                        fireproximityprompt(prompt)
                    end
                end)
                if isAutoArtifact and os.clock() - lastArtifactUsed >= artifactCooldown then
                    lastArtifactUsed = os.clock()
                    local targetPart = getNPCRootPart(currentTarget)
                    if targetPart then
                        useArtifact(targetPart.Position)
                    end
                end
                        end
                        task.wait(0.1)
                end
        end)
end


toggleHitboxBtn.MouseButton1Click:Connect(function()
        isHitboxExpanded = not isHitboxExpanded
        if isHitboxExpanded then
                toggleHitboxBtn.Text = "🎯 Expandir hitbox dos monstros (Hitbox: ON)"
                toggleHitboxBtn.BackgroundColor3 = Color3.fromRGB(40, 110, 150)
                updateAllHitboxes()
        else
                restoreHitboxes()
                toggleHitboxBtn.Text = "🎯 Expandir hitbox dos monstros (Hitbox: OFF)"
                toggleHitboxBtn.BackgroundColor3 = Color3.fromRGB(90, 60, 110)
        end
end)


toggleLootBtn.MouseButton1Click:Connect(function()
        isAutoLooting = not isAutoLooting
        if isAutoLooting then
                toggleLootBtn.Text = "🎁 Coleta automática de itens (Auto Loot: ON)"
                toggleLootBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
        else
                toggleLootBtn.Text = "🎁 Coleta automática de itens (Auto Loot: OFF)"
                toggleLootBtn.BackgroundColor3 = Color3.fromRGB(110, 50, 130)
        end
end)


-- Lista monstros na interface (mostra todos, sem filtro por nível)
refreshNPCList = function()
    if destroyed then return end
        local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
        if npcsFolder then
                for _, npc in ipairs(npcsFolder:GetChildren()) do
            if not isFriendlyOrTalkable(npc) and getNPCLevel(npc) > 0 then
                applyHitboxToNPC(npc)
            end
            autoSaveNPCPosition(npc)
                end
        end


    refreshTPButtons()
    local signature = listSignature(knownNPCNames, knownNPCNames)
    if signature == npcSignature then return end
    npcSignature = signature


    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("Frame") then child:Destroy() end
    end


        local nameList = {}
        for name, lvl in pairs(knownNPCNames) do
        if (lvl or 0) > 0 and not checkIsBossName(name) then
                    table.insert(nameList, name)
        end
        end


        table.sort(nameList, function(a, b)
                local lvlA = knownNPCNames[a] or 0
                local lvlB = knownNPCNames[b] or 0
                if lvlA == lvlB then return a < b end
                return lvlA > lvlB
        end)


        for index, name in ipairs(nameList) do
                local isSelected = selectedNPCNames[name] or false
                local level = knownNPCNames[name] or 0
                local levelDisplay = level > 0 and string.format(" [Lv.%d]", level) or ""


        local row = Instance.new("Frame")
        row.Name = "NPCRow_" .. name
        row.Size = UDim2.new(1, -8, 0, 32)
        row.LayoutOrder = index
        row.BackgroundTransparency = 1
        row.Parent = scrollFrame
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(1, -42, 1, 0)
        btn.ClipsDescendants = true
        btn.TextWrapped = true
                btn.BackgroundColor3 = isSelected and Color3.fromRGB(45, 110, 55) or Color3.fromRGB(35, 35, 45)
                btn.Text = (isSelected and "  [✓] " or "  [  ] ") .. name .. levelDisplay
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 14
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        local favoriteBtn = Instance.new("TextButton")
        favoriteBtn.Name = "Favorite"
        favoriteBtn.Position = UDim2.new(1, -36, 0, 0)
        favoriteBtn.Size = UDim2.new(0, 36, 1, 0)
        favoriteBtn.BorderSizePixel = 0
        favoriteBtn.Font = Enum.Font.SourceSansBold
        favoriteBtn.TextSize = 22
        favoriteBtn.Parent = row
        Instance.new("UICorner", favoriteBtn).CornerRadius = UDim.new(0, 5)
        local function updateFavoriteButton()
            local active = favoriteNPCNames[name] == true
            favoriteBtn.Text = active and "★" or "☆"
            favoriteBtn.TextColor3 = active and Color3.fromRGB(255, 215, 80) or Color3.fromRGB(160, 170, 190)
            favoriteBtn.BackgroundColor3 = active and Color3.fromRGB(90, 70, 25) or Color3.fromRGB(35, 35, 45)
        end
        updateFavoriteButton()
        favoriteBtn.MouseButton1Click:Connect(function()
            favoriteNPCNames[name] = not favoriteNPCNames[name]
            targetScanAt = 0
            cachedTarget = nil
            currentTarget = nil
            updateFavoriteButton()
        end)


                btn.MouseButton1Click:Connect(function()
                        selectedNPCNames[name] = not selectedNPCNames[name]
            targetScanAt = 0
                        if selectedNPCNames[name] then
                                btn.BackgroundColor3 = Color3.fromRGB(45, 110, 55)
                                btn.Text = "  [✓] " .. name .. levelDisplay
                        else
                                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                                btn.Text = "  [  ] " .. name .. levelDisplay
                        end
                end)
        end
end


local function bindFolderEvents()
    for _, conn in ipairs(folderConnections) do conn:Disconnect() end
    table.clear(folderConnections)
    targetScanAt = 0
    local folder = Workspace:FindFirstChild("Murim_NPCs")
    if not folder then return end
    folderConnections[#folderConnections + 1] = folder.ChildAdded:Connect(function()
        targetScanAt = 0
        queueRefresh()
    end)
    folderConnections[#folderConnections + 1] = folder.ChildRemoved:Connect(function()
        targetScanAt = 0
    end)
    queueRefresh()
end
externalConnections[#externalConnections + 1] = Workspace.ChildAdded:Connect(function(child)
    if child.Name == "Murim_NPCs" then bindFolderEvents() end
end)
externalConnections[#externalConnections + 1] = Workspace.ChildRemoved:Connect(function(child)
    if child.Name == "Murim_NPCs" then bindFolderEvents() end
end)
bindFolderEvents()


--------------------------------------------------------------------------------
-- 🛡️ Auto Parry (com base em MurimClient.CombatInput)
--------------------------------------------------------------------------------
local function canParry()
    local char = player.Character
    if not char then return false end
    if char:GetAttribute("Armed") == nil then return false end
    local stance = char:GetAttribute("Stance")
    if stance == "GuardBroken" or stance == "Stunned" or stance == "Parried" then return false end
    if char:GetAttribute("Knocked") or char:GetAttribute("Ragdoll") or char:GetAttribute("Busy") then return false end
    local readyAt = tonumber(char:GetAttribute("ParryReadyAt")) or 0
    if Workspace:GetServerTimeNow() < readyAt then return false end
    return true
end


local function executeParry()
    if isParrying or not canParry() then return end
    isParrying = true
    combatRemote = combatRemote or findCombatRemote()
    if combatRemote then
        pcall(function() combatRemote:FireServer("ParryDown", nil) end)
    end
    task.delay(PARRY_WINDOW, function()
        if combatRemote then
            pcall(function() combatRemote:FireServer("ParryUp", nil) end)
        end
        isParrying = false
    end)
end



-- A06-only parry path. The generic Auto Parry behavior remains unchanged.
local function executeSoulParry(context)
    if destroyed or not isAutoHallowRaid or context.root.Parent~=player.Character then return false,"Auto OFF/personagem mudou" end
    if isParrying then return false,"parry em andamento" end
    if not canParry() then
        local char=player.Character
        return false,"estado="..tostring(char and char:GetAttribute("Stance")).." prontoEm="..tostring(char and char:GetAttribute("ParryReadyAt"))
    end
    combatRemote=combatRemote or findCombatRemote()
    if not combatRemote then return false,"CombatInput ausente" end
    local remote=combatRemote
    local ok,err=pcall(function() remote:FireServer("ParryDown",nil) end)
    if not ok then return false,tostring(err) end
    isParrying=true
    task.delay(PARRY_WINDOW,function()
        -- Always release this input even if Auto was disabled in the meantime.
        local released,releaseError=pcall(function() remote:FireServer("ParryUp",nil) end)
        isParrying=false
        local hum=context.root.Parent and context.root.Parent:FindFirstChildOfClass("Humanoid")
        MURIM_LATE.soulNote(string.format("ParryUp pcall=%s HP=%.0f->%.0f Stance=%s; resultado da defesa nao inferido%s",
            tostring(released),context.hp,hum and hum.Health or 0,
            tostring(context.root.Parent and context.root.Parent:GetAttribute("Stance")),released and "" or " erro="..tostring(releaseError)))
    end)
    return true
end
externalConnections[#externalConnections+1]=RunService.Heartbeat:Connect(function()
    if destroyed then return end
    local state=MURIM_LATE.soulState
    if os.clock()-state.lastTick<0.03 then return end
    local char=player.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    if not root or math.abs(root.Position.X-40000)>145 then
        if state.root then MURIM_LATE.soulTick(nil,Vector3.zero,false,nil,screenGui,nil) end
        return
    end
    local _,origin=getActiveRaidInfo(player)
    local ok,err=pcall(MURIM_LATE.soulTick,root,origin,isAutoHallowRaid,player:FindFirstChild("PlayerGui"),screenGui,executeSoulParry)
    if not ok then MURIM_TRACE.add("ERRO","ParryA06",tostring(err),5,"soul-tick") end
end)

local function checkAttacker(enemy, myPos, myHrp)
    if not isAutoParry or isParrying or not enemy or enemy == player.Character then return end
    local act = enemy:GetAttribute("Act")
    if not act then return end


    local actT = enemy:GetAttribute("ActT")
    local actW = enemy:GetAttribute("ActW")
    if type(actT) ~= "number" or type(actW) ~= "number" or actW <= 0 then return end


    local enemyHrp = getNPCRootPart(enemy)
    if not enemyHrp then return end


    local ep = enemyHrp.Position
    if math.abs(myPos.X - ep.X) > PARRY_DISTANCE or math.abs(myPos.Z - ep.Z) > PARRY_DISTANCE then return end


    local dist = (myPos - ep).Magnitude
    if dist > PARRY_DISTANCE then return end


    local attackId = tostring(act) .. "_" .. tostring(actT)
    if handledAttacks[enemy] == attackId then return end


    local serverNow = Workspace:GetServerTimeNow()
    local hitTime = actT + actW
    local timeRemaining = hitTime - serverNow


    if timeRemaining > 0 and timeRemaining <= (actW + 0.1) then
        handledAttacks[enemy] = attackId
        local delayTime = math.max(0, timeRemaining - PARRY_LEAD)
        if delayTime <= 0.02 then
            executeParry()
        else
            task.delay(delayTime, function()
                if not destroyed and isAutoParry and enemy and enemy.Parent and myHrp.Parent then
                    local currentDist = (myHrp.Position - enemyHrp.Position).Magnitude
                    if currentDist <= PARRY_DISTANCE then
                        executeParry()
                    end
                end
            end)
        end
    end
end


externalConnections[#externalConnections + 1] = RunService.Heartbeat:Connect(function()
    if destroyed or not isAutoParry or isParrying or (hubUI.isBusy and hubUI.isBusy()) then return end
    local char = player.Character
    local myHrp = char and char:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end
    local myPos = myHrp.Position


    local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            checkAttacker(npc, myPos, myHrp)
        end
    end
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            checkAttacker(otherPlayer.Character, myPos, myHrp)
        end
    end
end)


--------------------------------------------------------------------------------
-- 📿 Auto Artifact (ativado automaticamente próximo aos inimigos)
--------------------------------------------------------------------------------
artifactTask = task.spawn(function()
    while not destroyed do
        if isAutoArtifact and not isFarming and not (hubUI.isBusy and hubUI.isBusy()) then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and os.clock() - lastArtifactUsed >= artifactCooldown then
                local targetPos = nil
                local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
                local closestDist = 50
                if npcsFolder then
                    for _, npc in ipairs(npcsFolder:GetChildren()) do
                        if isAlive(npc) then
                            local tPart = getNPCRootPart(npc)
                            if tPart then
                                local d = (hrp.Position - tPart.Position).Magnitude
                                if d < closestDist then
                                    closestDist = d
                                    targetPos = tPart.Position
                                end
                            end
                        end
                    end
                end
                if not targetPos then
                    for _, otherP in ipairs(Players:GetPlayers()) do
                        if otherP ~= player and otherP.Character then
                            local otherHrp = otherP.Character:FindFirstChild("HumanoidRootPart")
                            local hum = otherP.Character:FindFirstChildOfClass("Humanoid")
                            if otherHrp and hum and hum.Health > 0 then
                                local d = (hrp.Position - otherHrp.Position).Magnitude
                                if d < closestDist then
                                    closestDist = d
                                    targetPos = otherHrp.Position
                                end
                            end
                        end
                    end
                end
                if targetPos then
                    lastArtifactUsed = os.clock()
                    useArtifact(targetPos)
                end
            end
        end
        task.wait(0.5)
    end
end)


--------------------------------------------------------------------------------
-- 🎃 Sistema de raid automático The Hungry Ghost Gate
--------------------------------------------------------------------------------

-- Passive diagnostics remain active with Auto disabled, and are cleaned up with the UI.
externalConnections[#externalConnections+1]=Workspace.DescendantAdded:Connect(MURIM_LATE.trackEncounterObject)
externalConnections[#externalConnections+1]=RunService.Heartbeat:Connect(function()
    if destroyed then return end
    local e=MURIM_LATE.encounter
    if os.clock()-e.lastPoll<0.5 then return end
    local ok,err=pcall(function()
        local char=player.Character
        local root=char and char:FindFirstChild("HumanoidRootPart")
        local _,origin=getActiveRaidInfo(player)
        if root and math.abs(root.Position.X-origin.X)<145
            and root.Position.Z-origin.Z>=1090 and root.Position.Z-origin.Z<=1245 and not e.initialized then
            e.initialized=true
            for _,obj in ipairs(Workspace:GetDescendants()) do MURIM_LATE.trackEncounterObject(obj) end
        end
        MURIM_LATE.observeTeahouse(root,select(1,getActiveRaidInfo(player)),origin,isAutoHallowRaid)
        MURIM_LATE.observeEncounter(root,origin,isAutoHallowRaid)
    end)
    if not ok then
        e.lastPoll=os.clock()
        MURIM_TRACE.add("ERRO","ArenaA06",tostring(err),10,"observador")
    end
end)

-- V19E: observadores somente de log, separados do parry.
externalConnections[#externalConnections+1]=Workspace.DescendantAdded:Connect(function(obj)
    if destroyed or not MURIM_LATE.soulState.root then return end
    task.defer(function()
        local ok,err=pcall(MURIM_LATE.timelineObject,obj,player.Character)
        if not ok then MURIM_TRACE.add("ERRO","LinhaTempoA06",tostring(err),5,"objeto") end
    end)
end)
externalConnections[#externalConnections+1]=RunService.Heartbeat:Connect(function()
    if destroyed then return end
    local ok,err=pcall(MURIM_LATE.timelineTick,player.Character)
    if not ok then MURIM_TRACE.add("ERRO","LinhaTempoA06",tostring(err),5,"tick") end
end)

local hallowRaidTask = task.spawn(function()
    while not destroyed do
        if isAutoHallowRaid and not (hubUI.isBusy and hubUI.isBusy()) then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local isInsideRaid = math.abs(hrp.Position.X - 40000) < 3000
                if not isInsideRaid then
                    if HallowEntryState.wasInsideRaid then
                        MURIM_TRACE.add("INFO", "Raid", "Personagem saiu da regiao da arena; estado de salas reiniciado.")
                        MURIM_A04.stopRun()
                        HallowEntryState.wasInsideRaid = false
                        HallowEntryState.verifiedRoomIndex = nil
                        HallowEntryState.sawCombatInRoom = false
                    end
                    currentRaidRoomIndex = 1
                    lastRaidCombatTime = 0
                    -- A presença de MurimDialog no PlayerGui NÃO significa que esteja aberto.
                    -- Somente opções realmente visíveis são consideradas como diálogo ativo.
                    local choiceButton, hasVisibleChoices = findVisibleHallowDifficulty(player.PlayerGui, hallowDifficulty)
                    if choiceButton then
                        -- Prova de que Guest Ledger funcionou: o dialogo e a dificuldade ficaram visiveis.
                        HallowEntryState.promptAttempts = 0
                        HallowEntryState.lastSeenDialogAt = os.clock()
                        if HallowEntryState.choiceAttempts >= 2 then
                            MURIM_TRACE.stageTo("Dificuldade visivel: selecao manual necessaria")
                            if not HallowEntryState.manualChoiceWarned then
                                HallowEntryState.manualChoiceWarned = true
                                MURIM_TRACE.add("AVISO", "Dificuldade", "Duas tentativas de evento sem entrada confirmada. Toque em " .. hallowDifficulty .. " manualmente.")
                            end
                            if hallowStatusLabel then hallowStatusLabel.Text = "👆 Toque em " .. hallowDifficulty .. " no diálogo: tentativas automáticas não confirmaram entrada." end
                        elseif os.clock() - HallowEntryState.lastChoiceAt >= 5 then
                            -- Um evento por tentativa. Nenhum clique de mouse em coordenadas da tela.
                            HallowEntryState.lastChoiceAt = os.clock()
                            HallowEntryState.choiceAttempts = HallowEntryState.choiceAttempts + 1
                            HallowEntryState.awaitingEntryUntil = os.clock() + 8
                            MURIM_TRACE.stageTo("Selecao enviada; aguardando confirmacao de entrada")
                            if typeof(firesignal) == "function" then
                                HallowEntryState.lastChoiceEvent = HallowEntryState.choiceAttempts == 1 and "Activated" or "MouseButton1Click"
                                local ok = pcall(function()
                                    if HallowEntryState.lastChoiceEvent == "Activated" then
                                        firesignal(choiceButton.Activated)
                                    else
                                        firesignal(choiceButton.MouseButton1Click)
                                    end
                                end)
                                MURIM_TRACE.add(ok and "ACAO" or "ERRO", "Dificuldade",
                                    "Tentativa " .. HallowEntryState.choiceAttempts .. "/2: firesignal(" .. HallowEntryState.lastChoiceEvent .. ") pcall=" .. tostring(ok) .. "; aguardando confirmacao real da raid.")
                                if hallowStatusLabel then hallowStatusLabel.Text = "⌛ Dificuldade " .. hallowDifficulty .. " acionada (" .. HallowEntryState.lastChoiceEvent .. "); aguardando entrada na arena..." end
                            else
                                HallowEntryState.choiceAttempts = 2
                                MURIM_TRACE.add("AVISO", "Dificuldade", "Executor nao disponibiliza firesignal. Selecione " .. hallowDifficulty .. " diretamente no dialogo.")
                                if hallowStatusLabel then hallowStatusLabel.Text = "👆 Selecione " .. hallowDifficulty .. " diretamente no diálogo (sem firesignal)." end
                            end
                        else
                            MURIM_TRACE.stageTo("Dificuldade ainda visivel; aguardando resposta do jogo")
                        end
                        task.wait(0.35)
                    elseif hasVisibleChoices then
                        MURIM_TRACE.stageTo("Dialogo aberto: dificuldade " .. hallowDifficulty .. " nao identificada")
                        MURIM_TRACE.add("AVISO", "Dificuldade", "Toque em Inspecionar GUI na aba Logs para registrar os botoes visiveis.", 20)
                        if hallowStatusLabel then
                            hallowStatusLabel.Text = "💬 Diálogo aberto, mas não identifiquei " .. hallowDifficulty .. ". Selecione manualmente."
                        end
                        task.wait(0.5)
                    else
                        -- O dialogo sumiu logo apos a tentativa. Nao reacione o livro
                        -- antes de dar tempo para o teleporte ao servidor ocorrer.
                        if HallowEntryState.awaitingEntryUntil > os.clock() then
                            MURIM_TRACE.stageTo("Dialogo fechou; aguardando confirmacao de entrada")
                            MURIM_TRACE.add("INFO", "Dificuldade", "Dialogo nao esta mais visivel apos tentativa. Aguardando entrada na arena, sem tocar no livro.", 8)
                            if hallowStatusLabel then hallowStatusLabel.Text = "⌛ Diálogo fechou; aguardando confirmação do jogo..." end
                            task.wait(0.4)
                        else
                            if HallowEntryState.awaitingEntryUntil > 0 then
                                MURIM_TRACE.add("AVISO", "Dificuldade", "Passaram 8s sem entrada na arena. Nenhum metodo de selecao foi confirmado; retomando verificacao do livro.")
                                HallowEntryState.awaitingEntryUntil = 0
                                -- Mantem numero de tentativas de dificuldade mesmo se o dialogo fechou:
                                -- proxima abertura deve testar MouseButton1Click em vez de repetir Activated.
                                HallowEntryState.manualChoiceWarned = false
                                HallowEntryState.promptAttempts = 0
                            end
                            -- Ainda NÃO há menu de dificuldade: a janela 'Sign the... / Guest Ledger'
                            -- é um ProximityPrompt do Roblox, não o MurimDialog.
                            MURIM_TRACE.stageTo("Aguardando interacao com Guest Ledger")
                        local ledgerPrompt, ledgerPart = findGuestLedger()
                        if ledgerPart then
                            local dist = (hrp.Position - ledgerPart.Position).Magnitude
                            if dist > 8 then
                                MURIM_TRACE.add("INFO", "Livro", "Livro encontrado; aproximando do prompt.", 12)
                                if hallowStatusLabel then
                                    hallowStatusLabel.Text = "⚡ Aproximando do Guest Ledger para assinar o registro..."
                                end
                                hrp.CFrame = ledgerPart.CFrame * CFrame.new(0, 2, -4) * CFrame.Angles(0, math.rad(180), 0)
                                task.wait(0.5)
                            elseif not ledgerPrompt then
                                MURIM_TRACE.add("AVISO", "Livro", "Perto do livro mas sem ProximityPrompt identificado.", 12)
                                if hallowStatusLabel then
                                    hallowStatusLabel.Text = "⚠️ Perto do livro, mas sem ProximityPrompt. Toque em 'Sign the...' manualmente."
                                end
                                task.wait(1)
                            elseif HallowEntryState.promptAttempts >= 3 then
                                MURIM_TRACE.add("AVISO", "Livro", "Tres tentativas feitas. Precisa acionar Sign the... manualmente.", 18)
                                if hallowStatusLabel then
                                    hallowStatusLabel.Text = "👆 Não consegui abrir o menu: toque em 'Sign the...' manualmente."
                                end
                                task.wait(0.75)
                            elseif os.clock() - HallowEntryState.lastPromptAt >= 2.5 then
                                HallowEntryState.lastPromptAt = os.clock()
                                HallowEntryState.promptAttempts = HallowEntryState.promptAttempts + 1
                                -- Nao resetar choiceAttempts aqui; isso impede repetir indefinidamente
                                -- o evento Activated quando o dialogo fecha sem iniciar a raid.
                                HallowEntryState.manualChoiceWarned = false
                                local ok, via = tryHallowGuestPrompt(ledgerPrompt)
                                MURIM_TRACE.add(ok and "ACAO" or "ERRO", "Livro", "Tentativa " .. HallowEntryState.promptAttempts .. "/3 via " .. tostring(via) .. "; pcall=" .. tostring(ok) .. ". Nao confirma abertura.")
                                print("[Murim V5][Halloween] Guest Ledger tentativa " .. HallowEntryState.promptAttempts .. " via " .. tostring(via) .. " resultado=" .. tostring(ok))
                                if hallowStatusLabel then
                                    if HallowEntryState.promptAttempts < 3 then
                                        hallowStatusLabel.Text = "📜 Tentando assinar Guest Ledger (" .. HallowEntryState.promptAttempts .. "/3)..."
                                    else
                                        hallowStatusLabel.Text = "👆 Se o diálogo não abriu, toque em 'Sign the...' no jogo. Aguardando dificuldades..."
                                    end
                                end
                                task.wait(0.8)
                            else
                                task.wait(0.25)
                            end
                        else
                            MURIM_TRACE.add("AVISO", "Livro", "Guest Ledger nao encontrado pelo scanner. Teleportando ao ponto conhecido.", 15)
                            local gateDist = (hrp.Position - HALLOW_GATE_CFRAME.Position).Magnitude
                            if gateDist > 35 then
                                if hallowStatusLabel then
                                    hallowStatusLabel.Text = "⚡ Indo até Sunken Waystation / Guest Ledger..."
                                end
                                hrp.CFrame = HALLOW_GATE_CFRAME
                                task.wait(0.6)
                            else
                                if hallowStatusLabel then
                                    hallowStatusLabel.Text = "🔎 Procurando o ProximityPrompt 'Sign the...' do Guest Ledger..."
                                end
                                task.wait(0.5)
                            end
                        end
                        end -- fim da espera por entrada / varredura do Guest Ledger
                    end
                else
                    -- INSIDE RAID!
                    HallowEntryState.promptAttempts = 0
                    HallowEntryState.choiceAttempts = 0
                    HallowEntryState.awaitingEntryUntil = 0
                    HallowEntryState.manualChoiceWarned = false
                    if not HallowEntryState.wasInsideRaid then
                        HallowEntryState.wasInsideRaid = true
                        HallowEntryState.verifiedRoomIndex = nil
                        HallowEntryState.sawCombatInRoom = false
                        HallowEntryState.lastRaidSnapshotAt = 0
                        HallowEntryState.lastRaidWarningAt = os.clock()
                        HallowEntryState.lastRoomScanAt = 0
                        lastRaidCombatTime = os.clock()
                        MURIM_A01.reset("nova entrada na arena")
                        MURIM_A02.reset()
                        MURIM_RAID_HIT.reset()
                        MURIM_RAID_DEFENSE.reset()
                        MURIM_A03.reset()
                        MURIM_A04.reset()
                        MURIM_LATE.reset()
                        HallowEntryState.furthestArea=1
                        HallowEntryState.fallSince = 0
                        HallowEntryState.lastGroundedY = nil
                        MURIM_TRACE.add("INFO", "Raid", "Entrada na regiao da arena confirmada por X; identificando sala real. Noclip do Halloween desativado; chao deve manter colisao.")
                    end
                    if detectUncontrolledRaidFall(char, hrp) then
                        MURIM_RAID_DEFENSE.reset()
                        isAutoHallowRaid = false
                        MURIM_TRACE.add("AVISO", "Halloween", "Auto: ON mudou para OFF automaticamente pela protecao contra queda grave. Nao foi clique do usuario.")
                        MURIM_TRACE.active = false
                        MURIM_TRACE.stageTo("Pausado: queda detectada")
                        if toggleHallowRaidBtn then
                            toggleHallowRaidBtn.Text = "🎃 Raid automático de Hungry Ghost Gate (Auto: OFF)"
                            toggleHallowRaidBtn.BackgroundColor3 = Color3.fromRGB(150, 45, 60)
                        end
                        if hallowStatusLabel then
                            hallowStatusLabel.Text = "⚠️ Queda detectada! Automação pausada. Reinicie o personagem se necessário."
                        end
                    end
                    local activeRaidModel, raidOrigin = getActiveRaidInfo()
                    -- Evitar GetBoundingBox em todas as iteracoes (caro no celular).
                    -- Fazer no maximo uma verificacao a cada 1,5s.
                    if os.clock() - HallowEntryState.lastRoomScanAt >= 1.5 then
                        HallowEntryState.lastRoomScanAt = os.clock()
                        local detected, roomReason = detectRoomIndexFromPosition(hrp.Position, raidOrigin, activeRaidModel)
                        HallowEntryState.lastRoomScanReason = roomReason
                        if detected then
                            local previousFurthest=HallowEntryState.furthestArea or 1
                            if detected>previousFurthest then HallowEntryState.furthestArea=detected end
                            -- A03 comeca em Z relativo 399: no batente (Z~380-399),
                            -- um pequeno recuo nao deve acionar novamente a rota A02.
                            if detected==2 and previousFurthest>=3
                                and hrp.Position.Z-raidOrigin.Z>=350 then
                                detected=3
                                roomReason=roomReason.." | transicao A02/A03, progresso A03 preservado"
                                MURIM_TRACE.add("INFO","Sala","Histerese A02/A03: no batente Z~350-399; nao reiniciar A02 nem teleportar para tras.",12)
                            end
                            if HallowEntryState.verifiedRoomIndex ~= detected then
                                MURIM_TRACE.add("INFO", "Sala", "Area " .. detected .. "/10 identificada pela posicao continua: " .. roomReason)
                                HallowEntryState.sawCombatInRoom = false
                                lastRaidCombatTime = os.clock()
                            end
                            HallowEntryState.verifiedRoomIndex = detected
                            HallowEntryState.verifiedRoomAt = os.clock()
                            currentRaidRoomIndex = detected
                            MURIM_TRACE.stageTo("Dentro da raid: area " .. tostring(detected) .. " (posicao; objetivo pendente)")
                        else
                            -- A geometria pode sumir temporariamente pelo StreamingEnabled.
                            if os.clock() - HallowEntryState.verifiedRoomAt > 5 then
                                HallowEntryState.verifiedRoomIndex = nil
                                MURIM_TRACE.stageTo("Na arena; sala nao identificada")
                            end
                        end
                    end
                    if os.clock() - HallowEntryState.lastRaidSnapshotAt >= 18 then
                        HallowEntryState.lastRaidSnapshotAt = os.clock()
                        MURIM_TRACE.add("INFO", "Raid",
                            string.format("Pos=(%.0f, %.0f, %.0f) | modelo=%s | origemZ=%.0f | sala=%s | verificacao=%s",
                                hrp.Position.X, hrp.Position.Y, hrp.Position.Z,
                                activeRaidModel and activeRaidModel.Name or "ausente", raidOrigin.Z,
                                tostring(HallowEntryState.verifiedRoomIndex or "desconhecida"),
                                HallowEntryState.lastRoomScanReason))
                    end


                    if currentRaidRoomIndex~=4 then MURIM_A04.stopRun() end
                    if currentRaidRoomIndex~=5 then MURIM_LATE.stopWalk() end
                    if currentRaidRoomIndex==6 then
                        MURIM_LATE.cerberusFocus=MURIM_LATE.liveCerberus(hrp,activeRaidModel,raidOrigin)
                    else MURIM_LATE.cerberusFocus=nil end
                    local tailorCenter=nil
                    if currentRaidRoomIndex==3 and MURIM_RAID_HIT.yardObjective
                        and hrp.Position.Z-raidOrigin.Z>=488 and hrp.Position.Z-raidOrigin.Z<=538 then
                        tailorCenter=MURIM_A03.tailorCenter(raidOrigin,activeRaidModel)
                    end
                    local defenseBlocking=false
                    if currentRaidRoomIndex==4 then
                        -- furtividade nao herda pausa de HP do combate Paper Tailor
                        if MURIM_RAID_DEFENSE.retreating then
                            MURIM_RAID_DEFENSE.release()
                            MURIM_RAID_DEFENSE.reset()
                        end
                    else
                        defenseBlocking=MURIM_RAID_DEFENSE.tick(char,hrp,tailorCenter,MURIM_LATE.cerberusFocus)
                    end
                    if currentRaidRoomIndex==6 then
                        defenseBlocking=MURIM_LATE.soulBlocking(hrp) or defenseBlocking
                    end
                    if defenseBlocking then
                        MURIM_LATE.stopWalk()
                        currentTarget=nil
                        if hallowStatusLabel then
                            hallowStatusLabel.Text=currentRaidRoomIndex==6 and os.clock()<(MURIM_LATE.soulUntil or 0)
                                and "Three Souls: ataques pausados; aguardando parry das souls"
                                or "Recuperacao de HP: ataques pausados ate atingir HP alvo"
                        end
                    else
                    if currentRaidRoomIndex~=4 and isHallowPacifySeen and os.clock() - lastSeenPacifyTime >= 0.5 then
                        lastSeenPacifyTime = os.clock()
                        pcall(function()
                            local seenRemote = ReplicatedStorage:FindFirstChild("HallowGateSeen")
                            if seenRemote then
                                local ids = {}
                                for _, obj in ipairs(CollectionService:GetTagged("HallowWatched")) do
                                    local hId = obj:GetAttribute("HallowId")
                                    if hId then table.insert(ids, hId) end
                                    if #ids >= 32 then break end
                                end
                                if #ids > 0 then
                                    seenRemote:FireServer("seen", ids)
                                end
                            end
                        end)
                    end


                    if currentRaidRoomIndex==3 or (HallowEntryState.furthestArea or 1)>=3 then
                        MURIM_RAID_HIT.hudTick(player.PlayerGui)
                        if currentRaidRoomIndex==3 then
                            MURIM_RAID_HIT.paperStallCheck()
                            MURIM_A03.tick(player,hrp,activeRaidModel,raidOrigin)
                        end
                    end
                    -- A04 e etapa de furtividade, nao depende da varredura de inimigos/loot.
                    if currentRaidRoomIndex==4 then
                        currentTarget=nil
                        local ok,err=xpcall(function()
                            MURIM_A04.tick(hrp,activeRaidModel,raidOrigin)
                        end,function(e) return debug.traceback(tostring(e),2) end)
                        if not ok then
                            MURIM_A04.cancelHold()
                            MURIM_A04.stopRun()
                            MURIM_TRACE.add("ERRO","A04Tick",err,5)
                        end
                        if hallowStatusLabel then hallowStatusLabel.Text="A04: "..MURIM_A04.phase end
                        task.wait(0.04)
                        continue -- A04 owns movement: no loot/combat may override this tick.
                    end
                    -- Check for drops or boss chest in raid
                    if currentRaidRoomIndex==6 then
                        MURIM_LATE.cerberusFocus=MURIM_LATE.liveCerberus(hrp,activeRaidModel,raidOrigin)
                    else MURIM_LATE.cerberusFocus=nil end
                    local dropsFolder = Workspace:FindFirstChild("Murim_Drops")
                    local raidDrop = nil
                    if dropsFolder and not MURIM_LATE.cerberusFocus then
                        for _, drop in ipairs(dropsFolder:GetChildren()) do
                            if drop and drop.Parent then
                                local dPart = drop:IsA("BasePart") and drop or (drop:IsA("Model") and (drop.PrimaryPart or drop:FindFirstChildWhichIsA("BasePart", true)))
                                if dPart and math.abs(dPart.Position.X - 40000) < 3000
                                    and (dPart.Position - hrp.Position).Magnitude <= 120
                                    and shouldLootItem(drop)
                                    and (not isChest(drop) or not openedChests[drop] or openedChests[drop] <= os.clock()) then
                                    raidDrop = drop
                                    break
                                end
                            end
                        end
                    end
                    if raidDrop then
                        if hallowStatusLabel then hallowStatusLabel.Text = "🎁 Coletando recompensas: " .. tostring(raidDrop.Name) end
                        interactWithDrop(raidDrop)
                        task.wait(0.1)
                    else
                        -- Find closest valid living foe
                        local bestFoe = MURIM_LATE.cerberusFocus
                        local bestDist = bestFoe and -math.huge or math.huge
                        local hrpPos = hrp.Position


                        local npcsFolder = Workspace:FindFirstChild("Murim_NPCs")
                        if npcsFolder then
                            for _, npc in ipairs(npcsFolder:GetChildren()) do
                                if MURIM_RAID_HIT.canConsider(npc,currentRaidRoomIndex,isHallowFoe(npc)) and isAlive(npc) then
                                    local part = getNPCRootPart(npc)
                                    if part then
                                        local d = (part.Position - hrpPos).Magnitude
                                        if d <= 250 and isHallowEnemyInArea(part.Position,raidOrigin,currentRaidRoomIndex) then
                                            local nLow = npc.Name:lower()
                                            if nLow:find("cerberus") or nLow:find("matriarch") then
                                                d = d - 500
                                            elseif currentRaidRoomIndex==3 then
                                                d=MURIM_RAID_HIT.paperScore(npc,d)
                                            end
                                            if d < bestDist then
                                                bestDist = d
                                                bestFoe = npc
                                            end
                                        end
                                    end
                                end
                            end
                        end


                        if not bestFoe and activeRaidModel then
                            for _, desc in ipairs(activeRaidModel:GetDescendants()) do
                                if desc:IsA("Model") and MURIM_RAID_HIT.canConsider(desc,currentRaidRoomIndex,isHallowFoe(desc)) and isAlive(desc) then
                                    local part = getNPCRootPart(desc)
                                    if part then
                                        local d = (part.Position - hrpPos).Magnitude
                                        if d <= 250 and isHallowEnemyInArea(part.Position,raidOrigin,currentRaidRoomIndex) then
                                            local nLow = desc.Name:lower()
                                            if nLow:find("cerberus") or nLow:find("matriarch") then
                                                d = d - 500
                                            elseif currentRaidRoomIndex==3 then
                                                d=MURIM_RAID_HIT.paperScore(desc,d)
                                            end
                                            if d < bestDist then
                                                bestDist = d
                                                bestFoe = desc
                                            end
                                        end
                                    end
                                end
                            end
                        end


                        if currentRaidRoomIndex==3 and MURIM_RAID_HIT.eyes==1
                            and not MURIM_RAID_HIT.yardObjective then
                            -- Varredura forcada: teleporta a cada Paper, confirma HP
                            -- e persiste naquele que sofre dano; HUD decide a conclusao.
                            bestFoe=MURIM_RAID_HIT.selectLastEyePaper(hrp,raidOrigin)
                        end

                        if bestFoe and currentRaidRoomIndex==3
                            and (bestFoe.Name:lower():find("paper tailor",1,true)
                                or bestFoe.Name:lower():find("hg_tailor",1,true)) then
                            if MURIM_RAID_HIT.bossFocus~=bestFoe then
                                local oldBoss=MURIM_RAID_HIT.bossFocus
                                local oldRec=oldBoss and MURIM_RAID_HIT.records[oldBoss]
                                local newHum=bestFoe:FindFirstChildOfClass("Humanoid")
                                if oldRec and oldRec.didDamage and oldRec.hp>0 and newHum
                                    and newHum.Health>oldRec.hp+1500 then
                                    MURIM_TRACE.add("AVISO","TailorLeash",string.format(
                                        "Possivel reset/recriacao do Paper Tailor: alvo antigo visto com %.0f HP, novo com %.0f HP. Isto NAO comprova a causa; limitar afastamento.",
                                        oldRec.hp,newHum.Health))
                                end
                                MURIM_RAID_HIT.bossFocus=bestFoe
                                MURIM_TRACE.add("DECISAO","AutoA03","Paper Tailor selecionado: manter prioridade no chefe. Paper Effigy deixara de substituir este alvo enquanto chefe vivo.")
                            end
                            MURIM_A03.tailorEngaged=true
                        end
                        if MURIM_RAID_HIT.lastTarget~=bestFoe then
                            MURIM_RAID_HIT.onNoLongerTarget(MURIM_RAID_HIT.lastTarget)
                            MURIM_RAID_HIT.lastTarget=bestFoe
                        end
                        if bestFoe and isAlive(bestFoe) and currentRaidRoomIndex ~= 4
                            and (currentRaidRoomIndex~=3 or MURIM_RAID_HIT.eyes==nil or MURIM_RAID_HIT.eyes>0
                                or not bestFoe.Name:lower():find("paper effigy",1,true))
                            and MURIM_RAID_HIT.checkHealth(bestFoe,currentRaidRoomIndex) then
                            HallowEntryState.sawCombatInRoom = true
                            lastRaidCombatTime = os.clock()
                            local targetPart = getNPCRootPart(bestFoe)
                            if targetPart then
                                currentTarget = bestFoe
                                applyHitboxToNPC(bestFoe)
                                revealInvisibleNPC(bestFoe)


                                local isPaperTailor=currentRaidRoomIndex==3
                                    and (bestFoe.Name:lower():find("paper tailor",1,true)
                                        or bestFoe.Name:lower():find("hg_tailor",1,true))
                                local attackCF,canAttack=true,true
                                if isPaperTailor then
                                    attackCF,canAttack=MURIM_A03.tailorCombatPosition(hrp,targetPart,raidOrigin,activeRaidModel)
                                else
                                    attackCF=targetPart.CFrame*getFarmOffsetCFrame()
                                end
                                if attackCF then
                                    hrp.CFrame=attackCF
                                    hrp.AssemblyLinearVelocity=Vector3.zero
                                    hrp.AssemblyAngularVelocity=Vector3.zero
                                end


                                if canAttack and attackCF then
                                combatRemote = combatRemote or findCombatRemote()
                                if currentRaidRoomIndex == 1 then
                                    if combatRemote then
                                        MURIM_A01.observeCombat(bestFoe, true, pcall(function() combatRemote:FireServer("Attack") end))
                                    else
                                        MURIM_A01.observeCombat(bestFoe, false, false)
                                    end
                                else
                                    local hitSent = false
                                    if combatRemote then
                                        hitSent=pcall(function() combatRemote:FireServer("Attack") end)
                                    end
                                    MURIM_RAID_HIT.sent(bestFoe,currentRaidRoomIndex,combatRemote~=nil,hitSent)
                                end


                                if isAutoArtifact and os.clock() - lastArtifactUsed >= artifactCooldown then
                                    lastArtifactUsed = os.clock()
                                    useArtifact(targetPart.Position)
                                end
                                end -- Ataque do Tailor so dentro do perimetro seguro.


                                local bName = bestFoe.Name
                                local bLow = bName:lower()
                                local curRoom = HALLOW_ROOM_DATA[currentRaidRoomIndex]
                                local roomTitle = curRoom and curRoom.hz or ("Sala " .. tostring(currentRaidRoomIndex))
                                if hallowStatusLabel then
                                    if bLow:find("cerberus") then
                                        hallowStatusLabel.Text = string.format("🐕 [%d/10 %s] Derrotando chefe: Cerberus Jiangshi!", currentRaidRoomIndex, roomTitle)
                                    elseif bLow:find("matriarch") then
                                        hallowStatusLabel.Text = string.format("👑 [%d/10 %s] Derrotando chefe final: Hungry Ghost Matriarch!", currentRaidRoomIndex, roomTitle)
                                    else
                                        hallowStatusLabel.Text = string.format("⚔️ [%d/10 %s] Derrotando: %s", currentRaidRoomIndex, roomTitle, bName)
                                    end
                                end
                            end
                        else
                            -- Sem inimigos proximos: primeiro resolver interacoes conhecidas da A01.
                            local a01WorkPending = false
                            if HallowEntryState.verifiedRoomIndex == 1 then
                                a01WorkPending = MURIM_A01.tick(hrp, activeRaidModel, currentRaidRoomIndex, isHallowFoe, isAlive, raidOrigin)
                            end
                            local idleTime = os.clock() - lastRaidCombatTime


                            -- V16: prioridades por objetivo. Uma unica instancia; sem
                            -- teleportar pelo centro de modelos depois de 7s sem mobs.
                            if currentRaidRoomIndex == 2 then
                                if (HallowEntryState.furthestArea or 1)<3 then
                                    MURIM_A02.tick(player,hrp,activeRaidModel,raidOrigin)
                                else
                                    MURIM_TRACE.add("INFO","AutoA02","A03 ja alcancada: passagem A02 nao sera automatizada outra vez. Sem backtracking.",12)
                                end
                            elseif currentRaidRoomIndex == 3 then
                                -- A03 ja foi atualizada neste ciclo, inclusive com inimigos ativos.
                            elseif currentRaidRoomIndex >= 5 and currentRaidRoomIndex <= 10 then
                                MURIM_LATE.tick(hrp,activeRaidModel,raidOrigin,currentRaidRoomIndex)
                            end
                                if hallowStatusLabel then
                                    if not HallowEntryState.verifiedRoomIndex then
                                        hallowStatusLabel.Text = "⚠️ Na arena, mas sem sala confirmada. Tentando reconhecer a geometria; nao vou pular salas."
                                    elseif not HallowEntryState.sawCombatInRoom then
                                        hallowStatusLabel.Text = string.format("⏳ Sala %d/10: aguardando inimigos ou inicio da mecanica da sala...", currentRaidRoomIndex)
                                    else
                                        hallowStatusLabel.Text = string.format("⏳ Sala %d/10: procurando mais inimigos ou aguardando proxima etapa...", currentRaidRoomIndex)
                                    end
                                end
                                if currentRaidRoomIndex == 1 and HallowEntryState.sawCombatInRoom
                                    and not MURIM_A01.damageObserved and not MURIM_A01.defeatedObserved
                                    and os.clock() - HallowEntryState.lastNoDamageWarnAt > 12 then
                                    HallowEntryState.lastNoDamageWarnAt = os.clock()
                                    MURIM_TRACE.add("AVISO","CombateA01","Alvo selecionado anteriormente, mas sem dano/derrota observados. Bloqueado avanco para sala 2.")
                                end
                                if os.clock() - HallowEntryState.lastRaidWarningAt >= 20 then
                                    HallowEntryState.lastRaidWarningAt = os.clock()
                                    MURIM_TRACE.add("AVISO", "Sala", "Aguardando objetivo: area=" .. tostring(currentRaidRoomIndex)
                                        .. "; modelo confirmado=" .. tostring(HallowEntryState.verifiedRoomIndex ~= nil)
                                        .. "; combate visto=" .. tostring(HallowEntryState.sawCombatInRoom)
                                        .. "; inatividade=" .. string.format("%.1f", idleTime) .. "s. Sem inimigos detectados; pode haver mecanica de fase nao automatizada.")
                                end
                        end
                    end
                    end -- MURIM_RAID_DEFENSE: cancela combate, loot, prompts e navegacao ate curar
                end
            end
            task.wait(0.04)
        else
            MURIM_A04.cancelHold()
            MURIM_A04.stopRun()
            MURIM_LATE.stopWalk()
            if hallowStatusLabel and hallowStatusLabel.Text ~= "💤 Automação de Halloween desativada"
                and not isAutoHallowRaid and MURIM_TRACE.stage ~= "Pausado: queda detectada" then
                hallowStatusLabel.Text = "💤 Automação de Halloween desativada"
            end
            task.wait(0.5)
        end
    end
end)


-- 🛡️ Noclip SOMENTE no farm comum/boss.
-- Nunca desligar colisão do jogador durante a raid Halloween: na ausência
-- de inimigos ele não recebe novos CFrames e cai pelo piso da dungeon.
table.insert(externalConnections, RunService.Stepped:Connect(function()
    if (isFarming or isAutoFarmBoss) then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum and hum.Health > 0 then
                local st = hum:GetState()
                if st == Enum.HumanoidStateType.Freefall or st == Enum.HumanoidStateType.FallingDown then
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                end
            end
        end
    end
end))


-- Evento do botão que abre e fecha a interface
toggleBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        if mainFrame.Visible then refreshNPCList() end
end)


closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
startBtn.MouseButton1Click:Connect(function() startFarming() end)
stopBtn.MouseButton1Click:Connect(function()
    stopAll()
    if hubUI.stopWorkshop then hubUI.stopWorkshop() end
end)
local function cleanup()
    if destroyed then return end
    destroyed = true
    MURIM_A04.cancelHold()
    MURIM_A04.stopRun()
    MURIM_LATE.stopWalk()
    MURIM_TRACE.active = false
    MURIM_TRACE.add("INFO", "Fim", "Interface destruida: automacoes encerradas.")
    stopAll()
    if isParrying and combatRemote then
        pcall(function() combatRemote:FireServer("ParryUp", nil) end)
    end
    isParrying = false
    if artifactTask then task.cancel(artifactTask) artifactTask = nil end
    if hallowRaidTask then task.cancel(hallowRaidTask) hallowRaidTask = nil end
    restoreHitboxes()
    for _, conn in ipairs(folderConnections) do conn:Disconnect() end
    for _, conn in ipairs(externalConnections) do conn:Disconnect() end
    table.clear(folderConnections)
    table.clear(externalConnections)
end
screenGui.Destroying:Connect(cleanup)
destroyBtn.MouseButton1Click:Connect(function()
    cleanup()
    screenGui:Destroy()
end)
-- The supplied main window remains the only visible menu.
hubUI.gui = screenGui
hubUI.frame = mainFrame
hubUI.stopFarm = stopAll
hubUI.refresh = refreshNPCList
hubUI.debugHallowFoe = isHallowFoe -- somente leitura para diagnostico
hubUI.debugIsAlive = isAlive
return hubUI


end

-- Aba de diagnostico: toda a GUI e as funcoes locais vivem fora de buildMaster.
-- Isso evita ultrapassar o limite de 200 locais do compilador Luau.
local function installMurimDiagnostics(host)
    local page = host.makePage("Diagnostics", 10, "🧾 Logs")
    local function textNode(className, name, y, h, value, parent)
        local element = Instance.new(className)
        element.Name = name
        element.Position = UDim2.new(0, 10, 0, y)
        element.Size = UDim2.new(1, -20, 0, h)
        element.BackgroundTransparency = className == "TextLabel" and 1 or 0
        element.Text = value
        element.TextWrapped = true
        element.TextColor3 = Color3.fromRGB(237, 242, 250)
        element.TextSize = 13
        element.Font = Enum.Font.Gotham
        element.Parent = parent or page
        return element
    end
    local header = textNode("TextLabel", "Header", 8, 28, "🧾 Diagnostico: Halloween / Guest Ledger", page)
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = Enum.TextXAlignment.Left
    local help = textNode("TextLabel", "Help", 37, 55,
        "V18S: A04 sem Hide automatico; diagnostico recente <12 KB, erro A04 detalhado; demais areas iguais.", page)
    help.TextXAlignment = Enum.TextXAlignment.Left
    help.TextSize = 11

    local autoA01Btn = Instance.new("TextButton")
    autoA01Btn.Name = "AutoA01Toggle"
    autoA01Btn.Position = UDim2.fromOffset(10, 94)
    autoA01Btn.Size = UDim2.new(1, -20, 0, 32)
    autoA01Btn.TextColor3 = Color3.new(1, 1, 1)
    autoA01Btn.Font = Enum.Font.GothamBold
    autoA01Btn.TextSize = 12
    autoA01Btn.Parent = page
    Instance.new("UICorner", autoA01Btn).CornerRadius = UDim.new(0, 7)
    local function refreshA01Toggle()
        autoA01Btn.Text = MURIM_A01.enabled and "Auto interacoes A01: LIGADO" or "Auto interacoes A01: DESLIGADO"
        autoA01Btn.BackgroundColor3 = MURIM_A01.enabled and Color3.fromRGB(28, 115, 77) or Color3.fromRGB(120, 60, 61)
    end
    refreshA01Toggle()
    autoA01Btn.Activated:Connect(function()
        MURIM_A01.enabled = not MURIM_A01.enabled
        if not MURIM_A01.enabled then MURIM_A01.pending = nil end
        refreshA01Toggle()
        MURIM_TRACE.add("ACAO", "AutoA01", "Interacoes automaticas " .. (MURIM_A01.enabled and "ligadas" or "desligadas") .. ".")
    end)
    local buttonRow = Instance.new("Frame")
    buttonRow.Name = "Actions"
    buttonRow.BackgroundTransparency = 1
    buttonRow.Position = UDim2.fromOffset(9, 132)
    buttonRow.Size = UDim2.new(1, -18, 0, 46)
    buttonRow.Parent = page
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 5)
    layout.Parent = buttonRow
    local function action(name, text)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(1 / 4, -4, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(54, 70, 107)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextSize = 12
        btn.TextWrapped = true
        btn.Parent = buttonRow
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        return btn
    end
    local copyBtn = action("Copy", "Copiar log")
    local saveBtn = action("Save", "Salvar TXT")
    local inspectBtn = action("Inspect", "Inspecionar raid")
    -- Mobile: manter Mapear ao lado de Inspecionar, na MESMA fileira visivel.
    -- O botao anterior ficava na linha abaixo e podia sumir sob o layout do celular.
    local mapBtn = action("MapEntireDungeon", "Mapear dungeon")
    mapBtn.BackgroundColor3 = Color3.fromRGB(35, 105, 105)
    mapBtn.TextSize = 11
    local feedback = textNode("TextLabel", "Feedback", 183, 28,
        "Toque MAPEAR DUNGEON para gerar o relatorio; depois COPIAR LOG.", page)
    feedback.TextSize = 11
    feedback.TextColor3 = Color3.fromRGB(184, 207, 240)
    feedback.TextXAlignment = Enum.TextXAlignment.Left

    local list = Instance.new("ScrollingFrame")
    list.Name = "LogList"
    list.Position = UDim2.fromOffset(9, 217)
    list.Size = UDim2.new(1, -18, 1, -227)
    list.BackgroundColor3 = Color3.fromRGB(17, 21, 31)
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 6
    list.ScrollingEnabled = true
    list.Active = true
    list.ScrollingDirection = Enum.ScrollingDirection.Y
    list.CanvasSize = UDim2.fromOffset(0, 400)
    list.Parent = page
    Instance.new("UICorner", list).CornerRadius = UDim.new(0, 7)
    local output = Instance.new("TextLabel")
    output.Name = "LogText"
    output.Size = UDim2.new(1, -14, 0, 300)
    output.Position = UDim2.fromOffset(7, 7)
    output.BackgroundTransparency = 1
    output.Font = Enum.Font.Code
    output.TextSize = 12
    output.TextColor3 = Color3.fromRGB(209, 223, 237)
    output.TextWrapped = true
    output.TextXAlignment = Enum.TextXAlignment.Left
    output.TextYAlignment = Enum.TextYAlignment.Top
    output.Parent = list
    local pending = false
    local function redraw()
        if not page.Parent or pending then return end
        pending = true
        task.defer(function()
            pending = false
            if not page.Parent then return end
            output.Text = MURIM_TRACE.tail(95)
            help.Text = "Proximo teste: " .. tostring(MURIM_TRACE.nextAction):sub(1, 150)
            local needed = math.max(260, output.TextBounds.Y + 30)
            output.Size = UDim2.new(1, -14, 0, needed)
            list.CanvasSize = UDim2.fromOffset(0, needed + 14)
            -- Mantem o scroll atual quando estiver lendo mensagens anteriores.
        end)
    end
    table.insert(MURIM_TRACE.listeners, redraw)
    redraw()

    copyBtn.Activated:Connect(function()
        local content = MURIM_TRACE.dump(12000)
        local copy = setclipboard or toclipboard
        if type(copy) == "function" then
            local ok, err = pcall(copy, content)
            feedback.Text = ok and "✅ Log RECENTE copiado (<12 KB); cole na conversa. Salvar TXT guarda o historico completo." or ("⚠️ Copia falhou: " .. tostring(err))
        else
            feedback.Text = "⚠️ Executor sem setclipboard. Tente Salvar TXT."
        end
    end)
    saveBtn.Activated:Connect(function()
        if type(writefile) ~= "function" then
            feedback.Text = "⚠️ Executor sem writefile. Use Copiar log."
            return
        end
        local path = "MurimHubLogs/murim_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
        local ok, err = pcall(function()
            if type(makefolder) == "function" then
                if type(isfolder) ~= "function" or not isfolder("MurimHubLogs") then
                    makefolder("MurimHubLogs")
                end
            end
            writefile(path, MURIM_TRACE.dump())
        end)
        feedback.Text = ok and ("✅ Salvo no executor: " .. path)
            or ("⚠️ Nao foi possivel salvar: " .. tostring(err))
    end)
    mapBtn.Activated:Connect(function()
        if MURIM_SURVEY.running then
            feedback.Text = "Auditoria ainda em andamento..."
            return
        end
        feedback.Text = "Mapeando apenas areas carregadas; nenhum movimento sera executado."
        task.spawn(function()
            local player = game:GetService("Players").LocalPlayer
            local success = MURIM_SURVEY.run(player)
            if page.Parent then
                feedback.Text = success and "Mapa pronto! Use Copiar log: relatorio completo ao final."
                    or "Mapa falhou. Consulte os avisos e entre na raid."
            end
        end)
    end)
    inspectBtn.Activated:Connect(function()
        MURIM_TRACE.add("INFO", "GUI", "Inspecao manual iniciada.")
        local player = game:GetService("Players").LocalPlayer
        local pg = player and player:FindFirstChild("PlayerGui")
        local dlg = pg and pg:FindFirstChild("MurimDialog", true)
        local panel = dlg and dlg:FindFirstChild("Panel", true)
        if not dlg then
            MURIM_TRACE.add("AVISO", "GUI", "MurimDialog nao existe no PlayerGui.")
        elseif not panel then
            MURIM_TRACE.add("AVISO", "GUI", "MurimDialog existe; Panel nao encontrado.")
        else
            MURIM_TRACE.add("INFO", "GUI", "MurimDialog.Panel visivel=" .. tostring(isHallowGuiVisible(panel)))
            local count = 0
            for _, desc in ipairs(panel:GetDescendants()) do
                if desc:IsA("GuiButton") and isHallowGuiVisible(desc) then
                    local btnText = desc:IsA("TextButton") and desc.Text or "[ImageButton]"
                    MURIM_TRACE.add("INFO", "GUI", "Botao: " .. tostring(desc.Name):sub(1, 50)
                        .. " | " .. tostring(btnText):gsub("[\r\n]+", " "):sub(1, 70))
                    count += 1
                    if count >= 18 then break end
                end
            end
            if count == 0 then MURIM_TRACE.add("AVISO", "GUI", "Nenhum botao visivel no Panel.") end
        end
        local prompt, part = findGuestLedger()
        MURIM_TRACE.add("INFO", "Livro", "Guest Ledger encontrado=" .. tostring(part ~= nil)
            .. " | Prompt=" .. tostring(prompt ~= nil)
            .. (prompt and (" | Enabled=" .. tostring(prompt.Enabled)
            .. " | Hold=" .. tostring(prompt.HoldDuration)) or ""))
        local character = player and player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            local activeModel, origin = getActiveRaidInfo(player)
            local index, reason = detectRoomIndexFromPosition(root.Position, origin, activeModel)
            MURIM_TRACE.add("INFO", "Sala", string.format("Inspecao: pos=(%.0f, %.0f, %.0f) | origem=(%.0f,%.0f,%.0f) | modelo=%s | sala=%s | motivo=%s",
                root.Position.X, root.Position.Y, root.Position.Z,
                origin.X, origin.Y, origin.Z,
                activeModel and activeModel.Name or "ausente",
                tostring(index or "desconhecida"), reason))
        end
        -- Inclui censo do ambiente e candidatos a inimigo, sem modificar o mundo.
        local ok, err = pcall(function() inspectHalloweenWorld(player, host.debugHallowFoe, host.debugIsAlive) end)
        if not ok then MURIM_TRACE.add("ERRO", "Censo", "Falha na inspecao: " .. tostring(err)) end
        feedback.Text = "✅ Diagnostico atualizado. Copie o log e teste o proximo passo."
    end)
    -- Escuta interacoes REAIS do jogador nos prompts da raid. Nao ativa prompts.
    local serviceOK, promptService = pcall(function()
        return game:GetService("ProximityPromptService")
    end)
    if serviceOK and promptService then
        local connection = promptService.PromptTriggered:Connect(function(prompt, triggeringPlayer)
            if triggeringPlayer and triggeringPlayer ~= game:GetService("Players").LocalPlayer then return end
            if not prompt or not prompt.Parent then return end
            -- Registra acionamentos em TODAS as areas A01..A10, sem acionar nada.
            pcall(MURIM_SURVEY.notePromptTriggered, prompt)
            local inA01 = false
            local node = prompt.Parent
            while node do
                if node.Name == "A01_Causeway" then inA01 = true; break end
                node = node.Parent
            end
            if not inA01 then return end
            local action = tostring(prompt.ActionText or "")
            local target = tostring(prompt.ObjectText or "")
            local automatic = MURIM_A01.onPromptTriggered(prompt)
            MURIM_TRACE.add("ACAO", automatic and "Interacao automatica A01" or "Interacao manual A01",
                "Prompt acionado: " .. action:sub(1, 70) .. " / " .. target:sub(1, 70)
                .. ". Isso nao confirma aceite pelo servidor.")
            local low = action:lower()
            if not automatic and low:find("refill", 1, true) then
                MURIM_TRACE.lastA01Action = "refill"
                MURIM_TRACE.suggest("Oil Jar acionado. Confira se a lanterna/objetivo mudou; inspecione a raid novamente. Se nao houve efeito, relate a mensagem da tela; Offering Bowl e outra interacao disponivel.")
            elseif not automatic and low:find("offering", 1, true) then
                MURIM_TRACE.lastA01Action = "offering"
                MURIM_TRACE.suggest("Offering Bowl acionado. Confira se o objetivo ou a passagem mudou; inspecione a raid novamente. Interacao registrada nao comprova fase concluida.")
            end
        end)
        page.Destroying:Connect(function() connection:Disconnect() end)
    else
        MURIM_TRACE.add("AVISO", "Interacao", "Servico de ProximityPrompt indisponivel; interacoes manuais podem nao aparecer no log.")
    end
    task.spawn(function()
        while page.Parent do
            task.wait(7)
            if MURIM_TRACE.active and os.clock() - MURIM_TRACE.lastStageAt >= 20 then
                MURIM_TRACE.add("AVISO", "Sem progresso",
                    "Nenhuma mudanca de etapa ha 20s. Estado: " .. MURIM_TRACE.stage
                    .. ". Toque em Inspecionar raid para identificar inimigos e objetos.", 25)
            end
        end
    end)
    MURIM_TRACE.add("INFO", "Painel", "Aba Logs instalada. Sao 10 abas no total. Botao Mapear dungeon ao lado de Inspecionar raid.")
end

-- Correção isolada da barra superior, sem aumentar os locais de buildMaster.
local function installMobileTabNavigation(host)
    local gui = host and host.gui
    local frame = gui and gui:FindFirstChild("MainFrame")
    local bar = frame and frame:FindFirstChild("Tabs")
    if not bar then return end
    local UIS = game:GetService("UserInputService")
    local STEP = 110
    bar.Position = UDim2.fromOffset(43, 60)
    bar.Size = UDim2.new(1, -86, 0, 49)
    bar.ScrollBarThickness = 4
    bar.ElasticBehavior = Enum.ElasticBehavior.Never
    bar.Active = true
    -- Desativa a rolagem elástica nativa, usando gesto manual que não retorna.
    bar.ScrollingEnabled = false
    bar.CanvasSize = UDim2.fromOffset(math.max(10 * STEP + 8, bar.CanvasSize.X.Offset), 0)

    local function setOffset(value)
        local limit = math.max(0, bar.CanvasSize.X.Offset - bar.AbsoluteSize.X)
        bar.CanvasPosition = Vector2.new(math.clamp(value, 0, limit), 0)
    end
    local function arrow(caption, xScale, xOffset, direction)
        local btn = Instance.new("TextButton")
        btn.Name = direction < 0 and "TabPrevious" or "TabNext"
        btn.Size = UDim2.fromOffset(30, 42)
        btn.Position = UDim2.new(xScale, xOffset, 0, 63)
        btn.Text = caption
        btn.TextSize = 22
        btn.Font = Enum.Font.GothamBold
        btn.BackgroundColor3 = Color3.fromRGB(43, 54, 75)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Parent = frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.Activated:Connect(function() setOffset(bar.CanvasPosition.X + direction * STEP * 2) end)
    end
    arrow("‹", 0, 8, -1)
    arrow("›", 1, -38, 1)

    local activeTouch, startedX, startOffset, dragged = nil, 0, 0, false
    local function beginTouch(input)
        if input.UserInputType ~= Enum.UserInputType.Touch or activeTouch then return end
        activeTouch = input
        startedX = input.Position.X
        startOffset = bar.CanvasPosition.X
        dragged = false
    end
    bar.InputBegan:Connect(beginTouch)
    for _, child in ipairs(bar:GetChildren()) do
        if child:IsA("GuiButton") then
            child.InputBegan:Connect(beginTouch)
        end
    end
    local onMove = UIS.InputChanged:Connect(function(input)
        if input == activeTouch then
            local distance = input.Position.X - startedX
            if math.abs(distance) >= 8 then
                dragged = true
                setOffset(startOffset - distance)
            end
        end
    end)
    local onRelease = UIS.InputEnded:Connect(function(input)
        if input == activeTouch then
            if dragged then bar:SetAttribute("NavIgnoreUntil", os.clock() + 0.3) end
            activeTouch = nil
        end
    end)
    gui.Destroying:Connect(function()
        onMove:Disconnect()
        onRelease:Disconnect()
    end)
    print("[Murim PTBR V4] Barra de abas mobile instalada")
end

local function mountWorkshop(host)
-- Murim Workshop: Alchemy + Forge. Run this entire file as one script.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")


_G.ArtificeAuto = false


if _G.ArtificeTapConnection then
    _G.ArtificeTapConnection:Disconnect()
    _G.ArtificeTapConnection = nil
end


local function need(parent, name)
    local item = parent:FindFirstChild(name) or parent:WaitForChild(name, 5)
    assert(item, "Não foi encontrado " .. parent.Name .. "." .. name .. " em até 5 segundos")
    return item
end
local remotes = need(need(RS, "Murim"), "Remotes")
local remote = need(remotes, "Artifice")
local forgeRemote = need(remotes, "ArtificeRequest")
local alchemyRequest = need(remotes, "AlchemyRequest")
local minigameRemote = need(remotes, "Minigame")
local alchemyAuto, alchemyHit, alchemyBusy = false, false, false
local alchemyActive, alchemyPending, generalMinigameActive = false, false, false
local alchemyPendingAt, alchemyNextAt, alchemyCount, beatVersion = 0, 0, 0, 0
local alchemyRequestVersion = 0
local refreshAlchemy
local breakthroughEnabled, breakthroughToken = false, 0
local qiAuto, tribAuto, minorAuto = false, false, true
local minorHitCount, minorTotalHits = 0, 0
local cultStatus, cultResult, cultCounter, updateCultCounter
local cultivationPhase
local cultRemote = need(remotes, "Cultivation")
local refreshBreakthrough
local enabled, closed = false, false
local connections = {}
local sent = setmetatable({}, { __mode = "k" })
local sentCount, successCount, missedCount = 0, 0, 0
local lastId
local forgeEnabled, forgeBusy, awaitingGame, gameActive = false, false, false, false
local awaitingSince, nextForgeAt, forgeCount = 0, 0, 0
local MAX_ATTEMPTS, RETRY_DELAY = 3, 0.2


local function connect(signal, callback)
    local c = signal:Connect(callback)
    connections[#connections + 1] = c
    return c
end
local function create(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties) do object[key] = value end
    object.Parent = parent
    return object
end


local gui = host.gui
local panel = create("Frame", {
    Visible = false, Size = UDim2.fromOffset(330, 435), Position = UDim2.new(0.5, -165, 0.12, 0),
    BackgroundColor3 = Color3.fromRGB(28, 28, 34), BorderSizePixel = 0,
}, gui)
create("UICorner", { CornerRadius = UDim.new(0, 12) }, panel)
create("UIStroke", { Color = Color3.fromRGB(195, 159, 77), Thickness = 1.5 }, panel)
local function label(text, y, height, color)
    return create("TextLabel", {
        Position = UDim2.fromOffset(14, y), Size = UDim2.new(1, -28, 0, height),
        BackgroundTransparency = 1, Text = text, TextSize = 14,
        TextColor3 = color or Color3.fromRGB(225, 225, 230),
        Font = Enum.Font.Gotham, TextWrapped = true,
    }, panel)
end
local title = label("Artifice Auto", 0, 42, Color3.fromRGB(235, 205, 132))
title.Size = UDim2.new(1, -65, 0, 42)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
local close = create("TextButton", {
    Position = UDim2.new(1, -42, 0, 4), Size = UDim2.fromOffset(36, 36),
    BackgroundTransparency = 1, Text = "×", TextSize = 28,
    TextColor3 = Color3.fromRGB(255, 115, 115), Font = Enum.Font.GothamBold,
}, panel)
local function makeButton(text, y, color)
    local b = create("TextButton", {
        Position = UDim2.fromOffset(14, y), Size = UDim2.new(1, -28, 0, 42),
        BackgroundColor3 = color, BorderSizePixel = 0, Text = text, TextSize = 17,
        TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold,
    }, panel)
    create("UICorner", { CornerRadius = UDim.new(0, 8) }, b)
    return b
end
local toggle = makeButton("Ativar cliques automáticos", 50, Color3.fromRGB(57, 132, 89))
local status = label("Status: parado", 100, 28)
label("Menores números primeiro • ignora a cor [255, 80, 40]", 130, 26, Color3.fromRGB(235, 205, 132))
label("Até 3 tentativas / intervalo de 0,2 segundo", 157, 24)
local skipped = label("Números ignorados: -", 183, 45, Color3.fromRGB(255, 145, 125))
local lastLabel = label("Último envio: -", 231, 24)
local counter = label("Enviados: 0 | Sucessos: 0 | Perdidos: 0", 258, 24)
local resultLabel = label("Resultado do jogo: nenhum ainda", 285, 28)
local forgeButton = makeButton("Ativar forja automática", 326, Color3.fromRGB(66, 105, 165))
local forgeStatus = label("Forja: parada", 373, 48)


local dragArea = create("Frame", {
    Size = UDim2.new(1, -50, 0, 42), BackgroundTransparency = 1, Active = true, ZIndex = 5,
}, panel)
local dragInput, dragStart, panelStart
connect(dragArea.InputBegan, function(input)
    if closed or dragInput then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragInput, dragStart, panelStart = input, input.Position, panel.Position
    end
end)
connect(UIS.InputChanged, function(input)
    if closed or not dragInput then return end
    local mouse = dragInput.UserInputType == Enum.UserInputType.MouseButton1
    if (mouse and input.UserInputType == Enum.UserInputType.MouseMovement) or input == dragInput then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(panelStart.X.Scale, panelStart.X.Offset + delta.X,
            panelStart.Y.Scale, panelStart.Y.Offset + delta.Y)
    end
end)
connect(UIS.InputEnded, function(input) if input == dragInput then dragInput = nil end end)
connect(UIS.WindowFocusReleased, function() dragInput = nil end)


local cleanup
local function stopConnections()
    closed, enabled, forgeEnabled = true, false, false
    breakthroughEnabled = false
    qiAuto, tribAuto = false, false
    breakthroughToken += 1
    alchemyAuto, alchemyHit = false, false
    beatVersion += 1
    dragInput = nil
    for _, c in ipairs(connections) do c:Disconnect() end
    table.clear(connections)
    if _G.ArtificeGuiCleanup == cleanup then _G.ArtificeGuiCleanup = nil end
end
cleanup = function()
    if closed then return end
    stopConnections()
    gui:Destroy()
end
_G.ArtificeGuiCleanup = cleanup
connect(close.Activated, cleanup)
connect(gui.Destroying, function() if not closed then stopConnections() end end)
local function paintTap()
    toggle.Text = enabled and "Parar cliques automáticos" or "Ativar cliques automáticos"
    toggle.BackgroundColor3 = enabled and Color3.fromRGB(165, 66, 66) or Color3.fromRGB(57, 132, 89)
end
connect(toggle.Activated, function() enabled = not enabled; paintTap() end)


local function getMotes(requireVisible)
    local gameGui = playerGui:FindFirstChild("MurimArtificeGame")
    if not gameGui or not gameGui:IsA("ScreenGui") then return nil end
    if requireVisible and not gameGui.Enabled then return nil end
    local current = gameGui
    for _, name in ipairs({ "Sheet", "Area", "Face", "Motes" }) do
        current = current:FindFirstChild(name)
        if not current then return nil end
        if requireVisible and current:IsA("GuiObject") and not current.Visible then return nil end
    end
    return current
end
local function gameIsVisible()
    local g = playerGui:FindFirstChild("MurimArtificeGame")
    return g and g:IsA("ScreenGui") and g.Enabled
end
local function getId(button)
    if not button:IsA("TextButton") then return nil end
    return tonumber(button.Name:match("^Mote(%d+)$"))
end
local function classify(button)
    local id = getId(button)
    if not id then return nil end
    local c = button.BackgroundColor3
    local r, g, b = math.round(c.R * 255), math.round(c.G * 255), math.round(c.B * 255)
    if r == 255 and g == 80 and b == 40 then return id, "skip" end
    if (r == 255 and g == 240 and b == 190) or (r == 58 and g == 52 and b == 50) then return id, "tap" end
    return id, "unknown"
end
local function updateCounter()
    counter.Text = string.format("Enviados: %d | Sucessos: %d | Perdidos: %d", sentCount, successCount, missedCount)
end
local function paintForge()
    forgeButton.Text = forgeEnabled and "Parar forja automática" or "Ativar forja automática"
    forgeButton.BackgroundColor3 = forgeEnabled and Color3.fromRGB(165, 66, 66) or Color3.fromRGB(66, 105, 165)
end
local function stopForge(message)
    forgeEnabled = false
    paintForge()
    forgeStatus.Text = message
end
connect(forgeButton.Activated, function()
    if forgeEnabled then stopForge("Forja: novas rodadas interrompidas"); return end
    if awaitingGame and not forgeBusy and os.clock() - awaitingSince > 10 then
        forgeStatus.Text = "Forja: pedido anterior ainda não confirmado"
        return
    end
    alchemyAuto = false
    alchemyRequestVersion += 1
    if refreshAlchemy then refreshAlchemy() end
    forgeEnabled, enabled = true, true
    paintForge()
    paintTap()
    forgeStatus.Text = "Forja: aguardando início / fim da rodada atual"
end)


connect(remote.OnClientEvent, function(data)
    if closed or type(data) ~= "table" or data.valley then return end
    if data.op == "Game" then
        gameActive, awaitingGame = true, false
        if forgeEnabled then forgeStatus.Text = "Forja: jogando a rodada atual" end
        return
    elseif data.op == "End" then
        gameActive, awaitingGame = false, false
        nextForgeAt = os.clock() + 3.2
        if forgeEnabled then forgeStatus.Text = "Forja: rodada concluída, aguardando a próxima" end
        return
    end
    if data.op ~= "Mote" then return end
    local motes = getMotes(false)
    local button = motes and motes:FindFirstChild("Mote" .. tostring(data.i))
    local alreadyFinished = button and sent[button] == true
    if button then sent[button] = true end
    if not alreadyFinished then
        if data.r == "got" or data.r == "struck" then successCount += 1
        elseif data.r == "sank" then missedCount += 1 end
    end
    local names = { got = "Coletado com sucesso", struck = "Acerto realizado", burnt = "Atingiu o quadrado vermelho", sank = "Perdido / fora do tempo" }
    resultLabel.Text = "Mote" .. tostring(data.i) .. ": " .. (names[data.r] or tostring(data.r))
    updateCounter()
end)


local nextDisplayUpdate = 0
connect(RunService.Heartbeat, function()
    if closed then return end
    local motes = getMotes(true)
    if not motes then
        local tSkip = "Números ignorados: -"
        local tStat = enabled and "Status: aguardando minijogo" or "Status: parado"
        if skipped.Text ~= tSkip then skipped.Text = tSkip end
        if status.Text ~= tStat then status.Text = tStat end
        return
    end
    local entries, skipIds = {}, {}
    local unknownCount = 0
    for _, button in ipairs(motes:GetChildren()) do
        local id = getId(button)
        if id then entries[#entries + 1] = { id = id, button = button } end
    end
    table.sort(entries, function(a, b) return a.id < b.id end)
    for _, entry in ipairs(entries) do
        local button = entry.button
        if button.Parent ~= motes then continue end
        local id, kind = classify(button)
        if kind == "skip" then skipIds[#skipIds + 1] = id
        elseif kind == "unknown" and button.Visible then unknownCount += 1
        elseif kind == "tap" and enabled and button.Visible then
            local now, attempt = os.clock(), sent[button]
            if attempt ~= true then
                local first = attempt == nil
                local retry = type(attempt) == "table" and attempt.count < MAX_ATTEMPTS and now - attempt.last >= RETRY_DELAY
                if first or retry then
                    sent[button] = { count = first and 1 or attempt.count + 1, last = now }
                    remote:FireServer({ op = "Tap", i = id })
                    sentCount += 1
                    lastId = id
                end
            end
        end
    end
    local now = os.clock()
    if now < nextDisplayUpdate then return end
    nextDisplayUpdate = now + 0.1
    local display = {}
    for index, id in ipairs(skipIds) do
        if index > 20 then display[#display + 1] = "…"; break end
        display[#display + 1] = tostring(id)
    end
    local newSkip = "Números ignorados: " .. (#display > 0 and table.concat(display, ", ") or "-")
    if skipped.Text ~= newSkip then skipped.Text = newSkip end
    local newStat = enabled and (unknownCount > 0 and ("Em execução • cores fora do critério: " .. unknownCount .. " pontos") or "Status: automação em execução") or "Status: parado • apenas verifica números"
    if status.Text ~= newStat then status.Text = newStat end
    local newLast = "Último envio: " .. (lastId and ("Mote" .. lastId) or "-")
    if lastLabel.Text ~= newLast then lastLabel.Text = newLast end
    updateCounter()
end)


connect(RunService.Heartbeat, function()
    if closed or not forgeEnabled then return end
    if not enabled then
        local tFStat = "Forja: pausada, ative os cliques automáticos"
        if forgeStatus.Text ~= tFStat then forgeStatus.Text = tFStat end
        return
    end
    if forgeBusy then return end
    if awaitingGame then
        if os.clock() - awaitingSince > 10 then stopForge("Forja: sinal de início não recebido; novas tentativas suspensas") end
        return
    end
    if gameActive or gameIsVisible() or os.clock() < nextForgeAt then return end
    if cultivationPhase or alchemyBusy or alchemyPending or alchemyActive or generalMinigameActive then
        local tFStat = "Forja: aguardando outro minijogo terminar"
        if forgeStatus.Text ~= tFStat then forgeStatus.Text = tFStat end
        return
    end
    forgeBusy, awaitingGame = true, true
    awaitingSince = os.clock()
    forgeStatus.Text = "Forja: solicitando início de rodada..."
    task.spawn(function()
        if closed or not forgeEnabled or not enabled or cultivationPhase or alchemyBusy or alchemyPending or alchemyActive or generalMinigameActive then
            forgeBusy, awaitingGame = false, false
            return
        end
        local ok, accepted, message = pcall(function()
            return forgeRemote:InvokeServer("Forge", {
                recipe = "D6", flame = "WitheringEmber",
                core = { id = "WitheredSoulCore", grade = 1 },
            })
        end)
        forgeBusy = false
        if closed then return end
        if not ok then stopForge("Forja: falha de comunicação — " .. tostring(accepted)); return end
        if not accepted then
            awaitingGame = false
            stopForge("Forge: " .. tostring(message or "Servidor rejeitou a solicitação"))
            return
        end
        forgeCount += 1
        if forgeEnabled then
            forgeStatus.Text = "Forja: solicitação aceita, " .. forgeCount .. " rodadas" .. (awaitingGame and " aguardando início" or "")
        end
    end)
end)




-- Unified interface: preserve the working Forge controls inside their own tab.
panel.Size = UDim2.fromOffset(360, 545)
panel.Position = UDim2.new(0.5, -180, 0.5, -272)
title.Text = "Murim Workshop v4"
title.Size = UDim2.new(1, -110, 0, 42)
dragArea.Size = UDim2.new(1, -100, 0, 42)
local oldControls = {}
for _, child in ipairs(panel:GetChildren()) do
    if child:IsA("GuiObject") and child ~= title and child ~= close and child ~= dragArea then
        oldControls[#oldControls + 1] = child
    end
end
local forgePage = create("Frame", {
    Name = "ForgePage", Position = UDim2.fromOffset(0, 96),
    Size = UDim2.new(1, 0, 0, 390), BackgroundTransparency = 1,
}, panel)
for _, child in ipairs(oldControls) do
    child.Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset,
        child.Position.Y.Scale, child.Position.Y.Offset - 50)
    child.Parent = forgePage
end
local alchemyPage = create("Frame", {
    Name = "AlchemyPage", Position = UDim2.fromOffset(0, 96),
    Size = UDim2.new(1, 0, 0, 390), BackgroundTransparency = 1, Visible = false,
}, panel)
local function pageLabel(parent, text, y, height, size)
    return create("TextLabel", {
        Position = UDim2.fromOffset(14, y), Size = UDim2.new(1, -28, 0, height),
        BackgroundTransparency = 1, Text = text, TextWrapped = true,
        TextSize = size or 14, Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(225, 225, 230),
    }, parent)
end
local function pageButton(parent, text, y, height)
    local b = create("TextButton", {
        Position = UDim2.fromOffset(14, y), Size = UDim2.new(1, -28, 0, height or 40),
        BackgroundColor3 = Color3.fromRGB(54, 65, 82), BorderSizePixel = 0,
        Text = text, TextWrapped = true, TextSize = 15,
        TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold,
    }, parent)
    create("UICorner", { CornerRadius = UDim.new(0, 8) }, b)
    return b
end
local breakthroughPage = create("Frame", {
    Name = "BreakthroughPage", Position = UDim2.fromOffset(0, 96),
    Size = UDim2.new(1, 0, 0, 390), BackgroundTransparency = 1, Visible = false,
}, panel)
local tabAlchemy = pageButton(panel, "Alquimia", 49, 36)
local tabForge = pageButton(panel, "Forge", 49, 36)
local tabBreakthrough = pageButton(panel, "Avanço de nível", 49, 36)
for index, tab in ipairs({ tabAlchemy, tabForge, tabBreakthrough }) do
    tab.Position = UDim2.new((index - 1) / 3, 8, 0, 49)
    tab.Size = UDim2.new(1 / 3, -16, 0, 36)
end
local function selectTab(name)
    alchemyPage.Visible = name == "alchemy"
    forgePage.Visible = name == "forge"
    breakthroughPage.Visible = name == "breakthrough"
    tabAlchemy.BackgroundColor3 = alchemyPage.Visible and Color3.fromRGB(52, 125, 102) or Color3.fromRGB(54, 65, 82)
    tabForge.BackgroundColor3 = forgePage.Visible and Color3.fromRGB(150, 112, 48) or Color3.fromRGB(54, 65, 82)
    tabBreakthrough.BackgroundColor3 = breakthroughPage.Visible and Color3.fromRGB(75, 100, 170) or Color3.fromRGB(54, 65, 82)
end
connect(tabAlchemy.Activated, function() selectTab("alchemy") end)
connect(tabForge.Activated, function() selectTab("forge") end)
connect(tabBreakthrough.Activated, function() selectTab("breakthrough") end)


-- The requested recipe is already present in the supplied script; keep one copy.
local recipes = {
    { name = "1. FrostMoss ×2 + SpiritGrass ×1", ings = {
        { id = "FrostMoss" }, { id = "FrostMoss" }, { id = "SpiritGrass" },
    } },
    { name = "2. Ginseng ×1 + SpiritGrass ×1", ings = {
        { id = "Ginseng" }, { id = "SpiritGrass" },
    } },
}
local selectedRecipe = 1
local recipeButtons = {}
pageLabel(alchemyPage, "Selecione a receita de alquimia (clique para escolher)", 0, 25, 16)
for index, recipe in ipairs(recipes) do
    local recipeIndex = index
    local b = pageButton(alchemyPage, recipe.name, 31 + (index - 1) * 47, 41)
    recipeButtons[index] = b
    connect(b.Activated, function()
        selectedRecipe = recipeIndex
        if refreshAlchemy then refreshAlchemy() end
    end)
end
local hitButton = pageButton(alchemyPage, "Ritmo automático: desligado", 130, 40)
local mixButton = pageButton(alchemyPage, "Misturar uma rodada + executar ritmo", 178, 40)
local autoAlchemyButton = pageButton(alchemyPage, "Iniciar alquimia automática", 226, 40)
local alchemyStatus = pageLabel(alchemyPage, "Receita FrostMoss ×2 + SpiritGrass ×1 selecionada", 273, 52)
local alchemyResult = pageLabel(alchemyPage, "Último resultado: -", 327, 50)
refreshAlchemy = function()
    for index, b in ipairs(recipeButtons) do
        b.Text = (index == selectedRecipe and "✓ " or "") .. recipes[index].name
        b.BackgroundColor3 = index == selectedRecipe and Color3.fromRGB(52, 125, 102) or Color3.fromRGB(54, 65, 82)
    end
    hitButton.Text = alchemyHit and "Ritmo automático: ligado" or "Ritmo automático: desligado"
    hitButton.BackgroundColor3 = alchemyHit and Color3.fromRGB(52, 125, 102) or Color3.fromRGB(54, 65, 82)
    autoAlchemyButton.Text = alchemyAuto and "Parar novas rodadas de alquimia" or "Iniciar alquimia automática"
    autoAlchemyButton.BackgroundColor3 = alchemyAuto and Color3.fromRGB(165, 66, 66) or Color3.fromRGB(52, 125, 102)
end
connect(hitButton.Activated, function()
    alchemyHit = not alchemyHit
    beatVersion += 1
    refreshAlchemy()
end)
local function stopAlchemy(message)
    alchemyAuto = false
    alchemyRequestVersion += 1
    alchemyStatus.Text = message
    refreshAlchemy()
end


-- Wait for Start/End instead of invoking Mix every six seconds.
local function requestMix()
    if closed or alchemyBusy or alchemyPending then return end
    if cultivationPhase or generalMinigameActive or alchemyActive or gameActive or gameIsVisible() or forgeBusy or awaitingGame then
        alchemyStatus.Text = "Aguardando minijogo / solicitação atual terminar"
        return
    end
    if os.clock() < alchemyNextAt then
        alchemyStatus.Text = "Aguardando a tela de resultado fechar"
        return
    end
    alchemyBusy, alchemyPending = true, true
    alchemyPendingAt = os.clock()
    local chosen = recipes[selectedRecipe]
    local ingredients = {}
    for index, ingredient in ipairs(chosen.ings) do
        ingredients[index] = { id = ingredient.id }
    end
    alchemyStatus.Text = "Solicitando mistura: " .. chosen.name
    local requestVersion = alchemyRequestVersion
    task.spawn(function()
        if closed or requestVersion ~= alchemyRequestVersion then
            alchemyBusy, alchemyPending = false, false
            return
        end
        local ok, result, message = pcall(function()
            return alchemyRequest:InvokeServer("Mix", { ings = ingredients })
        end)
        alchemyBusy = false
        if closed then return end
        if not ok then
            stopAlchemy("Falha de comunicação; tentativas suspensas: " .. tostring(result))
            return
        end
        if result == false then
            alchemyPending = false
            stopAlchemy("Não foi possível iniciar: " .. tostring(message or "Servidor rejeitou a solicitação"))
            return
        end
        -- A nil/non-boolean return is not treated as confirmed success.
        if alchemyPending then alchemyStatus.Text = "Solicitação enviada; aguardando sinal do minijogo" end
    end)
end
connect(mixButton.Activated, function()
    if closed then return end
    if alchemyPending and os.clock() - alchemyPendingAt > 12 then
        alchemyStatus.Text = "Solicitação anterior não confirmada; não será reenviada"
        return
    end
    forgeEnabled, alchemyAuto, alchemyHit = false, false, true
    paintForge()
    refreshAlchemy()
    requestMix()
end)
connect(autoAlchemyButton.Activated, function()
    if alchemyAuto then stopAlchemy("Parando novas rodadas • rodada atual continua"); return end
    if alchemyPending and os.clock() - alchemyPendingAt > 12 then
        alchemyStatus.Text = "Solicitação anterior não confirmada; não será reenviada"
        return
    end
    forgeEnabled, alchemyAuto, alchemyHit = false, true, true
    paintForge()
    refreshAlchemy()
    alchemyStatus.Text = "Automação pronta • aguardando receita selecionada"
end)


local currentBeat
connect(minigameRemote.OnClientEvent, function(data)
    if closed or type(data) ~= "table" then return end
    if data.op == "Start" then
        generalMinigameActive = true
        alchemyActive = alchemyPending or (data.kind == "Alchemy")
        alchemyPending = false
        beatVersion += 1
        currentBeat = nil
        if alchemyActive then
            alchemyCount += 1
            alchemyStatus.Text = "Preparando • iniciadas " .. alchemyCount .. " rodadas"
        else
            minorHitCount = 0
            if cultStatus and cultStatus.Parent then
                cultStatus.Text = "Iniciando avanço menor • aguardando ritmo Beat"
            end
        end
    elseif data.op == "Beat" then
        generalMinigameActive = true
        local isAlchemy = alchemyActive
        if isAlchemy and not alchemyHit then return end
        if not isAlchemy and not minorAuto then return end


        currentBeat = {}
        local beat = currentBeat
        local version = beatVersion
        local window = tonumber(data.window) or tonumber(data.t) or tonumber(data.lead) or 0.5
        if window < 0 or window > 30 or data.i == nil then return end
        local target = os.clock() + window
        task.delay(window, function()
            if closed or currentBeat ~= beat or version ~= beatVersion then return end
            if isAlchemy and not (alchemyHit and alchemyActive) then return end
            if not isAlchemy and not minorAuto then return end
            local off = os.clock() - target
            minigameRemote:FireServer({ op = "Hit", i = data.i, off = off })
        end)
    elseif data.op == "Hit" or data.op == "Miss" or data.op == "Early" then
        currentBeat = nil
        if alchemyActive then
            alchemyResult.Text = "Último ritmo: " .. ({ Hit = "Sucesso", Miss = "Falha", Early = "Muito cedo" })[data.op]
        else
            minorTotalHits += 1
            local opName = ({ Hit = "Acerto ✅", Miss = "Falha ❌", Early = "Muito cedo ⚠️" })[data.op] or tostring(data.op)
            if cultResult and cultResult.Parent then
                cultResult.Text = "Avanço menor Beat " .. tostring(data.i or "") .. ": " .. opName
            end
            if updateCultCounter then updateCultCounter() end
        end
    elseif data.op == "End" then
        local wasAlchemy = alchemyActive or alchemyPending
        generalMinigameActive, alchemyActive, alchemyPending = false, false, false
        beatVersion += 1
        currentBeat = nil
        if wasAlchemy then
            alchemyNextAt = os.clock() + 3.2
            alchemyResult.Text = "Último resultado: " .. tostring(data.text or (data.success and "Sucesso" or "Fim da rodada"))
            alchemyStatus.Text = alchemyAuto and "Rodada concluída • aguardando a próxima" or "Rodada concluída"
        else
            if cultResult and cultResult.Parent then
                cultResult.Text = "Avanço menor: " .. (data.success and "Avanço concluído! 🎉" or ("Fim da rodada " .. tostring(data.text or "")))
            end
            if cultStatus and cultStatus.Parent then
                cultStatus.Text = "Avanço menor concluído • aguarde início no jogo"
            end
        end
    end
end)
connect(RunService.Heartbeat, function()
    if closed then return end
    if alchemyPending and not alchemyBusy and os.clock() - alchemyPendingAt > 12 then
        if alchemyAuto then stopAlchemy("Sinal de início não encontrado; novas tentativas suspensas") end
        return
    end
    if not alchemyAuto or alchemyBusy or alchemyPending then return end
    if not alchemyHit then
        local tAStat = "Pausado • ative o ritmo automático para continuar"
        if alchemyStatus.Text ~= tAStat then alchemyStatus.Text = tAStat end
        return
    end
    if os.clock() >= alchemyNextAt then requestMix() end
end)


local stopAll = pageButton(panel, "Parar tudo", 495, 36)
stopAll.BackgroundColor3 = Color3.fromRGB(150, 55, 55)
local function stopWorkshop()
    enabled, forgeEnabled, alchemyAuto, alchemyHit = false, false, false, false
    breakthroughEnabled = false
    qiAuto, tribAuto, minorAuto = false, false, false
    breakthroughToken += 1
    if refreshBreakthrough then refreshBreakthrough() end
    alchemyRequestVersion += 1
    beatVersion += 1
    paintTap()
    paintForge()
    refreshAlchemy()
    forgeStatus.Text = "Forja: parada"
    alchemyStatus.Text = "Tudo foi interrompido"
end
connect(stopAll.Activated, stopWorkshop)
local minimize = create("TextButton", {
    Position = UDim2.new(1, -82, 0, 4), Size = UDim2.fromOffset(36, 36),
    BackgroundTransparency = 1, Text = "−", TextSize = 25,
    TextColor3 = Color3.fromRGB(235, 205, 132), Font = Enum.Font.GothamBold,
}, panel)
local restore = create("TextButton", {
    Position = UDim2.fromOffset(15, 100), Size = UDim2.fromOffset(160, 42),
    BackgroundColor3 = Color3.fromRGB(40, 45, 55), Text = "Abrir Workshop",
    TextSize = 16, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold,
    Visible = false, BorderSizePixel = 0,
}, gui)
create("UICorner", { CornerRadius = UDim.new(0, 8) }, restore)
connect(minimize.Activated, function() panel.Visible = false; restore.Visible = true end)
connect(restore.Activated, function() panel.Visible = true; restore.Visible = false end)
-- Scale the menu to smaller screens without changing the gameplay GUI.
local fit = create("UIScale", { Scale = 1 }, panel)
local function refit()
    local size = gui.AbsoluteSize
    if size.X > 0 and size.Y > 0 then
        fit.Scale = math.min(1, math.max(0.1, math.min((size.X - 24) / 360, (size.Y - 24) / 545)))
        -- Keep the initial centered placement correct after scaling.
        panel.Position = UDim2.new(0.5, -180 * fit.Scale, 0.5, -272.5 * fit.Scale)
    end
end
connect(gui:GetPropertyChangedSignal("AbsoluteSize"), refit)
refreshAlchemy()
selectTab("alchemy")
refit()




-- Cultivation controls derived from UI.Circulation (CircStart / TribStart) & Minigame.
-- Install before starting the trial so the server's schedule can be observed.
pageLabel(breakthroughPage, "Avanço de nível • Breakthrough & Cultivation", 0, 40, 17)
pageLabel(breakthroughPage, "Ative os recursos desejados e inicie o avanço no jogo", 43, 40, 13)
local minorButton = pageButton(breakthroughPage, "Avanço menor automático (ritmo): ligado", 90, 43)
local qiButton = pageButton(breakthroughPage, "Circulação de Qi: desligada", 140, 43)
local tribButton = pageButton(breakthroughPage, "Tribulação Celestial: desligada", 190, 43)
cultStatus = pageLabel(breakthroughPage, "Aguardando informações da próxima rodada", 243, 45)
cultResult = pageLabel(breakthroughPage, "Último resultado: -", 292, 44)
cultCounter = pageLabel(breakthroughPage, "Click: 0 | Ward: 0 | Tap: 0 | Acertos menores: 0", 340, 30, 13)
pageLabel(breakthroughPage, "Qi/Trib: avanço maior • avanço menor: ritmo 100% automático\nNão inicia rodadas, não consome ingredientes e não reinicia níveis", 378, 48, 12)
local circulation, tribulation
local clickCount, wardCount, tapCount = 0, 0, 0
local wardReadyAt = 0
local latestPaint = 0
local function finite(value)
    return type(value) == "number" and value == value and math.abs(value) < math.huge
end
updateCultCounter = function()
    if cultCounter and cultCounter.Parent then
        local tStr = string.format("Click: %d | Ward: %d | Tap: %d | Acertos menores: %d", clickCount, wardCount, tapCount, minorTotalHits)
        if cultCounter.Text ~= tStr then cultCounter.Text = tStr end
    end
end
refreshBreakthrough = function()
    if minorButton then
        minorButton.Text = minorAuto and "Avanço menor automático (ritmo): ligado" or "Avanço menor automático (ritmo): desligado"
        minorButton.BackgroundColor3 = minorAuto and Color3.fromRGB(52, 125, 102) or Color3.fromRGB(54, 65, 82)
    end
    qiButton.Text = qiAuto and "Circulação de Qi: ligada" or "Circulação de Qi: desligada"
    tribButton.Text = tribAuto and "Tribulação Celestial: ligada" or "Tribulação Celestial: desligada"
    qiButton.BackgroundColor3 = qiAuto and Color3.fromRGB(52, 125, 102) or Color3.fromRGB(54, 65, 82)
    tribButton.BackgroundColor3 = tribAuto and Color3.fromRGB(75, 100, 170) or Color3.fromRGB(54, 65, 82)
    if not qiAuto and not tribAuto and not minorAuto then
        if cultStatus and cultStatus.Parent and cultStatus.Text ~= "Auto desligado • ainda recebe dados das rodadas" then
            cultStatus.Text = "Auto desligado • ainda recebe dados das rodadas"
        end
    end
    if updateCultCounter then updateCultCounter() end
end
connect(minorButton.Activated, function()
    minorAuto = not minorAuto
    refreshBreakthrough()
    if minorAuto and cultStatus and cultStatus.Parent then
        cultStatus.Text = "Avanço menor automático ligado • pode iniciar no jogo"
    end
end)
connect(qiButton.Activated, function()
    qiAuto = not qiAuto
    refreshBreakthrough()
    if qiAuto and not circulation then cultStatus.Text = "Qi ligado • aguardando novo CircStart" end
end)
connect(tribButton.Activated, function()
    tribAuto = not tribAuto
    refreshBreakthrough()
    if tribAuto and not tribulation then cultStatus.Text = "Tribulação ligada • aguardando TribStart" end
end)
local function resetCultivation()
    circulation, tribulation, cultivationPhase = nil, nil, nil
end
local function rebase(startAt)
    if not circulation or not finite(startAt) then return end
    local now = workspace:GetServerTimeNow()
    local delta = startAt - now
    if delta <= 8 and delta >= -(circulation.duration + 3) then
        circulation.t0 = os.clock() + delta
        circulation.startAt = startAt
    end
end
connect(cultRemote.OnClientEvent, function(data)
    if closed or type(data) ~= "table" then return end
    local now = os.clock()
    if data.op == "CircStart" then
        resetCultivation()
        cultivationPhase = "qi"
        local duration = finite(data.duration) and data.duration or 20
        local lead = finite(data.lead) and data.lead or 3
        circulation = { t0 = now + lead, duration = duration, orbs = {}, byId = {} }
        -- Copy fields: the game's own listener mutates the incoming orb tables.
        for _, orb in pairs(type(data.orbs) == "table" and data.orbs or {}) do
            if type(orb) == "table" and orb.id ~= nil and finite(orb.t) and finite(orb.life) and orb.life > 0 then
                local copy = { id = orb.id, kind = orb.kind, t = orb.t, life = orb.life }
                table.insert(circulation.orbs, copy)
                circulation.byId[copy.id] = copy
            end
        end
        rebase(data.startAt)
        cultResult.Text = "Nova rodada de Qi • pontos: " .. #circulation.orbs
    elseif data.op == "CircClock" then
        rebase(data.startAt)
    elseif data.op == "Tally" and circulation then
        local orb = circulation.byId[data.id]
        if orb then orb.done = true end
        cultResult.Text = "Qi recebidos: " .. tostring(data.blue or 0) .. " | vermelhos: " .. tostring(data.red or 0)
        if data.early then cultResult.Text ..= " • Muito cedo" end
    elseif data.op == "CircPass" then
        circulation = nil
        cultivationPhase = "transition"
        cultStatus.Text = "Qi concluído • aguardando resultado ou Tribulação"
    elseif data.op == "TribStart" then
        circulation = nil
        cultivationPhase = "trib"
        wardReadyAt = now
        tribulation = { endsAt = now + (finite(data.duration) and data.duration or 30), bolts = {}, tap = nil }
        cultResult.Text = "Tribulação Celestial iniciada"
    elseif data.op == "Bolt" and tribulation then
        local lead = finite(data.t) and data.t or 1.3
        if lead >= 0 and lead <= 30 then
            -- Lead is relative to receipt, matching the client's shrinking ring.
            -- 0.08s is a timing allowance, not a guarantee of a successful ward.
            table.insert(tribulation.bolts, { due = now + math.max(0, lead - 0.08), expires = now + lead + 0.05 })
        end
    elseif data.op == "TapPrompt" and tribulation and finite(data.id) then
        local lead = math.clamp(tonumber(data.t) or 1.3, 0.3, 3)
        local window = math.clamp(tonumber(data.window) or 0.6, 0.1, lead)
        -- Gold/TAP opens at lead-window. Aim inside that interval.
        tribulation.tap = { id = data.id, due = now + lead - window * 0.5, expires = now + lead }
    elseif data.op == "TapEnd" and tribulation then
        if tribulation.tap and tribulation.tap.id == data.id then tribulation.tap = nil end
        cultResult.Text = "Tap " .. tostring(data.id) .. ": " .. tostring(data.how or "miss")
    elseif data.op == "TapEarly" then
        cultResult.Text = "Tap " .. tostring(data.id) .. ": Muito cedo"
    elseif data.op == "Warded" then
        cultResult.Text = "Ward confirmado pelo jogo"
    elseif data.op == "CircEnd" then
        resetCultivation()
        cultResult.Text = (data.success and "Concluído: " or "Rodada encerrada: ") .. tostring(data.text or data.realm or "-")
        cultStatus.Text = "Rodada encerrada • aguarde início no jogo"
    elseif data.op == "Meditate" and data.on == false then
        resetCultivation()
    end
end)
connect(Players.LocalPlayer.CharacterAdded, function()
    resetCultivation()
    cultStatus.Text = "Personagem renasceu • aguardando novos dados"
end)
connect(RunService.Heartbeat, function()
    if closed then return end
    local now = os.clock()
    if circulation then
        local elapsed = now - circulation.t0
        if elapsed > circulation.duration + 3 then
            resetCultivation()
            cultStatus.Text = "Tempo esgotado • aguardando novos dados"
        elseif qiAuto then
            local ready = {}
            for _, orb in ipairs(circulation.orbs) do
                -- Client turns the border gold at 60% of life; aim at 70%.
                if orb.kind == "blue" and not orb.done and not orb.sent
                    and elapsed >= orb.t + orb.life * 0.7
                    and elapsed <= orb.t + orb.life then
                    ready[#ready + 1] = orb
                end
            end
            table.sort(ready, function(a, b)
                if type(a.id) == "number" and type(b.id) == "number" then return a.id < b.id end
                return tostring(a.id) < tostring(b.id)
            end)
            for _, orb in ipairs(ready) do
                orb.sent = true
                local payload = { op = "Click", id = orb.id }
                if circulation.startAt then payload.at = circulation.startAt + (os.clock() - circulation.t0) end
                cultRemote:FireServer(payload)
                clickCount += 1
            end
        end
    end
    if tribulation then
        if now > tribulation.endsAt + 2 then
            resetCultivation()
            cultStatus.Text = "Tribulação encerrada • aguardando resultado do jogo"
        else
            local tap = tribulation.tap
            if tap and not tap.sent and tribAuto and now >= tap.due and now <= tap.expires then
                tap.sent = true
                cultRemote:FireServer({ op = "Tap", id = tap.id })
                tapCount += 1
            end
            -- Respect the client's 0.8s ward cooldown; never spam Ward continuously.
            for index = #tribulation.bolts, 1, -1 do
                local bolt = tribulation.bolts[index]
                if now > bolt.expires then
                    table.remove(tribulation.bolts, index)
                elseif tribAuto and now >= bolt.due and now >= wardReadyAt then
                    wardReadyAt = now + 0.8
                    cultRemote:FireServer({ op = "Ward" })
                    wardCount += 1
                    table.remove(tribulation.bolts, index)
                end
            end
        end
    end
    if now >= latestPaint then
        latestPaint = now + 0.1
        if updateCultCounter then updateCultCounter() end
        if circulation then
            local qText = qiAuto and "Qi: aguardando momento ideal • aciona apenas blue" or "Qi: automático desligado"
            if cultStatus.Text ~= qText then cultStatus.Text = qText end
        elseif tribulation then
            local trText = tribAuto and "Tribulação: aguardando Bolt / TapPrompt" or "Tribulação: automático desligado"
            if cultStatus.Text ~= trText then cultStatus.Text = trText end
        end
    end
end)
refreshBreakthrough()
selectTab("breakthrough")


-- Mount controls into the supplied hub; hidden assembly controls never show.
local function mountPage(name, index, caption, contents, height)
    local page = host.makePage(name, index, caption)
    local scroll = create("ScrollingFrame", {
        Name = "Content", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        BorderSizePixel = 0, ScrollBarThickness = 10,
        Active = true, ScrollingEnabled = true,
        ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
        CanvasSize = UDim2.fromOffset(0, height + 26), ScrollingDirection = Enum.ScrollingDirection.Y,
    }, page)
    contents.Parent = scroll
    contents.Position = UDim2.fromOffset(0, 0)
    contents.Size = UDim2.new(1, -6, 0, height)
    contents.Visible = true
end
mountPage("Alchemy", 4, "Alquimia", alchemyPage, 390)
mountPage("Forge", 5, "Forge", forgePage, 400)
mountPage("Cultivation", 6, "Avanço de nível", breakthroughPage, 460)
panel.Visible = false
restore.Visible = false
host.stopWorkshop = stopWorkshop
host.isBusy = function()
    if closed then return false end
    return cultivationPhase ~= nil or alchemyAuto or alchemyBusy or alchemyPending
        or alchemyActive or generalMinigameActive or forgeEnabled or forgeBusy
        or awaitingGame or gameActive or gameIsVisible()
        or (host.HongmengConfig and host.HongmengConfig.Enabled)
end
host.showPage(1)
host.refresh()


end
local hub = buildMaster()
hub.frame.Visible = true
local logsOK, logsError = pcall(installMurimDiagnostics, hub)
if not logsOK then warn("[Murim V18R] Aba Logs: " .. tostring(logsError)) end
local navOK, navError = pcall(installMobileTabNavigation, hub)
if not navOK then warn("[Murim PTBR V4] Erro na navegacao mobile: " .. tostring(navError)) end
report("Menu principal aberto • carregando Alquimia / Forja / Avanço", false)
task.spawn(function()
    local ok, reason = xpcall(function() mountWorkshop(hub) end, function(e) return tostring(e) end)
    if ok then
        report("Pronto para usar • 10 abas", false)
        task.delay(3, finishNotice)
    else
        report("Falha ao carregar o módulo de minijogos: " .. tostring(reason), true)
    end
end)


]====]


if type(loadstring) ~= "function" then
    report("Este executor não possui loadstring; não é possível carregar o pacote", true)
    return
end
local compileOK, program, compileError = pcall(loadstring, source, "MurimMasterHub-v2")
if not compileOK then report(program, true); return end
if not program then report(compileError or "Compile failed", true); return end
task.spawn(function()
    local ok, reason = xpcall(function() program(report, finishNotice) end, function(e) return tostring(e) end)
    if not ok then report(reason, true) end
end)
