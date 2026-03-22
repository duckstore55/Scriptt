local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local IMAGE_ID = "rbxassetid://140618665887288"

local ClaimReward = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ChallengeService")
    :WaitForChild("RF")
    :WaitForChild("ClaimReward")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- ===== DRAG SYSTEM =====
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

-- ===== HUB =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.18,0,0.25,0)
main.Position = UDim2.new(0.41,0,0.37,0)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BackgroundTransparency = 0.1
Instance.new("UICorner", main)
makeDraggable(main)

-- TOPBAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0.2,0)
top.BackgroundTransparency = 1

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Duck Shop 🦆"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- FECHAR
local closeMain = Instance.new("TextButton", top)
closeMain.Size = UDim2.new(0,20,0,20)
closeMain.Position = UDim2.new(1,-25,0,5)
closeMain.Text = "X"
closeMain.TextColor3 = Color3.new(1,1,1)
closeMain.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", closeMain)

-- ===== LOGO LIMPA (SEM CAIXA) =====
local imageBtn = Instance.new("ImageButton", gui)
imageBtn.Size = UDim2.new(0.12,0,0.12,0)
imageBtn.Position = UDim2.new(0.44,0,0.35,0)
imageBtn.Image = IMAGE_ID
imageBtn.Visible = false
imageBtn.BackgroundTransparency = 1
imageBtn.ScaleType = Enum.ScaleType.Fit
imageBtn.BorderSizePixel = 0

makeDraggable(imageBtn) -- 🔥 AGORA DÁ PRA MOVER

-- animação leve
imageBtn.MouseEnter:Connect(function()
    TweenService:Create(imageBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(0.14,0,0.14,0)
    }):Play()
end)

imageBtn.MouseLeave:Connect(function()
    TweenService:Create(imageBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(0.12,0,0.12,0)
    }):Play()
end)

-- ===== BOTÕES =====
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,0,0.8,0)
content.Position = UDim2.new(0,0,0.2,0)
content.BackgroundTransparency = 1

local btnMain = Instance.new("TextButton", content)
btnMain.Size = UDim2.new(0.8,0,0.25,0)
btnMain.Position = UDim2.new(0.1,0,0.15,0)
btnMain.Text = "🎰 Lucky Spins"
btnMain.TextColor3 = Color3.new(1,1,1)
btnMain.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", btnMain)

local btnCred = Instance.new("TextButton", content)
btnCred.Size = UDim2.new(0.8,0,0.25,0)
btnCred.Position = UDim2.new(0.1,0,0.5,0)
btnCred.Text = "👤 Créditos"
btnCred.TextColor3 = Color3.new(1,1,1)
btnCred.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", btnCred)

-- ===== PANEL =====
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0.2,0,0.2,0)
panel.Position = UDim2.new(0.62,0,0.4,0)
panel.BackgroundColor3 = Color3.fromRGB(20,20,20)
panel.Visible = false
Instance.new("UICorner", panel)
makeDraggable(panel)

local closeTab = Instance.new("TextButton", panel)
closeTab.Size = UDim2.new(0,20,0,20)
closeTab.Position = UDim2.new(1,-25,0,5)
closeTab.Text = "X"
closeTab.TextColor3 = Color3.new(1,1,1)
closeTab.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", closeTab)

-- ABAS
local tabLucky = Instance.new("Frame", panel)
tabLucky.Size = UDim2.new(1,0,1,0)
tabLucky.BackgroundTransparency = 1

local tabCred = Instance.new("Frame", panel)
tabCred.Size = UDim2.new(1,0,1,0)
tabCred.BackgroundTransparency = 1
tabCred.Visible = false

-- TOGGLE
local toggle = Instance.new("TextButton", tabLucky)
toggle.Size = UDim2.new(0.7,0,0.3,0)
toggle.Position = UDim2.new(0.15,0,0.35,0)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(150,0,0)
Instance.new("UICorner", toggle)

-- CRÉDITOS
local cred = Instance.new("TextLabel", tabCred)
cred.Size = UDim2.new(1,0,1,0)
cred.BackgroundTransparency = 1
cred.Text = "👑 Duck\n🔰Alvz"
cred.TextScaled = true
cred.TextColor3 = Color3.new(1,1,1)

-- ===== FUNCIONAL =====
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
    imageBtn.Visible = true
end)

imageBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    imageBtn.Visible = false
end)

-- TOGGLE
local ativo = false
toggle.MouseButton1Click:Connect(function()
    ativo = not ativo
    toggle.Text = ativo and "ON" or "OFF"
    toggle.BackgroundColor3 = ativo and Color3.fromRGB(0,200,0) or Color3.fromRGB(150,0,0)
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
            task.wait()
        else
            task.wait()
        end
    end
end)
