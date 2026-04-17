local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

if CoreGui:FindFirstChild("KeulZHub") then
    CoreGui.KeulZHub:Destroy()
end

local Theme = {
    Background = Color3.fromRGB(8, 8, 12),
    Surface = Color3.fromRGB(15, 15, 20),
    Primary = Color3.fromRGB(200, 30, 50),
    Accent = Color3.fromRGB(255, 40, 70),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180)
}

local Settings = {
    Language = "PT",
    AntiAFK = false,
    AntiVoid = false,
    ESPEnabled = false,
    FullBright = false,
    InfiniteJump = false,
    NoClip = false,
    Fly = false
}

local Translations = {
    PT = {
        Misc = "Diversos",
        Hubs = "Hubs",
        Executor = "Executor",
        RemoteSpy = "Remote Spy",
        Player = "Jogador",
        Visual = "Visual",
        Teleport = "Teleporte",
        Config = "Configurações",
        Credits = "Créditos"
    },
    EN = {
        Misc = "Misc",
        Hubs = "Hubs",
        Executor = "Executor",
        RemoteSpy = "Remote Spy",
        Player = "Player",
        Visual = "Visual",
        Teleport = "Teleport",
        Config = "Settings",
        Credits = "Credits"
    }
}

local function T(key)
    return Translations[Settings.Language][key] or key
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeulZHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Theme.Primary
mainStroke.Thickness = 2
mainStroke.Parent = MainFrame

local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Theme.Surface
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = TopBar

local topFix = Instance.new("Frame")
topFix.Size = UDim2.new(1, 0, 0, 10)
topFix.Position = UDim2.new(0, 0, 1, -10)
topFix.BackgroundColor3 = Theme.Surface
topFix.BorderSizePixel = 0
topFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "KEULZ HUB"
Title.TextColor3 = Theme.Primary
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 2.5)
CloseButton.BackgroundColor3 = Theme.Primary
CloseButton.Text = "×"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Theme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 5)
sidebarPadding.PaddingLeft = UDim.new(0, 5)
sidebarPadding.PaddingRight = UDim.new(0, 5)
sidebarPadding.Parent = Sidebar

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 4)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -135, 1, -40)
ContentArea.Position = UDim2.new(0, 133, 0, 38)
ContentArea.BackgroundTransparency = 1
ContentArea.ClipsDescendants = true
ContentArea.Parent = MainFrame

local Pages = {}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Theme.Primary
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    Pages[name] = page
    return page
end

local function CreateSidebarButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.Parent = Sidebar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        if btn.Name ~= "Selected" then
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            }):Play()
        end
    end)
    
    return btn
end

local MiscPage = CreatePage("Misc")
local PlayerPage = CreatePage("Player")
local VisualPage = CreatePage("Visual")
local TeleportPage = CreatePage("Teleport")
local HubsPage = CreatePage("Hubs")
local ExecutorPage = CreatePage("Executor")
local RemoteSpyPage = CreatePage("RemoteSpy")
local ConfigPage = CreatePage("Config")
local CreditsPage = CreatePage("Credits")

local MiscBtn = CreateSidebarButton(T("Misc"), 1)
local PlayerBtn = CreateSidebarButton(T("Player"), 2)
local VisualBtn = CreateSidebarButton(T("Visual"), 3)
local TeleportBtn = CreateSidebarButton(T("Teleport"), 4)
local HubsBtn = CreateSidebarButton(T("Hubs"), 5)
local ExecutorBtn = CreateSidebarButton(T("Executor"), 6)
local RemoteSpyBtn = CreateSidebarButton(T("RemoteSpy"), 7)
local ConfigBtn = CreateSidebarButton(T("Config"), 8)
local CreditsBtn = CreateSidebarButton(T("Credits"), 9)

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.96, 0, 0, 35)
    btn.BackgroundColor3 = Theme.Surface
    btn.Text = text
    btn.TextColor3 = Theme.Primary
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Primary
    stroke.Thickness = 1
    stroke.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.Primary
        }):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.Surface
        }):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            TextColor3 = Theme.Primary
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

local function CreateToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.96, 0, 0, 40)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 45, 0, 22)
    switch.Position = UDim2.new(1, -50, 0.5, -11)
    switch.BackgroundColor3 = default and Theme.Primary or Color3.fromRGB(50, 50, 55)
    switch.Text = ""
    switch.BorderSizePixel = 0
    switch.Parent = frame
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switch
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 18, 0, 18)
    indicator.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    indicator.BorderSizePixel = 0
    indicator.Parent = switch
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator
    
    local state = default
    
    switch.MouseButton1Click:Connect(function()
        state = not state
        
        TweenService:Create(switch, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Theme.Primary or Color3.fromRGB(50, 50, 55)
        }):Play()
        
        TweenService:Create(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
        
        callback(state)
    end)
    
    return frame
end

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.96, 0, 0, 50)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0.93, 0, 0, 6)
    track.Position = UDim2.new(0.035, 0, 1, -14)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    track.BorderSizePixel = 0
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Primary
    fill.BorderSizePixel = 0
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local value = default
    
    local function updateSlider(input)
        local mousePos = input.Position.X
        local trackPos = track.AbsolutePosition.X
        local trackSize = track.AbsoluteSize.X
        
        local ratio = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
        value = math.floor(min + (max - min) * ratio)
        
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        label.Text = text .. ": " .. value
        
        callback(value)
    end
    
    local dragging = false
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return frame
end

CreateButton(MiscPage, "TP Tool", function()
    local tool = Instance.new("Tool")
    tool.Name = "KeulZ TP Tool"
    tool.RequiresHandle = false
    tool.Parent = Player.Backpack
    
    tool.Activated:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end)
end)

CreateButton(MiscPage, "Anti-Void Platform", function()
    local platform = Instance.new("Part")
    platform.Name = "KeulZ_AntiVoid"
    platform.Size = Vector3.new(2000, 1, 2000)
    platform.Position = Vector3.new(0, -50, 0)
    platform.Anchored = true
    platform.Transparency = 0.7
    platform.CanCollide = true
    platform.Material = Enum.Material.ForceField
    platform.Color = Theme.Primary
    platform.Parent = workspace
end)

CreateButton(MiscPage, "SafeSpot", function()
    local safespot = Instance.new("Part")
    safespot.Name = "KeulZ_SafeSpot"
    safespot.Size = Vector3.new(150, 5, 150)
    safespot.Position = Vector3.new(10000, 10000, 10000)
    safespot.Anchored = true
    safespot.Material = Enum.Material.Neon
    safespot.Color = Theme.Primary
    safespot.Parent = workspace
    
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = safespot.CFrame * CFrame.new(0, 10, 0)
    end
end)

CreateButton(MiscPage, "Destroy Barriers", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:lower():find("barrier") or obj.Name:lower():find("wall") then
            obj:Destroy()
        end
    end
end)

CreateButton(MiscPage, "Click TP", function()
    local tool = Instance.new("Tool")
    tool.Name = "Click TP"
    tool.RequiresHandle = false
    tool.Parent = Player.Backpack
    
    tool.Activated:Connect(function()
        local target = Mouse.Target
        if target and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(target.Position + Vector3.new(0, 5, 0))
        end
    end)
end)

CreateButton(MiscPage, "Rejoin Server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

CreateButton(MiscPage, "Server Hop", function()
    local placeId = game.PlaceId
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    
    if success and result.data then
        for _, server in pairs(result.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, server.id, Player)
                break
            end
        end
    end
end)

CreateButton(MiscPage, "Copy JobID", function()
    if setclipboard then
        setclipboard(tostring(game.JobId))
    end
end)

CreateButton(MiscPage, "Spam Jump", function()
    local spamming = true
    spawn(function()
        while spamming and Player.Character and Player.Character:FindFirstChild("Humanoid") do
            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
        end
    end)
    
    task.wait(5)
    spamming = false
end)

CreateButton(MiscPage, "Remove Textures", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
end)

CreateSlider(PlayerPage, "WalkSpeed", 16, 300, 16, function(value)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(PlayerPage, "JumpPower", 50, 500, 50, function(value)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.JumpPower = value
    end
end)

CreateSlider(PlayerPage, "Gravity", 0, 196, 196, function(value)
    workspace.Gravity = value
end)

CreateSlider(PlayerPage, "Hip Height", 0, 50, 0, function(value)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.HipHeight = value
    end
end)

local noclipEnabled = false
local noclipConnection = nil

CreateToggle(PlayerPage, "Noclip", false, function(enabled)
    noclipEnabled = enabled
    
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Player.Character then
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end)

local infiniteJumpEnabled = false

CreateToggle(PlayerPage, "Infinite Jump", false, function(enabled)
    infiniteJumpEnabled = enabled
    
    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

local flyEnabled = false
local flyConnection = nil

CreateToggle(PlayerPage, "Fly (WASD)", false, function(enabled)
    flyEnabled = enabled
    
    if enabled then
        local speed = 50
        local bodyVelocity = Instance.new("BodyVelocity")
        local bodyGyro = Instance.new("BodyGyro")
        
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = Player.Character.HumanoidRootPart
            
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = hrp
            
            bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
            bodyGyro.P = 10000
            bodyGyro.Parent = hrp
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local camera = workspace.CurrentCamera
                local hrp = Player.Character.HumanoidRootPart
                local moveDirection = Vector3.zero
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + (camera.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - (camera.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - (camera.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + (camera.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, speed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, speed, 0)
                end
                
                bodyVelocity.Velocity = moveDirection
                bodyGyro.CFrame = camera.CFrame
            end)
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = Player.Character.HumanoidRootPart
            for _, obj in pairs(hrp:GetChildren()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                    obj:Destroy()
                end
            end
        end
    end
end)

CreateToggle(VisualPage, "FullBright", false, function(enabled)
    if enabled then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.Brightness = 1
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end)

CreateToggle(VisualPage, "Remove Fog", false, function(enabled)
    if enabled then
        Lighting.FogEnd = 100000
    else
        Lighting.FogEnd = 500
    end
end)

CreateButton(VisualPage, "Remove Shadows", function()
    Lighting.GlobalShadows = false
end)

CreateButton(VisualPage, "X-Ray", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0.5
        end
    end
end)

CreateSlider(VisualPage, "FOV", 70, 120, 70, function(value)
    workspace.CurrentCamera.FieldOfView = value
end)

CreateButton(TeleportPage, "TP to Spawn", function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChildOfClass("SpawnLocation")
        if spawn then
            Player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

CreateButton(TeleportPage, "TP to Random Player", function()
    local players = Players:GetPlayers()
    if #players > 1 then
        local randomPlayer = players[math.random(1, #players)]
        if randomPlayer ~= Player and randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end)

local Hubs = {
    ["Infinite Yield"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()",
    ["CMD-X"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()",
    ["Dex Explorer"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()",
    ["Remote Spy"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/ex70/SimpleSpy/main/SimpleSpySource.lua'))()",
    ["Unnamed ESP"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()",
    ["Dark Dex"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua'))()",
    ["Hydroxide"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua'))()",
    ["Orca"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/richie0866/orca/master/public/snapshot.lua'))()"
}

for hubName, hubCode in pairs(Hubs) do
    CreateButton(HubsPage, hubName, function()
        loadstring(hubCode)()
    end)
end

local EditorFrame = Instance.new("Frame")
EditorFrame.Size = UDim2.new(0.96, 0, 0, 180)
EditorFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
EditorFrame.BorderSizePixel = 0
EditorFrame.Parent = ExecutorPage

local editorCorner = Instance.new("UICorner")
editorCorner.CornerRadius = UDim.new(0, 6)
editorCorner.Parent = EditorFrame

local CodeEditor = Instance.new("TextBox")
CodeEditor.Size = UDim2.new(1, -10, 1, -10)
CodeEditor.Position = UDim2.new(0, 5, 0, 5)
CodeEditor.BackgroundTransparency = 1
CodeEditor.Text = 'print("KeulZ Hub")'
CodeEditor.PlaceholderText = "-- Write your code here..."
CodeEditor.TextSize = 12
CodeEditor.TextColor3 = Theme.Text
CodeEditor.PlaceholderColor3 = Theme.TextSecondary
CodeEditor.Font = Enum.Font.Code
CodeEditor.TextXAlignment = Enum.TextXAlignment.Left
CodeEditor.TextYAlignment = Enum.TextYAlignment.Top
CodeEditor.MultiLine = true
CodeEditor.ClearTextOnFocus = false
CodeEditor.Parent = EditorFrame

CreateButton(ExecutorPage, "Execute Script", function()
    local success, err = pcall(function()
        loadstring(CodeEditor.Text)()
    end)
    
    if not success then
        warn("Execution Error: " .. tostring(err))
    end
end)

CreateButton(ExecutorPage, "Clear Editor", function()
    CodeEditor.Text = ""
end)

local RemoteSpyEnabled = true
local SpyLog = Instance.new("ScrollingFrame")
SpyLog.Size = UDim2.new(0.96, 0, 1, -50)
SpyLog.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
SpyLog.BorderSizePixel = 0
SpyLog.ScrollBarThickness = 3
SpyLog.ScrollBarImageColor3 = Theme.Primary
SpyLog.CanvasSize = UDim2.new(0, 0, 0, 0)
SpyLog.Parent = RemoteSpyPage

local spyCorner = Instance.new("UICorner")
spyCorner.CornerRadius = UDim.new(0, 6)
spyCorner.Parent = SpyLog

local spyLayout = Instance.new("UIListLayout")
spyLayout.Padding = UDim.new(0, 2)
spyLayout.SortOrder = Enum.SortOrder.LayoutOrder
spyLayout.Parent = SpyLog

spyLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SpyLog.CanvasSize = UDim2.new(0, 0, 0, spyLayout.AbsoluteContentSize.Y + 5)
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if (method == "FireServer" or method == "InvokeServer") and RemoteSpyEnabled then
        local logEntry = Instance.new("TextLabel")
        logEntry.Size = UDim2.new(1, -5, 0, 18)
        logEntry.BackgroundTransparency = 1
        logEntry.Text = "[" .. method .. "] " .. tostring(self) .. " | " .. HttpService:JSONEncode(args)
        logEntry.TextColor3 = Theme.Primary
        logEntry.Font = Enum.Font.Code
        logEntry.TextSize = 10
        logEntry.TextXAlignment = Enum.TextXAlignment.Left
        logEntry.Parent = SpyLog
    end
    
    return oldNamecall(self, ...)
end)

CreateToggle(RemoteSpyPage, "Remote Spy Enabled", true, function(enabled)
    RemoteSpyEnabled = enabled
end)

CreateButton(RemoteSpyPage, "Clear Log", function()
    for _, child in pairs(SpyLog:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end)

CreateButton(ConfigPage, "Toggle Language (PT/EN)", function()
    Settings.Language = (Settings.Language == "PT") and "EN" or "PT"
    
    MiscBtn.Text = T("Misc")
    PlayerBtn.Text = T("Player")
    VisualBtn.Text = T("Visual")
    TeleportBtn.Text = T("Teleport")
    HubsBtn.Text = T("Hubs")
    ExecutorBtn.Text = T("Executor")
    RemoteSpyBtn.Text = T("RemoteSpy")
    ConfigBtn.Text = T("Config")
    CreditsBtn.Text = T("Credits")
end)

CreateButton(ConfigPage, "First Person", function()
    Player.CameraMode = Enum.CameraMode.LockFirstPerson
end)

CreateButton(ConfigPage, "Third Person", function()
    Player.CameraMode = Enum.CameraMode.Classic
end)

CreateButton(ConfigPage, "Reset Character", function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.Health = 0
    end
end)

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Size = UDim2.new(1, 0, 1, 0)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = [[
KEULZ HUB v2.0

Developer: E
Logic: E-Security
UI Design: KeulZ Team

Discord: discord.gg/keulz
GitHub: github.com/keulz

Thank you for using KeulZ Hub!
]]
CreditsLabel.TextColor3 = Theme.Primary
CreditsLabel.Font = Enum.Font.GothamBold
CreditsLabel.TextSize = 14
CreditsLabel.Parent = CreditsPage

local function SwitchPage(pageName)
    for _, page in pairs(Pages) do
        page.Visible = false
    end
    
    Pages[pageName].Visible = true
    
    for _, btn in pairs(Sidebar:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            btn.Name = ""
        end
    end
end

MiscBtn.MouseButton1Click:Connect(function()
    SwitchPage("Misc")
    MiscBtn.BackgroundColor3 = Theme.Primary
    MiscBtn.Name = "Selected"
end)

PlayerBtn.MouseButton1Click:Connect(function()
    SwitchPage("Player")
    PlayerBtn.BackgroundColor3 = Theme.Primary
    PlayerBtn.Name = "Selected"
end)

VisualBtn.MouseButton1Click:Connect(function()
    SwitchPage("Visual")
    VisualBtn.BackgroundColor3 = Theme.Primary
    VisualBtn.Name = "Selected"
end)

TeleportBtn.MouseButton1Click:Connect(function()
    SwitchPage("Teleport")
    TeleportBtn.BackgroundColor3 = Theme.Primary
    TeleportBtn.Name = "Selected"
end)

HubsBtn.MouseButton1Click:Connect(function()
    SwitchPage("Hubs")
    HubsBtn.BackgroundColor3 = Theme.Primary
    HubsBtn.Name = "Selected"
end)

ExecutorBtn.MouseButton1Click:Connect(function()
    SwitchPage("Executor")
    ExecutorBtn.BackgroundColor3 = Theme.Primary
    ExecutorBtn.Name = "Selected"
end)

RemoteSpyBtn.MouseButton1Click:Connect(function()
    SwitchPage("RemoteSpy")
    RemoteSpyBtn.BackgroundColor3 = Theme.Primary
    RemoteSpyBtn.Name = "Selected"
end)

ConfigBtn.MouseButton1Click:Connect(function()
    SwitchPage("Config")
    ConfigBtn.BackgroundColor3 = Theme.Primary
    ConfigBtn.Name = "Selected"
end)

CreditsBtn.MouseButton1Click:Connect(function()
    SwitchPage("Credits")
    CreditsBtn.BackgroundColor3 = Theme.Primary
    CreditsBtn.Name = "Selected"
end)

SwitchPage("Misc")
MiscBtn.BackgroundColor3 = Theme.Primary
MiscBtn.Name = "Selected"

print("KeulZ Hub v1.0 loaded successfully!")
