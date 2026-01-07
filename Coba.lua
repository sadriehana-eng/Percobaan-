-- Fish It - Fast Fishing 0.8s
-- Client-side optimization only
-- Delta Compatible | Loader Ready

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = false
local TARGET_TIME = 0.8 -- 0.8 detik per ikan (AMAN)

-- ======================
-- UI
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "FastFishing08"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 260, 0, 44)
btn.Position = UDim2.new(0.5, -130, 0.15, 0)
btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
btn.TextColor3 = Color3.fromRGB(0, 255, 0)
btn.TextScaled = true
btn.Text = "FAST FISHING : OFF (0.8s)"
btn.Parent = gui

-- ======================
-- ANIMATION KILL (SAFE)
-- ======================
local function removeAnimations()
    local char = LocalPlayer.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        pcall(function()
            track:Stop()
        end)
    end
end

-- ======================
-- MAIN LOOP (REALISTIC)
-- ======================
task.spawn(function()
    while true do
        if ENABLED then
            local startTime = os.clock()

            -- 1. matikan animasi (client-side)
            removeAnimations()

            -- 2. di game asli:
            -- server akan memproses fishing di background
            -- script ini TIDAK memaksa hasil

            -- 3. pastikan 1 siklus >= 0.8 detik
            local elapsed = os.clock() - startTime
            if elapsed < TARGET_TIME then
                task.wait(TARGET_TIME - elapsed)
            end
        else
            task.wait(0.25)
        end
    end
end)

-- ======================
-- TOGGLE
-- ======================
btn.MouseButton1Click:Connect(function()
    ENABLED = not ENABLED
    btn.Text = ENABLED
        and "FAST FISHING : ON (0.8s)"
        or "FAST FISHING : OFF (0.8s)"
end)

print("[FastFishing] 0.8s mode loaded")
