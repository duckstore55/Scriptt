local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local IMAGE_ID = "rbxassetid://140618665887288"

local player = Players.LocalPlayer

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

local ClaimReward = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ChallengeService")
    :WaitForChild("RF")
    :WaitForChild("ClaimReward")

-- ===== DRAG =====
local function makeDraggable(frame)
    local dragging, dragInput, startPos, startFramePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startFramePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
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

-- ===== ANTI-AFK =====
local antiAfk = false
local lastActivity = os.time()
local AFK_TIME = 600 -- 10 minutos

UIS.InputBegan:Connect(function()
    lastActivity = os.time()
end)

UIS.InputChanged:Connect(function()
    lastActivity = os.time()
end)

player.Idled:Connect(function()
    if antiAfk then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

task.spawn(function()
    while true do
        task.wait(5)

        if antiAfk then
            local diff = os.time() - lastActivity

            if diff >= AFK_TIME then
                lastActivity = os.time()

                -- anti kick forte
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())

                -- micro movimento
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,0.1)
                end
            end
        end
    end
end)

-- ===== HUB =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.18,0,0.25,0)
main.Position = UDim2.new(0.41,0,0.37,0)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BackgroundTransparency = 0.1
main.ZIndex = 10
Instance.new("UICorner", main)

makeDraggable(main)

-- TOPBAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0.2,0)
top.BackgroundTransparency = 1
top.ZIndex = 11

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Duck Shop"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 11

local closeMain = Instance.new("TextButton", top)
closeMain.Size = UDim2.new(0,20,0,20)
closeMain.Position = UDim2.new(1,-25,0,5)
closeMain.Text = "X"
closeMain.TextColor3 = Color3.new(1,1,1)
closeMain.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeMain.ZIndex = 12
Instance.new("UICorner", closeMain)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,0,0.8,0)
content.Position = UDim2.new(0,0,0.2,0)
content.BackgroundTransparency = 1
content.ZIndex = 11

local btnMain = Instance.new("TextButton", content)
btnMain.Size = UDim2.new(0.8,0,0.25,0)
btnMain.Position = UDim2.new(0.1,0,0.15,0)
btnMain.Text = "🎰 Lucky Spins"
btnMain.TextColor3 = Color3.new(1,1,1)
btnMain.BackgroundColor3 = Color3.fromRGB(35,35,35)
btnMain.ZIndex = 12
Instance.new("UICorner", btnMain)

local btnCred = Instance.new("TextButton", content)
btnCred.Size = UDim2.new(0.8,0,0.25,0)
btnCred.Position = UDim2.new(0.1,0,0.5,0)
btnCred.Text = "👤 Créditos"
btnCred.TextColor3 = Color3.new(1,1,1)
btnCred.BackgroundColor3 = Color3.fromRGB(35,35,35)
btnCred.ZIndex = 12
Instance.new("UICorner", btnCred)

-- PANEL
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0.2,0,0.25,0)
panel.Position = UDim2.new(0.62,0,0.4,0)
panel.BackgroundColor3 = Color3.fromRGB(20,20,20)
panel.Visible = false
panel.ZIndex = 10
Instance.new("UICorner", panel)

makeDraggable(panel)

local closeTab = Instance.new("TextButton", panel)
closeTab.Size = UDim2.new(0,20,0,20)
closeTab.Position = UDim2.new(1,-25,0,5)
closeTab.Text = "X"
closeTab.TextColor3 = Color3.new(1,1,1)
closeTab.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeTab.ZIndex = 11
Instance.new("UICorner", closeTab)

-- ABAS
local tabLucky = Instance.new("Frame", panel)
tabLucky.Size = UDim2.new(1,0,1,0)
tabLucky.BackgroundTransparency = 1
tabLucky.ZIndex = 11

local tabCred = Instance.new("Frame", panel)
tabCred.Size = UDim2.new(1,0,1,0)
tabCred.BackgroundTransparency = 1
tabCred.Visible = false
tabCred.ZIndex = 11

-- TOGGLE LUCKY
local toggle = Instance.new("TextButton", tabLucky)
toggle.Size = UDim2.new(0.7,0,0.2,0)
toggle.Position = UDim2.new(0.15,0,0.2,0)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(150,0,0)
toggle.ZIndex = 12
Instance.new("UICorner", toggle)

-- TOGGLE ANTI-AFK
local antiBtn = Instance.new("TextButton", tabLucky)
antiBtn.Size = UDim2.new(0.7,0,0.2,0)
antiBtn.Position = UDim2.new(0.15,0,0.55,0)
antiBtn.Text = "🛡️ Anti-AFK: OFF"
antiBtn.TextColor3 = Color3.new(1,1,1)
antiBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
antiBtn.ZIndex = 12
Instance.new("UICorner", antiBtn)

-- CREDITS
local cred = Instance.new("TextLabel", tabCred)
cred.Size = UDim2.new(1,0,1,0)
cred.BackgroundTransparency = 1
cred.Text = "👑 Duck\n🔰Alvz"
cred.TextScaled = true
cred.TextColor3 = Color3.new(1,1,1)
cred.ZIndex = 11

-- NAV
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
    panel.Visible = false
end)

-- TOGGLES
local ativo = false

toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    toggle.Text = ativo and "ON" or "OFF"
    toggle.BackgroundColor3 = ativo and Color3.fromRGB(0,200,0) or Color3.fromRGB(150,0,0)
end)

antiBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    antiBtn.Text = antiAfk and "🛡️ Anti-AFK: ON" or "🛡️ Anti-AFK: OFF"
    antiBtn.BackgroundColor3 = antiAfk and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,0,0)
end)

-- LOOP LUCKY
task.spawn(function()
    local i = 1
    while true do
        if ativo then
            pcall(function()
                ClaimReward:InvokeServer(i)
            end)
            i += 1
            task.wait()
        else
            task.wait()
        end
    end
end)
