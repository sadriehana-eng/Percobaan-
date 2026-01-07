-- Fish It - Fast Fishing Framework
-- Delta Compatible | Loader Ready

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- =========================
-- CONFIG
-- =========================
local CONFIG = {
    Enabled = false,
    MinDelay = 0.6, -- delay aman minimum
    MaxDelay = 1.2, -- delay aman maksimum
    AnimationSpeed = 5 -- percepat animasi
}

-- =========================
-- UI
-- =========================
local gui = Instance.new("ScreenGui")
gui.Name = "FastFishingUI"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 220, 0, 40)
btn.Position = UDim2.new(0.5, -110, 0.15, 0)
btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
btn.TextColor3 = Color3.fromRGB(0,255,0)
btn.TextScaled = true
btn.Text = "FAST FISHING : OFF"
btn.Parent = gui

-- =========================
-- HELPER
-- =========================
local function randomDelay()
    return math.random() * (CONFIG.MaxDelay - CONFIG.MinDelay) + CONFIG.MinDelay
end

local function speedUpAnimations()
    local char = LocalPlayer.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        pcall(function()
            track:AdjustSpeed(CONFIG.AnimationSpeed)
        end)
    end
end

-- =========================
-- MAIN LOOP (SAFE)
-- =========================
task.spawn(function()
    while true do
        if CONFIG.Enabled then
            -- 1. percepat / matikan animasi
            speedUpAnimations()

            -- 2. di SINI biasanya player memanggil fishing
            -- ⚠️ sengaja dikosongkan
            -- contoh konsep:
            -- RemoteEvent:FireServer()

            -- 3. delay aman (WAJIB)
            task.wait(randomDelay())
        else
            task.wait(0.3)
        end
    end
end)

-- =========================
-- TOGGLE
-- =========================
btn.MouseButton1Click:Connect(function()
    CONFIG.Enabled = not CONFIG.Enabled
    btn.Text = CONFIG.Enabled and "FAST FISHING : ON" or "FAST FISHING : OFF"
end)

print("[FastFishing] Framework loaded")
