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
    LoadingTitle = "Duck Hub",
    LoadingSubtitle = "by Duck 🔰",
    ConfigurationSaving = {
        Enabled = false
    }
})

--// Tabs
local MainTab = Window:CreateTab("🎰 Lucky Spins", nil)
local CreditsTab = Window:CreateTab("👤 Créditos", nil)

--// Variables
local ativo = false
local antiAfk = false

--// Lucky Spins Toggle
MainTab:CreateToggle({
    Name = "Auto Claim Reward",
    CurrentValue = false,
    Flag = "AutoClaim",
    Callback = function(Value)
        ativo = Value
    end,
})

--// Anti-AFK Toggle
MainTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        antiAfk = Value
    end,
})

--// Credits
CreditsTab:CreateLabel("👑 Duck")
CreditsTab:CreateLabel("🔰 Alvz")

--// Anti AFK system
player.Idled:Connect(function()
    if antiAfk then
        VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
    end
end)

--// Loop
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
