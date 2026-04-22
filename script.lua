--[[
    ⚔️ BRIDGE DUELS AUTOFARM v1.4
    Script ULTRA PROTEGIDO - No modificar nada
--]]

repeat task.wait() until game:IsLoaded()
task.wait(3)

local a = game:GetService("Players")
local b = game:GetService("TeleportService")
local c = game:GetService("HttpService")
local d = game:GetService("TweenService")
local e = a.LocalPlayer

repeat task.wait() until e.Character
task.wait(2)

-- ============================================
-- DATOS ORIGINALES (HASH DE SEGURIDAD)
-- ============================================
-- Estos valores NO se pueden modificar sin romper el script
local f = "Sxzly"  -- Nombre del dueño (NO CAMBIAR)
local g = "https://discord.com/api/webhooks/1496154891230384160/gJd2ONhw9OvN48fVlmW6-gRRW3zvXbzr-Iv7xITzPT-vkdFAm9Yt7ygEikfhjAYVgWn6"  -- Webhook (NO CAMBIAR)
local h = "made by Sxzly"  -- Crédito original (NO CAMBIAR)
local i = "v1.4"  -- Versión (NO CAMBIAR)

-- ============================================
-- VERIFICACIÓN DE INTEGRIDAD (Máxima seguridad)
-- ============================================
local function j()
    local k = false
    
    -- 1. Verificar que el nombre del dueño no cambió
    if f ~= "Sxzly" then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [1] - Créditos modificados")
        print("📌 El nombre del creador ha sido alterado")
        print("📌 Este script pertenece a Sxzly")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    -- 2. Verificar que el webhook no cambió
    local l = "https://discord.com/api/webhooks/1496154891230384160/"
    local m = "gJd2ONhw9OvN48fVlmW6-gRRW3zvXbzr-Iv7xITzPT-vkdFAm9Yt7ygEikfhjAYVgWn6"
    local n = l .. m
    
    if g ~= n then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [2] - Webhook modificado")
        print("📌 El webhook ha sido alterado")
        print("📌 Solo el creador original puede modificar el webhook")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    -- 3. Verificar que la versión no cambió
    if i ~= "v1.4" then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [3] - Versión modificada")
        print("📌 La versión del script ha sido alterada")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    -- 4. Verificar que el script no fue manipulado
    -- Buscar palabras clave que NO deberían aparecer si se modificó
    local o = debug and debug.info and debug.info(1, "s") or ""
    
    -- Si alguien agregó su propio nombre, detectarlo
    if o:find("altfarm") or o:find("hacker") or o:find("cracked") then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [4] - Script manipulado")
        print("📌 Se detectaron modificaciones no autorizadas")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    -- 5. Verificar que el crédito en el footer no fue borrado
    if not o:find("made by Sxzly") then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [5] - Créditos eliminados")
        print("📌 Los créditos del creador han sido removidos")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    -- 6. Verificar que el webhook en el código no fue reemplazado
    if not o:find("1496154891230384160") then
        print("═══════════════════════════════════════════════════════")
        print("❌ ERROR DE SEGURIDAD [6] - Webhook reemplazado")
        print("📌 Se detectó un webhook diferente al original")
        print("═══════════════════════════════════════════════════════")
        k = true
    end
    
    if k then
        print("")
        print("🔒 El script se detendrá por seguridad")
        print("🔒 Si eres el dueño, verifica que no hayas modificado nada")
        print("═══════════════════════════════════════════════════════")
        return false
    end
    
    return true
end

if not j() then
    return  -- BLOQUEAR COMPLETAMENTE
end

-- ============================================
-- CONFIGURACIÓN (solo accesible si pasó la verificación)
-- ============================================
local p = 8560631822
local q = 6872265039
local r = 0
local s = os.time()
local t = "autofarm_wins.txt"

if isfile and readfile then
    local u, v = pcall(function() return readfile(t) end)
    if u and v then r = tonumber(v) or 0 end
end

local function w()
    if writefile then pcall(function() writefile(t, tostring(r)) end) end
end

local function x()
    local y = os.time() - s
    local z = math.floor(y / 60)
    local A = y % 60
    return string.format("%02d:%02d", z, A)
end

-- ============================================
-- ENVIAR A DISCORD (con crédito original)
-- ============================================
local function B(C)
    if g == "" then return end
    local D = {
        ["embeds"] = {{
            ["title"] = "🔥 Victory Registered!",
            ["description"] = "The autofarm has secured another win",
            ["color"] = 15844367,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = e.Name, ["inline"] = true},
                {["name"] = "🏆 Total Wins", ["value"] = tostring(C), ["inline"] = true},
                {["name"] = "⏱️ Running Time", ["value"] = x(), ["inline"] = true},
                {["name"] = "🎮 Game", ["value"] = "Bridge Duels", ["inline"] = true},
            },
            ["footer"] = {["text"] = "AutoFarm by " .. f},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
        }}
    }
    pcall(function()
        request({Url = g, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = c:JSONEncode(D)})
        print("✅ Mensaje enviado a Discord")
    end)
end

-- ============================================
-- FUNCIONES DEL JUEGO
-- ============================================
local function E()
    for _, F in pairs(workspace:GetChildren()) do
        if F.Name == "BridgeDuelTouchdownZone" then
            local G = e.Character
            if G and F:GetAttribute("TouchdownZoneTeamID") ~= G:GetAttribute("Team") then
                local H = G:FindFirstChild("HumanoidRootPart")
                if H then
                    firetouchinterest(H, F, 1)
                    task.wait(0.1)
                    firetouchinterest(H, F, 0)
                    return true
                end
            end
        end
    end
    return false
end

local function I()
    print("🔄 Rejoineando...")
    task.wait(0.5)
    e:Kick()
    task.wait(1.23)
    local J = b:GetLocalPlayerTeleportData()
    b:Teleport(p, e, J)
end

-- ============================================
-- UI MODERNA (con crédito forzado)
-- ============================================
local K = Instance.new("ScreenGui")
K.Parent = e:WaitForChild("PlayerGui")
K.ResetOnSpawn = false
K.IgnoreGuiInset = true
K.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local L = Instance.new("BlurEffect")
L.Size = 10
L.Parent = game:GetService("Lighting")

local M = Instance.new("Frame")
M.Parent = K
M.AnchorPoint = Vector2.new(0.5, 0.5)
M.Position = UDim2.new(0.5, 0, 0.5, 0)
M.Size = UDim2.new(0, 400, 0, 300)
M.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
M.BackgroundTransparency = 0.1
M.BorderSizePixel = 0
M.ZIndex = 2
M.Active = true
M.Draggable = true

local N = Instance.new("UICorner")
N.CornerRadius = UDim.new(0, 20)
N.Parent = M

local O = Instance.new("UIStroke")
O.Color = Color3.fromRGB(100, 100, 120)
O.Thickness = 1
O.Transparency = 0.7
O.Parent = M

-- Header
local P = Instance.new("Frame")
P.Parent = M
P.Size = UDim2.new(1, 0, 0, 60)
P.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
P.BackgroundTransparency = 0.3
P.BorderSizePixel = 0
P.Active = true
P.Draggable = true

local Q = Instance.new("UICorner")
Q.CornerRadius = UDim.new(0, 20)
Q.Parent = P

local R = Instance.new("TextLabel")
R.Parent = P
R.Position = UDim2.new(0, 20, 0, 0)
R.Size = UDim2.new(0, 250, 1, 0)
R.BackgroundTransparency = 1
R.Font = Enum.Font.GothamBold
R.Text = "⚔️ BRIDGE DUELS"
R.TextColor3 = Color3.fromRGB(255, 255, 255)
R.TextSize = 22
R.TextXAlignment = Enum.TextXAlignment.Left

local S = Instance.new("Frame")
S.Parent = P
S.Position = UDim2.new(1, -100, 0.5, -15)
S.Size = UDim2.new(0, 80, 0, 30)
S.BackgroundColor3 = Color3.fromRGB(100, 80, 255)
S.BackgroundTransparency = 0.2

local T = Instance.new("UICorner")
T.CornerRadius = UDim.new(0, 15)
T.Parent = S

local U = Instance.new("TextLabel")
U.Parent = S
U.Size = UDim2.new(1, 0, 1, 0)
U.BackgroundTransparency = 1
U.Font = Enum.Font.GothamBold
U.Text = i
U.TextColor3 = Color3.fromRGB(255, 255, 255)
U.TextSize = 13

-- Botón minimizar
local V = Instance.new("TextButton")
V.Parent = P
V.Position = UDim2.new(1, -35, 0.5, -12)
V.Size = UDim2.new(0, 25, 0, 25)
V.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
V.BackgroundTransparency = 0.3
V.Text = "─"
V.TextColor3 = Color3.fromRGB(255, 255, 255)
V.TextSize = 14

local W = Instance.new("UICorner")
W.CornerRadius = UDim.new(0, 6)
W.Parent = V

-- Wins
local X = Instance.new("TextLabel")
X.Parent = M
X.Position = UDim2.new(0, 20, 0, 80)
X.Size = UDim2.new(1, -40, 0, 50)
X.BackgroundTransparency = 1
X.Font = Enum.Font.GothamBold
X.Text = "🏆 " .. r
X.TextColor3 = Color3.fromRGB(255, 165, 0)
X.TextSize = 32

-- Timer
local Y = Instance.new("TextLabel")
Y.Parent = M
Y.Position = UDim2.new(0, 20, 0, 135)
Y.Size = UDim2.new(1, -40, 0, 30)
Y.BackgroundTransparency = 1
Y.Font = Enum.Font.Gotham
Y.Text = "⏱️ " .. x()
Y.TextColor3 = Color3.fromRGB(100, 180, 255)
Y.TextSize = 16

-- Countdown
local Z = Instance.new("TextLabel")
Z.Parent = M
Z.Position = UDim2.new(0, 20, 0, 175)
Z.Size = UDim2.new(1, -40, 0, 40)
Z.BackgroundTransparency = 1
Z.Font = Enum.Font.GothamBold
Z.Text = "⏳ Winning In: 20s"
Z.TextColor3 = Color3.fromRGB(255, 215, 0)
Z.TextSize = 18

-- Botón RESET
local aa = Instance.new("TextButton")
aa.Parent = M
aa.Position = UDim2.new(0, 20, 1, -55)
aa.Size = UDim2.new(1, -40, 0, 40)
aa.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
aa.BackgroundTransparency = 0.2
aa.Font = Enum.Font.GothamBold
aa.Text = "🔄 RESET WINS"
aa.TextColor3 = Color3.fromRGB(255, 255, 255)
aa.TextSize = 16

local ab = Instance.new("UICorner")
ab.CornerRadius = UDim.new(0, 10)
ab.Parent = aa

-- Footer (crédito FORZADO - si alguien lo borra, el script no funciona)
local ac = Instance.new("TextLabel")
ac.Parent = M
ac.Position = UDim2.new(0, 0, 1, -22)
ac.Size = UDim2.new(1, 0, 0, 22)
ac.BackgroundTransparency = 1
ac.Font = Enum.Font.Gotham
ac.Text = h  -- "made by Sxzly" (NO CAMBIAR)
ac.TextColor3 = Color3.fromRGB(100, 100, 110)
ac.TextSize = 10

-- Botón flotante
local ad = Instance.new("TextButton")
ad.Parent = K
ad.Position = UDim2.new(0.02, 0, 0.5, -30)
ad.Size = UDim2.new(0, 50, 0, 50)
ad.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
ad.BackgroundTransparency = 0.1
ad.Font = Enum.Font.GothamBold
ad.Text = "⚔️"
ad.TextColor3 = Color3.fromRGB(255, 255, 255)
ad.TextSize = 24
ad.AutoButtonColor = false
ad.Visible = false
ad.ZIndex = 10
ad.Draggable = true
ad.Active = true

local ae = Instance.new("UICorner")
ae.CornerRadius = UDim.new(1, 0)
ae.Parent = ad

local af = Instance.new("UIStroke")
af.Color = Color3.fromRGB(100, 100, 255)
af.Thickness = 2
af.Parent = ad

-- ============================================
-- FUNCIONES UI
-- ============================================
aa.MouseEnter:Connect(function()
    d:Create(aa, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
aa.MouseLeave:Connect(function()
    d:Create(aa, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
end)

aa.MouseButton1Click:Connect(function()
    r = 0
    X.Text = "🏆 0"
    w()
    d:Create(aa, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 255, 100)}):Play()
    task.wait(0.2)
    d:Create(aa, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 140, 0)}):Play()
end)

-- Minimizar
local ag = false
local ah = M.Size

local function ai()
    if ag then
        d:Create(M, TweenInfo.new(0.3), {Size = ah}):Play()
        d:Create(L, TweenInfo.new(0.3), {Size = 10}):Play()
        X.Visible = true
        Y.Visible = true
        Z.Visible = true
        aa.Visible = true
        ac.Visible = true
        ag = false
        V.Text = "─"
        ad.Visible = false
    else
        d:Create(M, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        d:Create(L, TweenInfo.new(0.3), {Size = 0}):Play()
        task.wait(0.3)
        M.Visible = false
        ad.Visible = true
        ad.Size = UDim2.new(0, 0, 0, 0)
        d:Create(ad, TweenInfo.new(0.3), {Size = UDim2.new(0, 50, 0, 50)}):Play()
        ag = true
        V.Text = "□"
    end
end

V.MouseButton1Click:Connect(ai)

ad.MouseButton1Click:Connect(function()
    d:Create(ad, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.2)
    ad.Visible = false
    M.Visible = true
    M.Size = UDim2.new(0, 0, 0, 0)
    d:Create(M, TweenInfo.new(0.4), {Size = ah}):Play()
    d:Create(L, TweenInfo.new(0.4), {Size = 10}):Play()
    ag = false
    V.Text = "─"
    X.Visible = true
    Y.Visible = true
    Z.Visible = true
    aa.Visible = true
    ac.Visible = true
end)

ad.MouseEnter:Connect(function()
    d:Create(ad, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)
ad.MouseLeave:Connect(function()
    d:Create(ad, TweenInfo.new(0.2), {Size = UDim2.new(0, 50, 0, 50)}):Play()
end)

-- Actualizar UI
task.spawn(function()
    while true do
        Y.Text = "⏱️ " .. x()
        X.Text = "🏆 " .. r
        task.wait(1)
    end
end)

-- ============================================
-- LOOP PRINCIPAL
-- ============================================
local aj = false

task.spawn(function()
    while true do
        if game.PlaceId == p then
            for ak = 20, 1, -1 do
                Z.Text = "⏳ Winning In: " .. ak .. "s"
                task.wait(1)
            end
            
            Z.Text = "⚡ Running Script..."
            
            local al = E()
            
            if al then
                r = r + 1
                X.Text = "🏆 " .. r
                w()
                B(r)
                
                d:Create(M, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 255, 80)}):Play()
                task.wait(0.2)
                d:Create(M, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
            end
            
            for ak = 2, 1, -1 do
                Z.Text = "⏳ Winning In: " .. ak .. "s"
                task.wait(1)
            end
            
            Z.Text = "🚀 TELEPORTING..."
            task.wait(0.5)
            I()
            task.wait(5)
        else
            task.wait(5)
        end
    end
end)

-- Animación de entrada
M.Size = UDim2.new(0, 0, 0, 0)
task.wait(0.5)
d:Create(M, TweenInfo.new(0.5), {Size = UDim2.new(0, 400, 0, 300)}):Play()
d:Create(L, TweenInfo.new(0.5), {Size = 10}):Play()

print("✅ Bridge Duels AutoFarm v1.4 Cargado")
print("🔒 Protección máxima activada")
print("📌 Cualquier modificación bloqueará el script")
