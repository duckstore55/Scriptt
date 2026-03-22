local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local IMAGE_ID = "rbxassetid://140618665887288"
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- DRAG
local function makeDraggable(frame)
    local dragging, dragInput, startPos, startFramePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startFramePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(
                startFramePos.X.Scale,
                startFramePos.X.Offset + delta.X,
                startFramePos.Y.Scale,
                startFramePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ANTI AFK
local antiAfk = false
player.Idled:Connect(function()
    if antiAfk then
        VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
    end
end)

-- REMOTE
local ClaimReward = ReplicatedStorage
:WaitForChild("Packages")
:WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0")
:WaitForChild("knit")
:WaitForChild("Services")
:WaitForChild("ChallengeService")
:WaitForChild("RF")
:WaitForChild("ClaimReward")

-- HUB
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.18,0,0.25,0)
main.Position = UDim2.new(0.41,0,0.37,0)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.ZIndex = 10
Instance.new("UICorner", main)
makeDraggable(main)

local strokeMain = Instance.new("UIStroke", main)
strokeMain.Color = Color3.fromRGB(255,215,0)
strokeMain.Thickness = 2

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,-60,0.2,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Duck Shop 🦆"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local closeMain = Instance.new("TextButton", main)
closeMain.Size = UDim2.new(0,20,0,20)
closeMain.Position = UDim2.new(1,-25,0,5)
closeMain.Text = "X"
closeMain.TextColor3 = Color3.new(1,1,1)
closeMain.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", closeMain)

-- BOTÕES
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,0,0.8,0)
content.Position = UDim2.new(0,0,0.2,0)
content.BackgroundTransparency = 1

local function createBtn(parent,pos,text)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.8,0,0.25,0)
    b.Position = pos
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", b)
    return b
end

local btnMain = createBtn(content, UDim2.new(0.1,0,0.15,0), "🎰 Lucky Spins")
local btnCred = createBtn(content, UDim2.new(0.1,0,0.5,0), "👤 Créditos")

-- PANEL ESTILO NOVO
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0.2,0,0.25,0)
panel.Position = UDim2.new(0.62,0,0.4,0)
panel.BackgroundColor3 = Color3.fromRGB(8,8,8)
panel.Visible = false
panel.ZIndex = 10
Instance.new("UICorner", panel)
makeDraggable(panel)

local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(255,200,0)
stroke.Thickness = 2

-- TOPO
local topBar = Instance.new("Frame", panel)
topBar.Size = UDim2.new(1,0,0.2,0)
topBar.BackgroundTransparency = 1

local title2 = Instance.new("TextLabel", topBar)
title2.Size = UDim2.new(1,-30,1,0)
title2.Position = UDim2.new(0,10,0,0)
title2.Text = "Duck Shop 🦆"
title2.TextColor3 = Color3.fromRGB(255,200,0)
title2.Font = Enum.Font.GothamBold
title2.TextSize = 14
title2.BackgroundTransparency = 1

local closeTab = Instance.new("TextButton", topBar)
closeTab.Size = UDim2.new(0,22,0,22)
closeTab.Position = UDim2.new(1,-26,0,4)
closeTab.Text = "X"
closeTab.TextColor3 = Color3.new(1,1,1)
closeTab.BackgroundColor3 = Color3.fromRGB(170,0,0)
Instance.new("UICorner", closeTab)

-- ABAS
local tabLucky = Instance.new("Frame", panel)
tabLucky.Size = UDim2.new(1,0,1,0)
tabLucky.BackgroundTransparency = 1

local tabCred = Instance.new("Frame", panel)
tabCred.Size = UDim2.new(1,0,1,0)
tabCred.Visible = false
tabCred.BackgroundTransparency = 1

-- TOGGLES
local toggle = createBtn(tabLucky, UDim2.new(0.15,0,0.25,0), "OFF")
toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)

local antiBtn = createBtn(tabLucky, UDim2.new(0.15,0,0.6,0), "🛡️ Anti-AFK: OFF")
antiBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)

-- CRÉDITOS
local cred = Instance.new("TextLabel", tabCred)
cred.Size = UDim2.new(1,0,1,0)
cred.Text = "👑 Duck\n🔰Alvz"
cred.TextSize = 18
cred.TextColor3 = Color3.new(1,1,1)
cred.BackgroundTransparency = 1

-- FUNCIONAL
btnMain.MouseButton1Click:Connect(function()
    panel.Visible = true
    tabLucky.Visible = true
    tabCred.Visible = false
end)

btnCred.MouseButton1Click:Connect(function()
    panel.Visible = true
    tabLucky.Visible = false
    tabCred.Visible = true
end)

closeTab.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

closeMain.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- TOGGLES
local ativo = false

toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    toggle.Text = ativo and "ON" or "OFF"
    toggle.BackgroundColor3 = ativo and Color3.fromRGB(0,200,0) or Color3.fromRGB(170,0,0)
end)

antiBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    antiBtn.Text = antiAfk and "🛡️ Anti-AFK: ON" or "🛡️ Anti-AFK: OFF"
    antiBtn.BackgroundColor3 = antiAfk and Color3.fromRGB(0,200,0) or Color3.fromRGB(170,0,0)
end)

-- LOOP
task.spawn(function()
    local i = 1
    while true do
        if ativo then
            pcall(function()
                ClaimReward:InvokeServer(i)
            end)
            i += 1
        end
        task.wait()
    end
end)
