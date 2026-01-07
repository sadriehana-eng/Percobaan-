-- 🐟 Fish It | Luck Override + UI
-- All-in-One | Delta Executor Compatible

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- ===== CONFIG =====
local LUCK_MULTIPLIER = 2000000 -- 2.000.000%
local ENABLED = true
-- ==================

-- Cari Luck Value
local function getLuck()
    local stats = LP:FindFirstChild("leaderstats")
    if not stats then return nil end
    return stats:FindFirstChild("Luck")
end

local originalLuck = nil

-- Paksa luck tiap frame (biar terasa)
RunService.Heartbeat:Connect(function()
    if not ENABLED then return end

    local luck = getLuck()
    if luck and luck:IsA("NumberValue") then
        if not originalLuck then
            originalLuck = luck.Value
        end

        luck.Value = originalLuck * LUCK_MULTIPLIER
    end
end)

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuckUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 160, 0, 45)
Button.Position = UDim2.new(0.5, -80, 0.8, 0)
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true
Button.Font = Enum.Font.GothamBold
Button.Text = "Luck : ON"
Button.Parent = ScreenGui

local uiState = true

Button.MouseButton1Click:Connect(function()
    uiState = not uiState
    ENABLED = uiState

    local luck = getLuck()
    if luck and originalLuck then
        if not uiState then
            luck.Value = originalLuck
        end
    end

    Button.Text = uiState and "Luck : ON" or "Luck : OFF"
end)
