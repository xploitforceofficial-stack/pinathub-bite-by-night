-- =======================================================
-- PINATHUB | BE A LUCKY BLOCK + BITE BY NIGHT
-- Complete Integration - WindUI (Fixed Dropdown)
-- =======================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Player = Players.LocalPlayer
local UIS = UserInputService
local camera = workspace.CurrentCamera

-- =======================================================
-- ANTI AFK
-- =======================================================
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- =======================================================
-- NOTIFICATION SYSTEM
-- =======================================================
local notifHolder = Instance.new("ScreenGui")
notifHolder.Name = "PinatHubNotifications"
notifHolder.ResetOnSpawn = false
notifHolder.Parent = Player:WaitForChild("PlayerGui")

local notifFrame = Instance.new("Frame")
notifFrame.Name = "NotificationHolder"
notifFrame.Size = UDim2.new(0, 350, 1, -20)
notifFrame.Position = UDim2.new(1, -370, 0, 10)
notifFrame.BackgroundTransparency = 1
notifFrame.Parent = notifHolder

local notifList = Instance.new("UIListLayout")
notifList.Name = "NotifList"
notifList.Padding = UDim.new(0, 8)
notifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifList.VerticalAlignment = Enum.VerticalAlignment.Top
notifList.SortOrder = Enum.SortOrder.LayoutOrder
notifList.Parent = notifFrame

local function ShowNotification(title, message, duration)
    duration = duration or 3
    
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 330, 0, 70)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    notif.BackgroundTransparency = 1
    notif.BorderSizePixel = 0
    notif.ClipsDescendants = true
    notif.Parent = notifFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 90)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = notif
    
    local accent = Instance.new("Frame")
    accent.Name = "Accent"
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    accent.BorderSizePixel = 0
    accent.Parent = notif
    
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 4)
    accentCorner.Parent = accent
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 14, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = notif
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 18)
    messageLabel.Position = UDim2.new(0, 14, 0, 32)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.Parent = notif
    
    local progressBg = Instance.new("Frame")
    progressBg.Name = "ProgressBg"
    progressBg.Size = UDim2.new(1, -20, 0, 3)
    progressBg.Position = UDim2.new(0, 10, 1, -8)
    progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    progressBg.BorderSizePixel = 0
    progressBg.Parent = notif
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBg
    
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.new(1, 0, 1, 0)
    progress.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    progress.BorderSizePixel = 0
    progress.Parent = progressBg
    
    local progressCorner2 = Instance.new("UICorner")
    progressCorner2.CornerRadius = UDim.new(1, 0)
    progressCorner2.Parent = progress
    
    notif.Position = UDim2.new(1, 50, 0, 0)
    
    local fadeIn = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -340, 0, 0),
        BackgroundTransparency = 0
    })
    
    local fadeOut = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0, 0),
        BackgroundTransparency = 1
    })
    
    local progressTween = TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    fadeIn:Play()
    progressTween:Play()
    
    task.delay(duration, function()
        if notif and notif.Parent then
            fadeOut:Play()
            task.wait(0.3)
            pcall(function() notif:Destroy() end)
        end
    end)
    
    return notif
end

-- =======================================================
-- LOGO LAUNCHER
-- =======================================================
local logoGui = Instance.new("ScreenGui")
logoGui.Name = "PinatHubLogo"
logoGui.ResetOnSpawn = false
logoGui.Parent = Player:WaitForChild("PlayerGui", 5)

local logoButton = Instance.new("ImageButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0.5, -30, 0.5, -30)
logoButton.BackgroundTransparency = 1
logoButton.Image = "rbxassetid://118264723961739"
logoButton.ImageColor3 = Color3.fromRGB(180, 0, 255)
logoButton.ScaleType = Enum.ScaleType.Fit
logoButton.Parent = logoGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = logoButton

local hoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)})
local unhoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)})

logoButton.MouseEnter:Connect(function()
    hoverTween:Play()
end)

logoButton.MouseLeave:Connect(function()
    unhoverTween:Play()
end)

local dragging = false
local dragInput, dragStart, startPos

logoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = logoButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

logoButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        logoButton.Position = newPos
    end
end)

-- =======================================================
-- LOAD WINDUI
-- =======================================================
local WindUI = (function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua", true))()
    end)
    return success and result or nil
end)()

if not WindUI then 
    ShowNotification("Error", "Failed to load WindUI Library", 5)
    return 
end

-- =======================================================
-- CREATE CUSTOM WINDOW
-- =======================================================
local Window = WindUI:CreateWindow({
    Title = "PinatHub",
    Author = "Be a Lucky Block",
    Folder = "PinatHub",
    NewElements = true,
    OpenButton = {
        Enabled = false
    },
    Topbar = { Height = 44, ButtonsType = "Default" }
})

Window:Tag({ Title = "Bite By Night Integration", Icon = "star", Color = Color3.fromHex("#BA00FF"), Border = true })

local guiVisible = true
logoButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    if Window then
        pcall(function()
            if guiVisible then
                Window:Open()
            else
                Window:Minimize()
            end
        end)
    end
end)

-- =======================================================
-- CREATE TABS
-- =======================================================
local MainTab = Window:Tab({ Title = "Main", Icon = "box" })
local SurvivorTab = Window:Tab({ Title = "Survivor", Icon = "shield" })
local VisualTab = Window:Tab({ Title = "Visual", Icon = "eye" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })
local CommunityTab = Window:Tab({ Title = "Community", Icon = "users" })

-- =======================================================
-- MAIN TAB - MOVEMENT FEATURES
-- =======================================================

MainTab:Section({ Title = "Character Movement" })

-- Infinite Sprint
local infiniteSprint = false
local sprintConn = nil
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

MainTab:Toggle({
    Title = "Infinite Sprint",
    Desc = "Allows You To Sprint Forever.",
    Value = false,
    Callback = function(state)
        infiniteSprint = state
        if state then
            sprintConn = RunService.Heartbeat:Connect(function()
                if not infiniteSprint then return end
                local char = Player.Character
                if not char then return end
                if isMobile then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.MoveDirection.Magnitude > 0 then
                        char:SetAttribute("WalkSpeed", 24)
                    else
                        char:SetAttribute("WalkSpeed", 12)
                    end
                else
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                        char:SetAttribute("WalkSpeed", 25)
                    else
                        char:SetAttribute("WalkSpeed", 12)
                    end
                end
            end)
            ShowNotification("Infinite Sprint", "Enabled.", 2)
        else
            if sprintConn then sprintConn:Disconnect() end
            local char = Player.Character
            if char then char:SetAttribute("WalkSpeed", 12) end
            ShowNotification("Infinite Sprint", "Disabled.", 2)
        end
    end
})

MainTab:Space()

-- Allow Jumping (Jump Boost)
local jumpBoost = false
local jpLoop = nil
local jpCA = nil

MainTab:Toggle({
    Title = "Allow Jumping",
    Desc = "Allows You To Jump Higher.",
    Value = false,
    Callback = function(state)
        jumpBoost = state
        if jumpBoost then
            local function applyJumpPower()
                local char = Player.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                if hum.UseJumpPower then
                    hum.JumpPower = 1.5
                else
                    hum.JumpHeight = 1.5
                end
            end
            applyJumpPower()
            if jpLoop then jpLoop:Disconnect() end
            local currentHum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if currentHum then
                jpLoop = currentHum:GetPropertyChangedSignal("JumpPower"):Connect(applyJumpPower)
            end
            if jpCA then jpCA:Disconnect() end
            jpCA = Player.CharacterAdded:Connect(function(newChar)
                local hum = newChar:WaitForChild("Humanoid")
                applyJumpPower()
                if jpLoop then jpLoop:Disconnect() end
                jpLoop = hum:GetPropertyChangedSignal("JumpPower"):Connect(applyJumpPower)
            end)
            ShowNotification("Allow Jumping", "Enabled.", 2)
        else
            if jpLoop then jpLoop:Disconnect() end
            if jpCA then jpCA:Disconnect() end
            local char = Player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    if hum.UseJumpPower then
                        hum.JumpPower = 0
                    else
                        hum.JumpHeight = 0
                    end
                end
            end
            ShowNotification("Allow Jumping", "Disabled.", 2)
        end
    end
})

MainTab:Space()

-- Infinite Jump
local InfiniteJumpEnabled = false

MainTab:Toggle({
    Title = "Infinite Jump",
    Desc = "Enable unlimited jumps",
    Value = false,
    Callback = function(value)
        InfiniteJumpEnabled = value
        if value then
            ShowNotification("Infinite Jump", "Enabled", 2)
        else
            ShowNotification("Infinite Jump", "Disabled", 2)
        end
    end
})

MainTab:Space()

-- Noclip
local noclipEnabled = false
local noclipConn = nil

MainTab:Toggle({
    Title = "Noclip",
    Desc = "Allows You To Clip Through Walls.",
    Value = false,
    Callback = function(state)
        noclipEnabled = state
        if state then
            noclipConn = RunService.Stepped:Connect(function()
                if not noclipEnabled then return end
                local char = Player.Character
                if not char then return end
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
            ShowNotification("Noclip", "Enabled.", 2)
        else
            if noclipConn then noclipConn:Disconnect() end
            local char = Player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
            ShowNotification("Noclip", "Disabled.", 2)
        end
    end
})

MainTab:Space()

-- Full Bright
local oldLighting = {}

MainTab:Toggle({
    Title = "Full Bright",
    Desc = "WHO TURNED ON THE LIGHTS?!!",
    Value = false,
    Callback = function(state)
        local lighting = game:GetService("Lighting")
        if state then
            oldLighting.Brightness = lighting.Brightness
            oldLighting.ClockTime = lighting.ClockTime
            oldLighting.FogEnd = lighting.FogEnd
            oldLighting.GlobalShadows = lighting.GlobalShadows
            oldLighting.Ambient = lighting.Ambient
            lighting.Brightness = 5
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
            lighting.Ambient = Color3.fromRGB(255,255,255)
            ShowNotification("Full Bright", "Enabled.", 2)
        else
            if next(oldLighting) then
                lighting.Brightness = oldLighting.Brightness
                lighting.ClockTime = oldLighting.ClockTime
                lighting.FogEnd = oldLighting.FogEnd
                lighting.GlobalShadows = oldLighting.GlobalShadows
                lighting.Ambient = oldLighting.Ambient
            end
            ShowNotification("Full Bright", "Disabled.", 2)
        end
    end
})

-- =======================================================
-- SURVIVOR TAB
-- =======================================================

SurvivorTab:Section({ Title = "Generator Features" })

-- Auto Generator
local autogen = false
local genconn = nil
local firingconn = nil
local lastfiretime = 0
local mode = "Blatant"

-- Generator Mode Dropdown (Fixed - using proper WindUI format)
SurvivorTab:Dropdown({
    Title = "Generator Mode",
    Desc = "Select generator mode",
    Values = {"Blatant", "Silent"},
    Value = "Blatant",
    Callback = function(selected)
        mode = selected
        if autogen then
            ShowNotification("Auto Generator", "Current Mode: " .. mode, 2)
        end
    end
})

SurvivorTab:Toggle({
    Title = "Auto Generator",
    Desc = "Automatically Does Generator Tasks.",
    Value = false,
    Callback = function(v)
        autogen = v
        
        if autogen then
            ShowNotification("Auto Generator", "Enabled.", 2)
            
            genconn = RunService.Heartbeat:Connect(function()
                local plr = Player
                local gengui = plr.PlayerGui:FindFirstChild("Gen")
                
                if gengui and not firingconn then
                    if mode == "Silent" then
                        task.wait(10)
                    end
                    
                    if gengui and gengui.Parent and autogen then
                        firingconn = RunService.Heartbeat:Connect(function()
                            if mode == "Blatant" then
                                if plr.PlayerGui:FindFirstChild("Gen") then
                                    local args = {{
                                        Wires = true,
                                        Switches = true,
                                        Lever = true
                                    }}
                                    plr.PlayerGui.Gen.GeneratorMain.Event:FireServer(unpack(args))
                                else
                                    if firingconn then
                                        firingconn:Disconnect()
                                        firingconn = nil
                                    end
                                end
                            else
                                local currenttime = tick()
                                if plr.PlayerGui:FindFirstChild("Gen") and (currenttime - lastfiretime >= 5) then
                                    local args = {{
                                        Wires = true,
                                        Switches = true,
                                        Lever = true
                                    }}
                                    plr.PlayerGui.Gen.GeneratorMain.Event:FireServer(unpack(args))
                                    lastfiretime = currenttime
                                elseif not plr.PlayerGui:FindFirstChild("Gen") then
                                    if firingconn then
                                        firingconn:Disconnect()
                                        firingconn = nil
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        else
            ShowNotification("Auto Generator", "Disabled.", 2)
            
            if genconn then
                genconn:Disconnect()
                genconn = nil
            end
            if firingconn then
                firingconn:Disconnect()
                firingconn = nil
            end
            lastfiretime = 0
        end
    end
})

SurvivorTab:Space()

-- Auto Escape
local autoEscape = false
local autoEscapeConn

SurvivorTab:Toggle({
    Title = "Auto Escape",
    Desc = "Automatically Escapes The Map.",
    Value = false,
    Callback = function(state)
        autoEscape = state
        if state then
            ShowNotification("Auto Escape", "Enabled.", 2)
            local teleported = false
            autoEscapeConn = RunService.RenderStepped:Connect(function()
                if teleported or not autoEscape then return end
                local char = Player.Character
                if not char then return end
                if not workspace.GAME.CAN_ESCAPE.Value then return end
                local playersFolder = workspace:FindFirstChild("PLAYERS")
                if not playersFolder or char.Parent ~= playersFolder:FindFirstChild("ALIVE") then return end
                local gameMap = workspace.MAPS:FindFirstChild("GAME MAP")
                if not gameMap then return end
                local escapes = gameMap:FindFirstChild("Escapes")
                if not escapes then return end
                for _,part in pairs(escapes:GetChildren()) do
                    if part:IsA("BasePart") and part:GetAttribute("Enabled") then
                        local highlight = part:FindFirstChildOfClass("Highlight")
                        if highlight and highlight.Enabled then
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                teleported = true
                                root.Anchored = true
                                char.PrimaryPart.CFrame = part.CFrame
                                task.delay(1.5,function() if root then root.Anchored = false end end)
                                task.delay(10,function() teleported = false end)
                            end
                        end
                    end
                end
            end)
        else
            if autoEscapeConn then autoEscapeConn:Disconnect() end
            ShowNotification("Auto Escape", "Disabled.", 2)
        end
    end
})

SurvivorTab:Space()

-- Auto Barricade
local dotEnabled = false
local dotConn

SurvivorTab:Toggle({
    Title = "Auto Barricade",
    Desc = "Forces Barricading Dot In The Middle.",
    Value = false,
    Callback = function(state)
        dotEnabled = state
        local gui = Player:WaitForChild("PlayerGui")
        if state then
            dotConn = RunService.RenderStepped:Connect(function()
                local dot = gui:FindFirstChild("Dot")
                if dot and dot:IsA("ScreenGui") then
                    local container = dot:FindFirstChild("Container")
                    if container then
                        local frame = container:FindFirstChild("Frame")
                        if frame and frame:IsA("GuiObject") then
                            if not dot.Enabled then
                                dot:Destroy()
                                return
                            end
                            frame.AnchorPoint = Vector2.new(0.5,0.5)
                            frame.Position = UDim2.new(0.5,0,0.5,0)
                        end
                    end
                end
            end)
            ShowNotification("Auto Barricade", "Enabled.", 2)
        else
            if dotConn then dotConn:Disconnect() end
            ShowNotification("Auto Barricade", "Disabled.", 2)
        end
    end
})

SurvivorTab:Space()

-- Safety Area
local safeTeleport = false
local safePart = nil
local speed = 25

local function getRoot()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function lerpMove(targetCF)
    local root = getRoot()
    local startCF = root.CFrame
    local dist = (startCF.Position - targetCF.Position).Magnitude
    local duration = dist / speed
    local t = 0
    while t < duration do
        t += RunService.Heartbeat:Wait()
        local alpha = math.clamp(t / duration,0,1)
        root.CFrame = startCF:Lerp(targetCF,alpha)
    end
    root.CFrame = targetCF
end

SurvivorTab:Toggle({
    Title = "Safety Area",
    Desc = "Teleports To A Safe Area.",
    Value = false,
    Callback = function(state)
        safeTeleport = state
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if state then
            local pos = root.Position
            safePart = Instance.new("Part")
            safePart.Size = Vector3.new(50,1,50)
            safePart.Anchored = true
            safePart.Position = pos - Vector3.new(0,100,0)
            safePart.Name = "SafetyPlate"
            safePart.Parent = workspace
            task.spawn(function()
                lerpMove(CFrame.new(pos - Vector3.new(0,95,0)))
            end)
            ShowNotification("Safety Area","Enabled.",2)
        else
            local pos = root.Position
            if safePart then
                safePart:Destroy()
                safePart = nil
            end
            task.spawn(function()
                lerpMove(CFrame.new(pos + Vector3.new(0,100,0)))
            end)
            ShowNotification("Safety Area","Disabled.",2)
        end
    end
})

SurvivorTab:Space()

-- View Killer
local viewKiller = false
local killerAddedConn
local killerRemovedConn

SurvivorTab:Toggle({
    Title = "View Killer",
    Desc = "Views The Killer.",
    Value = false,
    Callback = function(state)
        viewKiller = state
        if state then
            local function setKillerCamera(killerChar)
                local hum = killerChar:FindFirstChildOfClass("Humanoid")
                if hum then camera.CameraSubject = hum end
            end
            local playersFolder = workspace:FindFirstChild("PLAYERS")
            local killerFolder = playersFolder and playersFolder:FindFirstChild("KILLER")
            if killerFolder then
                local currentKiller = killerFolder:GetChildren()[1]
                if currentKiller then setKillerCamera(currentKiller) end
                killerAddedConn = killerFolder.ChildAdded:Connect(setKillerCamera)
                killerRemovedConn = killerFolder.ChildRemoved:Connect(function()
                    if viewKiller then
                        local char = Player.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum then camera.CameraSubject = hum end
                    end
                end)
            end
            ShowNotification("View Killer", "Enabled.", 2)
        else
            if killerAddedConn then killerAddedConn:Disconnect() end
            if killerRemovedConn then killerRemovedConn:Disconnect() end
            local char = Player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then camera.CameraSubject = hum end
            ShowNotification("View Killer", "Disabled.", 2)
        end
    end
})

SurvivorTab:Space()

-- Auto Parry Features
SurvivorTab:Section({ Title = "Auto Parry Features" })

getgenv().AutoParryEnabled = false

local attackAnimIds = {
    "rbxassetid://70869035406359",
    "rbxassetid://106673226682917",
    "rbxassetid://112503015929213",
    "rbxassetid://120428956410756",
    "rbxassetid://102810363618918",
    "rbxassetid://133752270724243",
    "rbxassetid://71147082224885"
}

local parryConnection = nil

local function isAttackAnimation(track)
    if not track or not track.Animation then return false end
    local id = track.Animation.AnimationId
    for _, aid in ipairs(attackAnimIds) do
        if id == aid then return true end
    end
    return false
end

local function getParryRange(track)
    if track and track.Animation.AnimationId == "rbxassetid://133752270724243" then
        return getgenv().PullAttackRange or 50
    end
    return getgenv().BasicAttackRange or 30
end

SurvivorTab:Toggle({
    Title = "Auto Parry",
    Desc = "Automatically Attempts To Parry Killer Attacks.",
    Value = false,
    Callback = function(v)
        getgenv().AutoParryEnabled = v
        if getgenv().AutoParryEnabled then
            ShowNotification("Auto Parry", "Enabled.", 2)
            parryConnection = RunService.Heartbeat:Connect(function()
                if not getgenv().AutoParryEnabled then return end
                local lp = Player
                local char = lp.Character
                if not char then return end
                local myRoot = char:FindFirstChild("HumanoidRootPart")
                if not myRoot then return end
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr == lp then continue end
                    local pchar = plr.Character
                    if not pchar then continue end
                    local attackerRoot = pchar:FindFirstChild("HumanoidRootPart")
                    if not attackerRoot then continue end
                    local diff = attackerRoot.Position - myRoot.Position
                    local range = getParryRange(nil)
                    if diff:Dot(diff) > range * range then continue end
                    local hum = pchar:FindFirstChildOfClass("Humanoid")
                    if not hum then continue end
                    local animator = hum:FindFirstChildOfClass("Animator")
                    if not animator then continue end
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        if track.IsPlaying and isAttackAnimation(track) then
                            local actualRange = getParryRange(track)
                            if diff:Dot(diff) > actualRange * actualRange then continue end
                            local directionToMe = diff.Unit
                            if attackerRoot.CFrame.LookVector:Dot(directionToMe) < 0.5 then
                                continue
                            end
                            local args = {
                                buffer.fromstring("\a"),
                                buffer.fromstring("\254\001\000\254\002\000\006\aAbility\001\002")
                            }
                            ReplicatedStorage:WaitForChild("Modules")
                                :WaitForChild("Warp"):WaitForChild("Index")
                                :WaitForChild("Event"):WaitForChild("Reliable"):FireServer(unpack(args))
                            break
                        end
                    end
                end
            end)
        else
            ShowNotification("Auto Parry", "Disabled.", 2)
            if parryConnection then
                parryConnection:Disconnect()
                parryConnection = nil
            end
        end
    end
})

SurvivorTab:Slider({
    Title = "Main Attacks Range",
    Desc = "Range for main attacks",
    Value = { Min = 10, Max = 50, Default = 30 },
    Callback = function(v)
        getgenv().BasicAttackRange = v
    end
})

SurvivorTab:Slider({
    Title = "Ennard Pull Attack Range",
    Desc = "Range for pull attack",
    Value = { Min = 10, Max = 75, Default = 50 },
    Callback = function(v)
        getgenv().PullAttackRange = v
    end
})

SurvivorTab:Space()

-- Anti Death Features
SurvivorTab:Section({ Title = "Anti Death Features" })

local antiDeath = {
    enabled = false,
    threshold = 30,
    conn = nil,
    lastPos = nil,
    teleported = false,
    debounce = false,
    plate = nil
}

local function returnToLastPos()
    if antiDeath.plate then
        antiDeath.plate:Destroy()
        antiDeath.plate = nil
    end
    if antiDeath.lastPos then
        task.spawn(function()
            lerpMove(antiDeath.lastPos)
        end)
    end
    antiDeath.lastPos = nil
    antiDeath.teleported = false
end

SurvivorTab:Toggle({
    Title = "Anti Death",
    Desc = "Automatically Detects Low Health And Teleports To A Safe Zone.",
    Value = false,
    Callback = function(state)
        antiDeath.enabled = state
        if state then
            antiDeath.conn = RunService.Heartbeat:Connect(function()
                local char = Player.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                if hum.Health < antiDeath.threshold and hum.Health > 0 and not antiDeath.teleported and not antiDeath.debounce then
                    antiDeath.debounce = true
                    antiDeath.teleported = true
                    antiDeath.lastPos = root.CFrame
                    local pos = root.Position
                    antiDeath.plate = Instance.new("Part")
                    antiDeath.plate.Size = Vector3.new(50,1,50)
                    antiDeath.plate.Anchored = true
                    antiDeath.plate.Position = pos - Vector3.new(0,100,0)
                    antiDeath.plate.Name = "AntiDeathPlate"
                    antiDeath.plate.Parent = workspace
                    task.spawn(function()
                        lerpMove(CFrame.new(pos - Vector3.new(0,95,0)))
                    end)
                    task.delay(1,function()
                        antiDeath.debounce = false
                    end)
                elseif hum.Health >= antiDeath.threshold and antiDeath.teleported and antiDeath.lastPos and not antiDeath.debounce then
                    antiDeath.debounce = true
                    returnToLastPos()
                    task.delay(1,function()
                        antiDeath.debounce = false
                    end)
                end
            end)
            ShowNotification("Anti Death","Enabled.",2)
        else
            if antiDeath.conn then
                antiDeath.conn:Disconnect()
            end
            if antiDeath.teleported then
                returnToLastPos()
            end
            antiDeath.debounce = false
            ShowNotification("Anti Death","Disabled.",2)
        end
    end
})

SurvivorTab:Slider({
    Title = "Health Threshold",
    Desc = "Health percentage to trigger anti death",
    Value = { Min = 25, Max = 80, Default = 30 },
    Rounding = 0.5,
    Callback = function(v)
        antiDeath.threshold = v
    end
})

-- =======================================================
-- VISUAL TAB - ESP FEATURES
-- =======================================================

local espMethod = "Highlight"
local esp = { survivors = {}, killers = {}, generators = {} }
local batteryHighlights = {}
local fuseHighlights = {}
local trapHighlights = {}
local minionHighlights = {}
local healthLabels = {}

local function newHighlight(obj, color)
    if not obj then return end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.FillTransparency = 0.5
    h.OutlineColor = color
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = obj
    h.Parent = obj
    return h
end

local function createDrawingBox()
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Filled = false
    box.Transparency = 1
    return box
end

local function updateDrawingBox(box, obj)
    if not box or not obj then return end
    local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
    if not root then return end
    local vector, onScreen = camera:WorldToViewportPoint(root.Position)
    if onScreen then
        local size = (camera:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0)) - vector).Y * 2.5
        box.Size = Vector2.new(size * 1.2, size)
        box.Position = Vector2.new(vector.X - box.Size.X / 2, vector.Y - box.Size.Y / 2)
        box.Visible = true
    else
        box.Visible = false
    end
end

local function createHealthLabel(char)
    if not char or healthLabels[char] then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    local labelGui = Instance.new("BillboardGui")
    labelGui.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
    labelGui.Size = UDim2.new(3, 0, 1, 0)
    labelGui.StudsOffset = Vector3.new(0, 3, 0)
    labelGui.AlwaysOnTop = true
    labelGui.LightInfluence = 0
    labelGui.Parent = char
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 16
    textLabel.Text = "100 / 100"
    textLabel.Parent = labelGui
    healthLabels[char] = {
        gui = labelGui,
        text = textLabel,
        humanoid = humanoid,
        connection = nil
    }
    local conn = humanoid.HealthChanged:Connect(function()
        if not healthLabels[char] then 
            conn:Disconnect()
            return 
        end
        local hp = math.floor(humanoid.Health)
        local maxHp = math.floor(humanoid.MaxHealth)
        healthLabels[char].text.Text = hp .. " / " .. maxHp
    end)
    healthLabels[char].connection = conn
    local hp = math.floor(humanoid.Health)
    local maxHp = math.floor(humanoid.MaxHealth)
    textLabel.Text = hp .. " / " .. maxHp
end

local function add(tbl, obj, color)
    if not obj or tbl[obj] then return end
    if espMethod == "Dual" then
        tbl[obj] = {
            highlight = newHighlight(obj, color),
            drawing = createDrawingBox()
        }
        tbl[obj].drawing.Color = color
    elseif espMethod == "Highlight" then
        tbl[obj] = newHighlight(obj, color)
    else
        local box = createDrawingBox()
        box.Color = color
        tbl[obj] = box
    end
    if tbl == esp.survivors then
        createHealthLabel(obj)
    end
end

local function remove(tbl, obj)
    if tbl[obj] then
        if typeof(tbl[obj]) == "table" then
            if tbl[obj].highlight then tbl[obj].highlight:Destroy() end
            if tbl[obj].drawing then tbl[obj].drawing:Remove() end
        elseif typeof(tbl[obj]) == "Instance" then
            tbl[obj]:Destroy()
        else
            tbl[obj]:Remove()
        end
        tbl[obj] = nil
    end
    if healthLabels[obj] then
        if healthLabels[obj].connection then
            healthLabels[obj].connection:Disconnect()
        end
        if healthLabels[obj].gui then
            healthLabels[obj].gui:Destroy()
        end
        healthLabels[obj] = nil
    end
end

local function clear(tbl)
    for obj, v in pairs(tbl) do
        if v then
            if typeof(v) == "table" then
                if v.highlight then v.highlight:Destroy() end
                if v.drawing then v.drawing:Remove() end
            elseif typeof(v) == "Instance" then
                v:Destroy()
            else
                v:Remove()
            end
        end
        tbl[obj] = nil
        if healthLabels[obj] then
            if healthLabels[obj].connection then
                healthLabels[obj].connection:Disconnect()
            end
            if healthLabels[obj].gui then
                healthLabels[obj].gui:Destroy()
            end
            healthLabels[obj] = nil
        end
    end
end

-- ESP Method Dropdown (Fixed - using proper WindUI format)
VisualTab:Dropdown({
    Title = "ESP Method",
    Desc = "Select ESP rendering method",
    Values = {"Highlight", "Drawing", "Dual"},
    Value = "Highlight",
    Callback = function(selected)
        espMethod = selected
        ShowNotification("ESP Method", "Changed to: " .. selected, 2)
    end
})

VisualTab:Toggle({
    Title = "Survivor ESP",
    Desc = "Highlight All Survivors.",
    Value = false,
    Callback = function(state)
        local playersFolder = workspace:FindFirstChild("PLAYERS")
        local alive = playersFolder and playersFolder:FindFirstChild("ALIVE")
        if not alive then 
            ShowNotification("Error", "Wait for match to start", 2)
            return 
        end
        if state then
            ShowNotification("Survivor ESP", "Enabled.", 2)
            for _, v in ipairs(alive:GetChildren()) do
                if v:IsA("Model") then add(esp.survivors, v, Color3.fromRGB(80,180,255)) end
            end
            esp.survivorAdd = alive.ChildAdded:Connect(function(v)
                if v:IsA("Model") then add(esp.survivors, v, Color3.fromRGB(80,180,255)) end
            end)
            esp.survivorRemove = alive.ChildRemoved:Connect(function(v) remove(esp.survivors, v) end)
        else
            ShowNotification("Survivor ESP", "Disabled.", 2)
            if esp.survivorAdd then esp.survivorAdd:Disconnect() end
            if esp.survivorRemove then esp.survivorRemove:Disconnect() end
            clear(esp.survivors)
        end
    end
})

VisualTab:Toggle({
    Title = "Killer ESP",
    Desc = "Highlights The Killer.",
    Value = false,
    Callback = function(state)
        local playersFolder = workspace:FindFirstChild("PLAYERS")
        local killers = playersFolder and playersFolder:FindFirstChild("KILLER")
        if not killers then 
            ShowNotification("Error", "Wait for match to start", 2)
            return 
        end
        if state then
            ShowNotification("Killer ESP", "Enabled.", 2)
            for _, v in ipairs(killers:GetChildren()) do
                if v:IsA("Model") then add(esp.killers, v, Color3.fromRGB(255,80,80)) end
            end
            esp.killerAdd = killers.ChildAdded:Connect(function(v)
                if v:IsA("Model") then add(esp.killers, v, Color3.fromRGB(255,80,80)) end
            end)
            esp.killerRemove = killers.ChildRemoved:Connect(function(v) remove(esp.killers, v) end)
        else
            ShowNotification("Killer ESP", "Disabled.", 2)
            if esp.killerAdd then esp.killerAdd:Disconnect() end
            if esp.killerRemove then esp.killerRemove:Disconnect() end
            clear(esp.killers)
        end
    end
})

VisualTab:Toggle({
    Title = "Generator ESP",
    Desc = "Highlights All Generators.",
    Value = false,
    Callback = function(state)
        if state then
            ShowNotification("Generator ESP", "Enabled.", 2)
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == "Generator" then
                    add(esp.generators, v, Color3.fromRGB(0,255,100))
                end
            end
            esp.genAdd = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") and v.Name == "Generator" then add(esp.generators, v, Color3.fromRGB(0,255,100)) end
            end)
            esp.genRemove = workspace.DescendantRemoving:Connect(function(v)
                if esp.generators[v] then remove(esp.generators, v) end
            end)
        else
            ShowNotification("Generator ESP", "Disabled.", 2)
            if esp.genAdd then esp.genAdd:Disconnect() end
            if esp.genRemove then esp.genRemove:Disconnect() end
            clear(esp.generators)
        end
    end
})

VisualTab:Toggle({
    Title = "Battery ESP",
    Desc = "Highlights All Batteries.",
    Value = false,
    Callback = function(state)
        if state then
            ShowNotification("Battery ESP", "Enabled.", 2)
            local ignore = workspace:FindFirstChild("IGNORE")
            if ignore then
                for _, v in ipairs(ignore:GetDescendants()) do
                    if v:IsA("MeshPart") and v.Name == "Battery" then
                        local h = newHighlight(v, Color3.fromRGB(255, 0, 255))
                        if h then batteryHighlights[v] = h end
                    end
                end
            end
            batteryConn = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("MeshPart") and v.Name == "Battery" then
                    local h = newHighlight(v, Color3.fromRGB(255, 0, 255))
                    if h then batteryHighlights[v] = h end
                end
            end)
        else
            ShowNotification("Battery ESP", "Disabled.", 2)
            if batteryConn then batteryConn:Disconnect() batteryConn = nil end
            for _, h in pairs(batteryHighlights) do if h then h:Destroy() end end
            batteryHighlights = {}
        end
    end
})

VisualTab:Toggle({
    Title = "Fuse Box ESP",
    Desc = "Highlights All Fuse Boxes.",
    Value = false,
    Callback = function(state)
        if state then
            ShowNotification("Fuse Box ESP", "Enabled.", 2)
            local mapsFolder = workspace:FindFirstChild("MAPS")
            if mapsFolder then
                local gameMap = mapsFolder:FindFirstChild("GAME MAP")
                if gameMap then
                    local fuseBoxes = gameMap:FindFirstChild("FuseBoxes")
                    if fuseBoxes then
                        for _, fuseBox in ipairs(fuseBoxes:GetChildren()) do
                            local battery = fuseBox:FindFirstChild("Battery")
                            if battery then
                                local h = newHighlight(battery, Color3.fromRGB(0, 255, 255))
                                if h then fuseHighlights[battery] = h end
                            end
                        end
                    end
                end
            end
            fuseConn = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("BasePart") and v.Name == "Battery" and v.Parent and v.Parent.Name == "FuseBox" then
                    task.wait(0.1)
                    local h = newHighlight(v, Color3.fromRGB(0, 255, 255))
                    if h then fuseHighlights[v] = h end
                end
            end)
        else
            ShowNotification("Fuse Box ESP", "Disabled.", 2)
            if fuseConn then fuseConn:Disconnect() fuseConn = nil end
            for _, h in pairs(fuseHighlights) do if h then h:Destroy() end end
            fuseHighlights = {}
        end
    end
})

VisualTab:Toggle({
    Title = "Bear Trap ESP",
    Desc = "Highlights All Bear Traps.",
    Value = false,
    Callback = function(state)
        if state then
            ShowNotification("Trap ESP", "Enabled.", 2)
            local ignore = workspace:FindFirstChild("IGNORE")
            if ignore then
                for _, obj in ipairs(ignore:GetChildren()) do
                    if obj:IsA("Model") and obj.Name == "Trap" then
                        local h = newHighlight(obj, Color3.fromRGB(255, 100, 0))
                        if h then trapHighlights[obj] = h end
                    end
                end
            end
            descendantConn = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") and v.Name == "Trap" then
                    task.wait(0.1)
                    local h = newHighlight(v, Color3.fromRGB(255, 100, 0))
                    if h then trapHighlights[v] = h end
                end
            end)
        else
            ShowNotification("Trap ESP", "Disabled.", 2)
            if descendantConn then descendantConn:Disconnect() descendantConn = nil end
            for _, h in pairs(trapHighlights) do if h then h:Destroy() end end
            trapHighlights = {}
        end
    end
})

VisualTab:Toggle({
    Title = "Minion ESP",
    Desc = "Highlights All Minions.",
    Value = false,
    Callback = function(state)
        if state then
            ShowNotification("Minion ESP", "Enabled.", 2)
            local ignore = workspace:FindFirstChild("IGNORE")
            if ignore then
                for _, obj in ipairs(ignore:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "Minion" then
                        local h = newHighlight(obj, Color3.fromRGB(255, 165, 0))
                        if h then minionHighlights[obj] = h end
                    end
                end
            end
            minionConn = workspace.DescendantAdded:Connect(function(obj)
                if obj:IsA("Model") and obj.Name == "Minion" then
                    local h = newHighlight(obj, Color3.fromRGB(255, 165, 0))
                    if h then minionHighlights[obj] = h end
                end
            end)
        else
            ShowNotification("Minion ESP", "Disabled.", 2)
            if minionConn then minionConn:Disconnect() minionConn = nil end
            for _, h in pairs(minionHighlights) do if h then h:Destroy() end end
            minionHighlights = {}
        end
    end
})

-- Render ESP drawings
RunService.RenderStepped:Connect(function()
    if espMethod ~= "Drawing" and espMethod ~= "Dual" then return end
    for _, tbl in pairs({esp.survivors, esp.killers, esp.generators}) do
        for obj, data in pairs(tbl) do
            if typeof(data) == "table" and data.drawing then
                updateDrawingBox(data.drawing, obj)
            elseif typeof(data) ~= "Instance" then
                updateDrawingBox(data, obj)
            end
        end
    end
end)

-- =======================================================
-- TELEPORT TAB
-- =======================================================

local lerping = false
local currentTarget = nil
local teleportSpeed = 25

local function lerpTo(targetCFrame)
    local _, root = getRoot()
    local targetPos = targetCFrame.Position
    if currentTarget and (currentTarget - targetPos).Magnitude < 0.5 then
        lerping = false
        currentTarget = nil
        return
    end
    currentTarget = targetPos
    lerping = true
    while lerping and root.Parent do
        local currentPos = root.Position
        local direction = (targetPos - currentPos)
        local distance = direction.Magnitude
        if distance <= 0.5 then break end
        local step = math.min(teleportSpeed * RunService.RenderStepped:Wait(), distance)
        root.CFrame = CFrame.new(currentPos + direction.Unit * step, targetPos)
    end
    if lerping and root.Parent then
        root.CFrame = CFrame.new(targetPos)
    end
    lerping = false
    currentTarget = nil
end

local function TeleportTo(model)
    if not model then return end
    local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not part then return end
    local frontCFrame = part.CFrame * CFrame.new(0, 0, -5)
    lerpTo(frontCFrame)
end

local function getOrderedGenerators()
    local mapsFolder = workspace:FindFirstChild("MAPS")
    if not mapsFolder then return {} end
    local gameMap = mapsFolder:FindFirstChild("GAME MAP")
    if not gameMap then return {} end
    local generators = gameMap:FindFirstChild("Generators")
    if not generators then return {} end
    local models = {}
    for _,v in ipairs(generators:GetChildren()) do
        if v:IsA("Model") then table.insert(models,v) end
    end
    table.sort(models,function(a,b)
        local ao = a:GetAttribute("Order") or 0
        local bo = b:GetAttribute("Order") or 0
        return ao < bo
    end)
    return models
end

local generatorIndex = 1
TeleportTab:Button({
    Title = "Generator TP",
    Desc = "Teleports To A Generator. Click Again To Cancel.",
    Callback = function()
        local models = getOrderedGenerators()
        if #models == 0 then
            ShowNotification("Error", "Wait for match to start", 2)
            return
        end
        local model = models[generatorIndex]
        if not model then return end
        TeleportTo(model)
        generatorIndex += 1
        if generatorIndex > #models then generatorIndex = 1 end
    end
})

local batteryIndex = 1
TeleportTab:Button({
    Title = "Battery TP",
    Desc = "Teleports To A Battery. Click Again To Cancel.",
    Callback = function()
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local ignore = workspace:FindFirstChild("IGNORE")
        if not ignore then
            ShowNotification("Error", "No batteries found", 2)
            return
        end
        local batteries = {}
        for _, v in ipairs(ignore:GetDescendants()) do
            if v:IsA("MeshPart") and v.Name == "Battery" then
                table.insert(batteries, v)
            end
        end
        if #batteries == 0 then
            ShowNotification("Error", "No batteries found", 2)
            return
        end
        for i, v in ipairs(batteries) do
            v:SetAttribute("Order", i)
        end
        table.sort(batteries, function(a, b)
            return (a:GetAttribute("Order") or 0) < (b:GetAttribute("Order") or 0)
        end)
        local battery = batteries[batteryIndex]
        if not battery then return end
        local targetCFrame = battery.CFrame * CFrame.new(0, 3, 0)
        lerpTo(targetCFrame)
        batteryIndex += 1
        if batteryIndex > #batteries then batteryIndex = 1 end
    end
})

local fuseIndex = 1
TeleportTab:Button({
    Title = "Fuse Box TP",
    Desc = "Teleports To A Fuse Box. Click Again To Cancel.",
    Callback = function()
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local mapsFolder = workspace:FindFirstChild("MAPS")
        if not mapsFolder then
            ShowNotification("Error", "No fuse box found", 2)
            return
        end
        local gameMap = mapsFolder:FindFirstChild("GAME MAP")
        if not gameMap then
            ShowNotification("Error", "No fuse box found", 2)
            return
        end
        local fuseBoxes = gameMap:FindFirstChild("FuseBoxes")
        if not fuseBoxes then
            ShowNotification("Error", "No fuse box found", 2)
            return
        end
        local batteries = {}
        for _, fuseBox in ipairs(fuseBoxes:GetChildren()) do
            local battery = fuseBox:FindFirstChild("Battery")
            if battery and battery:IsA("BasePart") then
                table.insert(batteries, battery)
            end
        end
        if #batteries == 0 then
            ShowNotification("Error", "No fuse box found", 2)
            return
        end
        for i, v in ipairs(batteries) do
            v:SetAttribute("Order", i)
        end
        table.sort(batteries, function(a, b)
            return (a:GetAttribute("Order") or 0) < (b:GetAttribute("Order") or 0)
        end)
        local battery = batteries[fuseIndex]
        if not battery then return end
        local targetCFrame = battery.CFrame * CFrame.new(0, 3, 0)
        lerpTo(targetCFrame)
        fuseIndex += 1
        if fuseIndex > #batteries then fuseIndex = 1 end
    end
})

-- =======================================================
-- COMMUNITY TAB
-- =======================================================

local WhatsAppSection = CommunityTab:Section({ Title = "WhatsApp Group" })

WhatsAppSection:Button({
    Title = "Join WhatsApp Group",
    Desc = "Click to copy WhatsApp group link",
    Callback = function()
        if setclipboard then
            setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
            ShowNotification("Success", "WhatsApp link copied to clipboard!", 3)
        else
            ShowNotification("Error", "Clipboard not supported!", 2)
        end
    end
})

CommunityTab:Space()

local DiscordSection = CommunityTab:Section({ Title = "Discord Server" })

DiscordSection:Button({
    Title = "Join Discord Server",
    Desc = "Click to copy Discord server link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/eDbaHKEf7G")
            ShowNotification("Success", "Discord link copied to clipboard!", 3)
        else
            ShowNotification("Error", "Clipboard not supported!", 2)
        end
    end
})

CommunityTab:Space()

local CreditSection = CommunityTab:Section({ Title = "Credits" })

CreditSection:Paragraph({
    Title = "PinatHub",
    Desc = "by @viunze on tiktok"
})

-- =======================================================
-- INFINITE JUMP HANDLER
-- =======================================================
UserInputService.JumpRequest:connect(function()
    if InfiniteJumpEnabled then
        local char = Player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState("Jumping")
            end
        end
    end
end)

-- =======================================================
-- CHARACTER RESPAWN HANDLER
-- =======================================================
Player.CharacterAdded:Connect(function(character)
    task.wait(0.5)
end)

-- =======================================================
-- INITIAL NOTIFICATION
-- =======================================================
task.wait(1)
ShowNotification("PinatHub", "Loaded", 5)

print("PinatHub - Bite By Night Integration Loaded")
