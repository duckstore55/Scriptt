--// Rayfield UI
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
