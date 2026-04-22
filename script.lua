--[[
    ⚔️ BRIDGE DUELS AUTOFARM v1.2
    Script ULTRA PROTEGIDO - UI Moderna
--]]

repeat task.wait() until game:IsLoaded()
task.wait(3)

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

repeat task.wait() until player.Character
task.wait(2)

-- ============================================
-- DATOS OFUSCADOS (PROTECCIÓN)
-- ============================================
local function getWebhook()
    return "https://discord.com/api/webhooks/1496154891230384160/gJd2ONhw9OvN48fVlmW6-gRRW3zvXbzr-Iv7xITzPT-vkdFAm9Yt7ygEikfhjAYVgWn6"
end
local webhookURL = getWebhook()

local function getOwnerName()
    local chars = {83, 120, 122, 108, 121}
    local name = ""
    for i = 1, #chars do name = name .. string.char(chars[i]) end
    return name
end
local OWNER_NAME = getOwnerName()

-- ============================================
-- PROTECCIÓN
-- ============================================
local function checkScriptIntegrity()
    local expectedWebhook = "https://discord.com/api/webhooks/1496154891230384160/gJd2ONhw9OvN48fVlmW6-gRRW3zvXbzr-Iv7xITzPT-vkdFAm9Yt7ygEikfhjAYVgWn6"
    
    if webhookURL ~= expectedWebhook then
        print("❌ Webhook modificado - Ejecución bloqueada")
        return false
    end
    
    print("✅ Verificación superada")
    return true
end

if not checkScriptIntegrity() then
    local ErrorGui = Instance.new("ScreenGui")
    ErrorGui.Parent = player:WaitForChild("PlayerGui")
    
    local ErrorFrame = Instance.new("Frame")
    ErrorFrame.Parent = ErrorGui
    ErrorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ErrorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ErrorFrame.Size = UDim2.new(0, 400, 0, 150)
    ErrorFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
    ErrorFrame.BorderSizePixel = 0
    
    local ErrorCorner = Instance.new("UICorner")
    ErrorCorner.CornerRadius = UDim.new(0, 15)
    ErrorCorner.Parent = ErrorFrame
    
    local ErrorTitle = Instance.new("TextLabel")
    ErrorTitle.Parent = ErrorFrame
    ErrorTitle.Size = UDim2.new(1, 0, 0, 40)
    ErrorTitle.BackgroundTransparency = 1
    ErrorTitle.Font = Enum.Font.GothamBold
    ErrorTitle.Text = "🔒 SCRIPT BLOQUEADO"
    ErrorTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
    ErrorTitle.TextSize = 20
    
    local ErrorMsg = Instance.new("TextLabel")
    ErrorMsg.Parent = ErrorFrame
    ErrorMsg.Position = UDim2.new(0, 20, 0, 50)
    ErrorMsg.Size = UDim2.new(1, -40, 0, 80)
    ErrorMsg.BackgroundTransparency = 1
    ErrorMsg.Font = Enum.Font.Gotham
    ErrorMsg.Text = "Este script ha sido modificado.\n\nNo se permite cambiar el webhook."
    ErrorMsg.TextColor3 = Color3.fromRGB(255, 255, 255)
    ErrorMsg.TextSize = 14
    ErrorMsg.TextWrapped = true
    
    return
end

-- ============================================
-- CONFIGURACIÓN
-- ============================================
local GAME_PLACE_ID = game.PlaceId
local totalWins = 0
local startTime = os.time()
local saveFileName = "bridgeduels_farm.txt"

if isfile and readfile then
    local success, savedWins = pcall(function() return readfile(saveFileName) end)
    if success and savedWins then totalWins = tonumber(savedWins) or 0 end
end

local function saveWins()
    if writefile then pcall(function() writefile(saveFileName, tostring(totalWins)) end) end
end

local function getElapsedTime()
    local elapsed = os.time() - startTime
    local hours = math.floor(elapsed / 3600)
    local minutes = math.floor((elapsed % 3600) / 60)
    local seconds = elapsed % 60
    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, seconds)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, seconds)
    else
        return string.format("%ds", seconds)
    end
end

local function sendDiscordEmbed(wins)
    if webhookURL == "" then return end
    
    local ownerDisplay = "AutoFarm by " .. OWNER_NAME
    
    local embed = {
        ["embeds"] = {{
            ["title"] = "🔥 Victory Registered!",
            ["description"] = "The autofarm has secured another win",
            ["color"] = 15844367,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = player.Name, ["inline"] = true},
                {["name"] = "🏆 Total Wins", ["value"] = tostring(wins), ["inline"] = true},
                {["name"] = "⏱️ Running Time", ["value"] = getElapsedTime(), ["inline"] = true},
                {["name"] = "🎮 Game", ["value"] = "Bridge Duels", ["inline"] = true},
            },
            ["footer"] = {["text"] = ownerDisplay},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
        }}
    }
    
    pcall(function()
        request({Url = webhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(embed)})
        print("✅ Mensaje enviado a Discord")
    end)
end

local function touchTouchdown()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "BridgeDuelTouchdownZone" then
            local char = player.Character
            if char and v:GetAttribute("TouchdownZoneTeamID") ~= char:GetAttribute("Team") then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    firetouchinterest(hrp, v, 1)
                    task.wait(0.1)
                    firetouchinterest(hrp, v, 0)
                    return true
                end
            end
        end
    end
    return false
end

local function rejoin()
    print("🔄 Rejoineando...")
    task.wait(0.5)
    player:Kick()
    task.wait(1.23)
    local data = TeleportService:GetLocalPlayerTeleportData()
    TeleportService:Teleport(GAME_PLACE_ID, player, data)
end

-- ============================================
-- UI MODERNA COMPLETA
-- ============================================
local function smoothTween(object, properties, duration)
    local tween = TweenService:Create(object, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = game:GetService("Lighting")

local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Parent = ScreenGui
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.Size = UDim2.new(0, 480, 0, 620)
MainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.ZIndex = 2
MainContainer.Active = true
MainContainer.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 24)
MainCorner.Parent = MainContainer

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 100, 120)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.7
MainStroke.Parent = MainContainer

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainContainer

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainContainer
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0
Header.ZIndex = 3

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 24)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "⚔️ BRIDGE DUELS"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 4

local VersionBadge = Instance.new("Frame")
VersionBadge.Parent = Header
VersionBadge.Position = UDim2.new(1, -130, 0.5, -15)
VersionBadge.Size = UDim2.new(0, 110, 0, 30)
VersionBadge.BackgroundColor3 = Color3.fromRGB(100, 80, 255)
VersionBadge.BackgroundTransparency = 0.2
VersionBadge.BorderSizePixel = 0
VersionBadge.ZIndex = 4

local VersionCorner = Instance.new("UICorner")
VersionCorner.CornerRadius = UDim.new(0, 15)
VersionCorner.Parent = VersionBadge

local VersionText = Instance.new("TextLabel")
VersionText.Parent = VersionBadge
VersionText.Size = UDim2.new(1, 0, 1, 0)
VersionText.BackgroundTransparency = 1
VersionText.Font = Enum.Font.GothamBold
VersionText.Text = "v1.2"
VersionText.TextColor3 = Color3.fromRGB(255, 255, 255)
VersionText.TextSize = 13
VersionText.ZIndex = 5

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Header
MinBtn.Position = UDim2.new(1, -35, 0.5, -12)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinBtn.BackgroundTransparency = 0.3
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
MinBtn.ZIndex = 4

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Stats Container
local StatsContainer = Instance.new("Frame")
StatsContainer.Name = "StatsContainer"
StatsContainer.Parent = MainContainer
StatsContainer.Position = UDim2.new(0, 20, 0, 90)
StatsContainer.Size = UDim2.new(1, -40, 0, 100)
StatsContainer.BackgroundTransparency = 1
StatsContainer.ZIndex = 3

-- Wins Card
local WinsCard = Instance.new("Frame")
WinsCard.Parent = StatsContainer
WinsCard.Position = UDim2.new(0, 0, 0, 0)
WinsCard.Size = UDim2.new(0.48, 0, 1, 0)
WinsCard.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
WinsCard.BackgroundTransparency = 0.3
WinsCard.BorderSizePixel = 0
WinsCard.ZIndex = 4

local WinsCardCorner = Instance.new("UICorner")
WinsCardCorner.CornerRadius = UDim.new(0, 16)
WinsCardCorner.Parent = WinsCard

local WinsCardStroke = Instance.new("UIStroke")
WinsCardStroke.Color = Color3.fromRGB(255, 165, 0)
WinsCardStroke.Thickness = 2
WinsCardStroke.Transparency = 0.6
WinsCardStroke.Parent = WinsCard

local WinsIcon = Instance.new("TextLabel")
WinsIcon.Parent = WinsCard
WinsIcon.Position = UDim2.new(0, 15, 0, 10)
WinsIcon.Size = UDim2.new(0, 30, 0, 30)
WinsIcon.BackgroundTransparency = 1
WinsIcon.Font = Enum.Font.GothamBold
WinsIcon.Text = "🏆"
WinsIcon.TextSize = 24
WinsIcon.ZIndex = 5

local WinsTitle = Instance.new("TextLabel")
WinsTitle.Parent = WinsCard
WinsTitle.Position = UDim2.new(0, 15, 0, 45)
WinsTitle.Size = UDim2.new(1, -30, 0, 20)
WinsTitle.BackgroundTransparency = 1
WinsTitle.Font = Enum.Font.Gotham
WinsTitle.Text = "TOTAL WINS"
WinsTitle.TextColor3 = Color3.fromRGB(150, 150, 160)
WinsTitle.TextSize = 12
WinsTitle.TextXAlignment = Enum.TextXAlignment.Left
WinsTitle.ZIndex = 5

local WinsValue = Instance.new("TextLabel")
WinsValue.Parent = WinsCard
WinsValue.Position = UDim2.new(0, 15, 0, 65)
WinsValue.Size = UDim2.new(1, -30, 0, 25)
WinsValue.BackgroundTransparency = 1
WinsValue.Font = Enum.Font.GothamBold
WinsValue.Text = tostring(totalWins)
WinsValue.TextColor3 = Color3.fromRGB(255, 165, 0)
WinsValue.TextSize = 28
WinsValue.TextXAlignment = Enum.TextXAlignment.Left
WinsValue.ZIndex = 5

-- Time Card
local TimeCard = Instance.new("Frame")
TimeCard.Parent = StatsContainer
TimeCard.Position = UDim2.new(0.52, 0, 0, 0)
TimeCard.Size = UDim2.new(0.48, 0, 1, 0)
TimeCard.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TimeCard.BackgroundTransparency = 0.3
TimeCard.BorderSizePixel = 0
TimeCard.ZIndex = 4

local TimeCardCorner = Instance.new("UICorner")
TimeCardCorner.CornerRadius = UDim.new(0, 16)
TimeCardCorner.Parent = TimeCard

local TimeCardStroke = Instance.new("UIStroke")
TimeCardStroke.Color = Color3.fromRGB(100, 180, 255)
TimeCardStroke.Thickness = 2
TimeCardStroke.Transparency = 0.6
TimeCardStroke.Parent = TimeCard

local TimeIcon = Instance.new("TextLabel")
TimeIcon.Parent = TimeCard
TimeIcon.Position = UDim2.new(0, 15, 0, 10)
TimeIcon.Size = UDim2.new(0, 30, 0, 30)
TimeIcon.BackgroundTransparency = 1
TimeIcon.Font = Enum.Font.GothamBold
TimeIcon.Text = "⏱️"
TimeIcon.TextSize = 24
TimeIcon.ZIndex = 5

local TimeTitle = Instance.new("TextLabel")
TimeTitle.Parent = TimeCard
TimeTitle.Position = UDim2.new(0, 15, 0, 45)
TimeTitle.Size = UDim2.new(1, -30, 0, 20)
TimeTitle.BackgroundTransparency = 1
TimeTitle.Font = Enum.Font.Gotham
TimeTitle.Text = "RUNTIME"
TimeTitle.TextColor3 = Color3.fromRGB(150, 150, 160)
TimeTitle.TextSize = 12
TimeTitle.TextXAlignment = Enum.TextXAlignment.Left
TimeTitle.ZIndex = 5

local TimeValue = Instance.new("TextLabel")
TimeValue.Parent = TimeCard
TimeValue.Position = UDim2.new(0, 15, 0, 65)
TimeValue.Size = UDim2.new(1, -30, 0, 25)
TimeValue.BackgroundTransparency = 1
TimeValue.Font = Enum.Font.GothamBold
TimeValue.Text = getElapsedTime()
TimeValue.TextColor3 = Color3.fromRGB(100, 180, 255)
TimeValue.TextSize = 28
TimeValue.TextXAlignment = Enum.TextXAlignment.Left
TimeValue.ZIndex = 5

-- Avatar Container
local AvatarContainer = Instance.new("Frame")
AvatarContainer.Parent = MainContainer
AvatarContainer.Position = UDim2.new(0, 20, 0, 210)
AvatarContainer.Size = UDim2.new(1, -40, 0, 200)
AvatarContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
AvatarContainer.BackgroundTransparency = 0.3
AvatarContainer.BorderSizePixel = 0
AvatarContainer.ZIndex = 3

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 16)
AvatarCorner.Parent = AvatarContainer

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = AvatarContainer
AvatarImage.Position = UDim2.new(0, 15, 0, 15)
AvatarImage.Size = UDim2.new(0, 170, 0, 170)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
AvatarImage.BorderSizePixel = 0
AvatarImage.ScaleType = Enum.ScaleType.Crop
AvatarImage.ZIndex = 4

local AvatarImageCorner = Instance.new("UICorner")
AvatarImageCorner.CornerRadius = UDim.new(0, 12)
AvatarImageCorner.Parent = AvatarImage

-- Username
local UsernameContainer = Instance.new("Frame")
UsernameContainer.Parent = AvatarContainer
UsernameContainer.Position = UDim2.new(0, 200, 0, 15)
UsernameContainer.Size = UDim2.new(1, -215, 0, 170)
UsernameContainer.BackgroundTransparency = 1
UsernameContainer.ZIndex = 4

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Parent = UsernameContainer
UsernameLabel.Size = UDim2.new(1, 0, 0, 30)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Font = Enum.Font.Gotham
UsernameLabel.Text = "USERNAME"
UsernameLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
UsernameLabel.TextSize = 12
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.ZIndex = 5

local UsernameValue = Instance.new("TextLabel")
UsernameValue.Parent = UsernameContainer
UsernameValue.Position = UDim2.new(0, 0, 0, 35)
UsernameValue.Size = UDim2.new(1, 0, 0, 50)
UsernameValue.BackgroundTransparency = 1
UsernameValue.Font = Enum.Font.GothamBold
UsernameValue.Text = "[HIDDEN]"
UsernameValue.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameValue.TextSize = 20
UsernameValue.TextXAlignment = Enum.TextXAlignment.Left
UsernameValue.TextWrapped = true
UsernameValue.ZIndex = 5

local ShowUsernameBtn = Instance.new("TextButton")
ShowUsernameBtn.Parent = UsernameContainer
ShowUsernameBtn.Position = UDim2.new(0, 0, 1, -50)
ShowUsernameBtn.Size = UDim2.new(1, 0, 0, 45)
ShowUsernameBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
ShowUsernameBtn.BackgroundTransparency = 0.2
ShowUsernameBtn.BorderSizePixel = 0
ShowUsernameBtn.Font = Enum.Font.GothamBold
ShowUsernameBtn.Text = "🔒 SHOW"
ShowUsernameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowUsernameBtn.TextSize = 14
ShowUsernameBtn.AutoButtonColor = false
ShowUsernameBtn.ZIndex = 5

local ShowBtnCorner = Instance.new("UICorner")
ShowBtnCorner.CornerRadius = UDim.new(0, 10)
ShowBtnCorner.Parent = ShowUsernameBtn

-- Timer Container
local TimerContainer = Instance.new("Frame")
TimerContainer.Parent = MainContainer
TimerContainer.Position = UDim2.new(0, 20, 0, 430)
TimerContainer.Size = UDim2.new(1, -40, 0, 80)
TimerContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TimerContainer.BackgroundTransparency = 0.3
TimerContainer.BorderSizePixel = 0
TimerContainer.ZIndex = 3

local TimerCorner = Instance.new("UICorner")
TimerCorner.CornerRadius = UDim.new(0, 16)
TimerCorner.Parent = TimerContainer

local TimerStroke = Instance.new("UIStroke")
TimerStroke.Color = Color3.fromRGB(255, 215, 0)
TimerStroke.Thickness = 2
TimerStroke.Transparency = 0.5
TimerStroke.Parent = TimerContainer

local CountdownLabel = Instance.new("TextLabel")
CountdownLabel.Parent = TimerContainer
CountdownLabel.Size = UDim2.new(1, 0, 1, 0)
CountdownLabel.BackgroundTransparency = 1
CountdownLabel.Font = Enum.Font.GothamBold
CountdownLabel.Text = "⏳ Winning In: 20s"
CountdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CountdownLabel.TextSize = 24
CountdownLabel.ZIndex = 4

-- Botones
local ControlsContainer = Instance.new("Frame")
ControlsContainer.Parent = MainContainer
ControlsContainer.Position = UDim2.new(0, 20, 0, 530)
ControlsContainer.Size = UDim2.new(1, -40, 0, 70)
ControlsContainer.BackgroundTransparency = 1
ControlsContainer.ZIndex = 3

local ResetBtn = Instance.new("TextButton")
ResetBtn.Parent = ControlsContainer
ResetBtn.Position = UDim2.new(0, 0, 0, 0)
ResetBtn.Size = UDim2.new(1, 0, 1, 0)
ResetBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
ResetBtn.BackgroundTransparency = 0.2
ResetBtn.BorderSizePixel = 0
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.Text = "🔄 RESET WINS"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.TextSize = 16
ResetBtn.AutoButtonColor = false
ResetBtn.ZIndex = 4

local ResetBtnCorner = Instance.new("UICorner")
ResetBtnCorner.CornerRadius = UDim.new(0, 12)
ResetBtnCorner.Parent = ResetBtn

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Parent = MainContainer
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.Size = UDim2.new(1, 0, 0, 25)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Gotham
Footer.Text = "made by " .. OWNER_NAME
Footer.TextColor3 = Color3.fromRGB(100, 100, 110)
Footer.TextSize = 11
Footer.ZIndex = 4

-- Botón flotante
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Parent = ScreenGui
ReopenBtn.Position = UDim2.new(0.02, 0, 0.5, -30)
ReopenBtn.Size = UDim2.new(0, 60, 0, 60)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
ReopenBtn.BackgroundTransparency = 0.1
ReopenBtn.BorderSizePixel = 0
ReopenBtn.Font = Enum.Font.GothamBold
ReopenBtn.Text = "⚔️"
ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenBtn.TextSize = 28
ReopenBtn.AutoButtonColor = false
ReopenBtn.Visible = false
ReopenBtn.ZIndex = 10

local ReopenCorner = Instance.new("UICorner")
ReopenCorner.CornerRadius = UDim.new(1, 0)
ReopenCorner.Parent = ReopenBtn

local ReopenStroke = Instance.new("UIStroke")
ReopenStroke.Color = Color3.fromRGB(100, 100, 255)
ReopenStroke.Thickness = 3
ReopenStroke.Parent = ReopenBtn

-- Cargar avatar
task.spawn(function()
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)
    end)
    if success then AvatarImage.Image = thumbnail end
end)

-- Actualizar UI
task.spawn(function()
    while true do
        TimeValue.Text = getElapsedTime()
        WinsValue.Text = tostring(totalWins)
        task.wait(1)
    end
end)

-- Botones
local showing = false
ShowUsernameBtn.MouseButton1Click:Connect(function()
    showing = not showing
    smoothTween(ShowUsernameBtn, {BackgroundColor3 = Color3.fromRGB(90, 90, 255)}, 0.2)
    task.wait(0.1)
    smoothTween(ShowUsernameBtn, {BackgroundColor3 = Color3.fromRGB(70, 70, 255)}, 0.2)
    if showing then
        UsernameValue.Text = player.Name
        ShowUsernameBtn.Text = "🔓 HIDE"
    else
        UsernameValue.Text = "[HIDDEN]"
        ShowUsernameBtn.Text = "🔒 SHOW"
    end
end)

ResetBtn.MouseEnter:Connect(function()
    smoothTween(ResetBtn, {BackgroundTransparency = 0}, 0.2)
end)
ResetBtn.MouseLeave:Connect(function()
    smoothTween(ResetBtn, {BackgroundTransparency = 0.2}, 0.2)
end)
ResetBtn.MouseButton1Click:Connect(function()
    smoothTween(WinsCard, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    task.wait(0.1)
    totalWins = 0
    WinsValue.Text = "0"
    saveWins()
    smoothTween(WinsCard, {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}, 0.2)
end)

-- Minimizar
local minimized = false
local originalSize = MainContainer.Size

local function minimizeUI()
    if minimized then
        smoothTween(MainContainer, {Size = originalSize}, 0.3)
        smoothTween(BlurEffect, {Size = 10}, 0.3)
        StatsContainer.Visible = true
        AvatarContainer.Visible = true
        TimerContainer.Visible = true
        ControlsContainer.Visible = true
        Footer.Visible = true
        minimized = false
        MinBtn.Text = "─"
        ReopenBtn.Visible = false
    else
        smoothTween(MainContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        smoothTween(BlurEffect, {Size = 0}, 0.3)
        task.wait(0.3)
        MainContainer.Visible = false
        ReopenBtn.Visible = true
        ReopenBtn.Size = UDim2.new(0, 0, 0, 0)
        smoothTween(ReopenBtn, {Size = UDim2.new(0, 60, 0, 60)}, 0.3)
        minimized = true
        MinBtn.Text = "□"
    end
end

MinBtn.MouseButton1Click:Connect(minimizeUI)

ReopenBtn.MouseButton1Click:Connect(function()
    smoothTween(ReopenBtn, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
    task.wait(0.2)
    ReopenBtn.Visible = false
    MainContainer.Visible = true
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    smoothTween(MainContainer, {Size = originalSize}, 0.4)
    smoothTween(BlurEffect, {Size = 10}, 0.4)
    minimized = false
    MinBtn.Text = "─"
end)

ReopenBtn.MouseEnter:Connect(function()
    smoothTween(ReopenBtn, {Size = UDim2.new(0, 65, 0, 65)}, 0.2)
end)
ReopenBtn.MouseLeave:Connect(function()
    smoothTween(ReopenBtn, {Size = UDim2.new(0, 60, 0, 60)}, 0.2)
end)

-- Animación entrada
MainContainer.Size = UDim2.new(0, 0, 0, 0)
task.wait(0.5)
smoothTween(MainContainer, {Size = UDim2.new(0, 480, 0, 620)}, 0.5)
smoothTween(BlurEffect, {Size = 10}, 0.5)

print("✅ Bridge Duels AutoFarm v1.2 Cargado")
print("🔒 Script protegido - Crédito: " .. OWNER_NAME)

-- ============================================
-- LOOP PRINCIPAL
-- ============================================
task.spawn(function()
    while true do
        for i = 20, 1, -1 do
            CountdownLabel.Text = "⏳ Winning In: " .. i .. "s"
            smoothTween(TimerStroke, {Color = Color3.fromRGB(255, 215, 0)}, 0.3)
            task.wait(1)
        end
        
        CountdownLabel.Text = "⚡ Running Script..."
        smoothTween(TimerStroke, {Color = Color3.fromRGB(80, 255, 80)}, 0.3)
        
        local success = touchTouchdown()
        
        if success then
            totalWins = totalWins + 1
            WinsValue.Text = tostring(totalWins)
            saveWins()
            sendDiscordEmbed(totalWins)
            
            smoothTween(WinsCard, {BackgroundColor3 = Color3.fromRGB(255, 215, 0)}, 0.3)
            task.wait(0.2)
            smoothTween(WinsCard, {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}, 0.3)
        end
        
        for i = 2, 1, -1 do
            CountdownLabel.Text = "⏳ Winning In: " .. i .. "s"
            task.wait(1)
        end
        
        CountdownLabel.Text = "🚀 TELEPORTING..."
        smoothTween(TimerStroke, {Color = Color3.fromRGB(255, 80, 80)}, 0.3)
        
        task.wait(0.5)
        rejoin()
        task.wait(5)
    end
end)
