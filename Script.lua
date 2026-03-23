--// KEYAUTH
local KeyAuth = loadstring(game:HttpGet("https://keyauth.win/api/1.2/"))()

local appname = "Emmanoeljoao254's Application"
local ownerid = "xxw5rKPjcz"
local secret = "6057f229e8378277622098c80909d9c8f5506a81ab9f003f0417685b17bd4235"
local version = "1.0"

KeyAuth:init(appname, ownerid, secret, version)

--// UI KEY (ANTES DO HUB)
local player = game:GetService("Players").LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystem"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.PlaceholderText = "Digite sua key..."
TextBox.Size = UDim2.new(0.9, 0, 0, 40)
TextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
TextBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Text = "Validar"
Button.Size = UDim2.new(0.9, 0, 0, 40)
Button.Position = UDim2.new(0.05, 0, 0.65, 0)
Button.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Text = ""
Status.Size = UDim2.new(1,0,0,30)
Status.Position = UDim2.new(0,0,0,0)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.new(1,1,1)
Status.Parent = Frame

local valid = false

Button.MouseButton1Click:Connect(function()
    local key = TextBox.Text

    Status.Text = "Verificando..."

    local success, result = pcall(function()
        return KeyAuth:license(key)
    end)

    if success and result.success then
        Status.Text = "Key válida!"
        valid = true
        task.wait(1)
        ScreenGui:Destroy()
    else
        Status.Text = "Key inválida!"
    end
end)

repeat task.wait() until valid

--// RAYFIELD UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

--// Remote
local ClaimReward = ReplicatedStorage
:WaitForChild("Packages")
:WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0")
:WaitForChild("knit")
:WaitForChild("Services")
:WaitForChild("ChallengeService")
:WaitForChild("RF")
:WaitForChild("ClaimReward")

--// Window
local Window = Rayfield:CreateWindow({
    Name = "Duck Shop 🦆",
    LoadingTitle = "Método Lucky Spin",
    LoadingSubtitle = "by Duck 🔰",
    ConfigurationSaving = { Enabled = false }
})

--// Tabs
local MainTab = Window:CreateTab("🎰 Lucky Spins", nil)
local CreditsTab = Window:CreateTab("👤 Créditos", nil)

---------------------------------------------------
-- Timer
---------------------------------------------------
local startTime = tick()

local TimerLabel = MainTab:CreateLabel("⏱️ Tempo ativo: 00:00:00")

task.spawn(function()
    while true do
        local elapsed = math.floor(tick() - startTime)

        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60

        TimerLabel:Set(string.format("⏱️ Tempo ativo: %02d:%02d:%02d", hours, minutes, seconds))

        task.wait(1)
    end
end)

---------------------------------------------------
-- Automação
---------------------------------------------------
MainTab:CreateSection("⚙️ Automação")

local ativo = false
local antiAfk = false

MainTab:CreateToggle({
    Name = "Auto Claim Reward",
    CurrentValue = false,
    Callback = function(Value)
        ativo = Value
    end,
})

MainTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(Value)
        antiAfk = Value
    end,
})

---------------------------------------------------
-- Créditos
---------------------------------------------------
CreditsTab:CreateSection("👑 Créditos")

CreditsTab:CreateLabel("Duck")
CreditsTab:CreateLabel("Alvz")

---------------------------------------------------
-- Anti AFK
---------------------------------------------------
player.Idled:Connect(function()
    if antiAfk then
        VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
    end
end)

---------------------------------------------------
-- Loop principal
---------------------------------------------------
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
