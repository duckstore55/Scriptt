--// PROTEÇÃO BASE
if _G.DuckHubLoaded then return end
_G.DuckHubLoaded = true

local SCRIPT_ID = "duckhub_" .. tostring(math.random(1000,9999))

--// SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

--// PLAYER
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = SCRIPT_ID
gui.Parent = player:WaitForChild("PlayerGui")

--// REMOTE
local ClaimReward = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ChallengeService")
    :WaitForChild("RF")
    :WaitForChild("ClaimReward")

--// CHECK INTEGRITY
if not game or not Players.LocalPlayer then return end

--// DRAG SYSTEM
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

--// MAIN UI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.18,0,0.25,0)
main.Position = UDim2.new(0.41,0,0.37,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,35)
Instance.new("UICorner", main)
makeDraggable(main)

-- Gradient anime
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40,40,60))
}

-- Stroke neon
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Transparency = 0.3

-- TOPBAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0.2,0)
top.BackgroundTransparency = 1

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Duck Hub 🦆"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local closeMain = Instance.new("TextButton", top)
closeMain.Size = UDim2.new(0,20,0,20)
closeMain.Position = UDim2.new(1,-25,0,5)
closeMain.Text = "X"
closeMain.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", closeMain)

--// CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,0,0.8,0)
content.Position = UDim2.new(0,0,0.2,0)
content.BackgroundTransparency = 1

local function styleButton(btn)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14

    Instance.new("UICorner", btn)

    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(0,170,255)
    s.Transparency = 0.6

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(50,50,80)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(35,35,50)
        }):Play()
    end)
end

local btnMain = Instance.new("TextButton", content)
btnMain.Size = UDim2.new(0.8,0,0.2,0)
btnMain.Position = UDim2.new(0.1,0,0.05,0)
btnMain.Text = "🎰 Lucky Spins"
styleButton(btnMain)

local btnCred = Instance.new("TextButton", content)
btnCred.Size = UDim2.new(0.8,0,0.2,0)
btnCred.Position = UDim2.new(0.1,0,0.3,0)
btnCred.Text = "👤 Créditos"
styleButton(btnCred)

local btnConfig = Instance.new("TextButton", content)
btnConfig.Size = UDim2.new(0.8,0,0.2,0)
btnConfig.Position = UDim2.new(0.1,0,0.55,0)
btnConfig.Text = "⚙️ Configuração"
styleButton(btnConfig)

--// PANEL
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0.2,0,0.2,0)
panel.Position = UDim2.new(0.62,0,0.4,0)
panel.BackgroundColor3 = Color3.fromRGB(20,20,25)
panel.Visible = false
Instance.new("UICorner", panel)
makeDraggable(panel)

local closeTab = Instance.new("TextButton", panel)
closeTab.Size = UDim2.new(0,20,0,20)
closeTab.Position = UDim2.new(1,-25,0,5)
closeTab.Text = "X"
closeTab.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", closeTab)

--// TABS
local tabLucky = Instance.new("Frame", panel)
tabLucky.Size = UDim2.new(1,0,1,0)
tabLucky.BackgroundTransparency = 1

local tabCred = Instance.new("Frame", panel)
tabCred.Size = UDim2.new(1,0,1,0)
tabCred.BackgroundTransparency = 1
tabCred.Visible = false

local tabConfig = Instance.new("Frame", panel)
tabConfig.Size = UDim2.new(1,0,1,0)
tabConfig.BackgroundTransparency = 1
tabConfig.Visible = false

--// LUCKY
local toggle = Instance.new("TextButton", tabLucky)
toggle.Size = UDim2.new(0.7,0,0.3,0)
toggle.Position = UDim2.new(0.15,0,0.35,0)
toggle.Text = "OFF"
styleButton(toggle)

--// CRED
local cred = Instance.new("TextLabel", tabCred)
cred.Size = UDim2.new(1,0,1,0)
cred.BackgroundTransparency = 1
cred.Text = "👑 Duck\n🔰Alvz"
cred.TextScaled = true
cred.TextColor3 = Color3.new(1,1,1)

--// CONFIG
local antiAfkAtivo = false

local antiAfkBtn = Instance.new("TextButton", tabConfig)
antiAfkBtn.Size = UDim2.new(0.7,0,0.3,0)
antiAfkBtn.Position = UDim2.new(0.15,0,0.35,0)
antiAfkBtn.Text = "Anti-AFK: OFF"
styleButton(antiAfkBtn)

antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkAtivo = not antiAfkAtivo
    antiAfkBtn.Text = antiAfkAtivo and "Anti-AFK: ON" or "Anti-AFK: OFF"
end)

-- Anti AFK system
player.Idled:Connect(function()
    if antiAfkAtivo then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

--// BUTTON ACTIONS
btnMain.MouseButton1Click:Connect(function()
    panel.Visible = true
    tabLucky.Visible = true
    tabCred.Visible = false
    tabConfig.Visible = false
end)

btnCred.MouseButton1Click:Connect(function()
    panel.Visible = true
    tabLucky.Visible = false
    tabCred.Visible = true
    tabConfig.Visible = false
end)

btnConfig.MouseButton1Click:Connect(function()
    panel.Visible = true
    tabLucky.Visible = false
    tabCred.Visible = false
    tabConfig.Visible = true
end)

closeTab.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

closeMain.MouseButton1Click:Connect(function()
    main.Visible = false
end)

--// TOGGLE LUCKY
local ativo = false

toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    toggle.Text = ativo and "ON" or "OFF"
end)

--// LOOP
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
