-- Fish It - Auto Fish 0.8s (No Fast Click)
-- Client-side only | Delta Compatible

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = false
local TARGET_TIME = 0.8 -- 1 ikan ~ 0.8 detik (AMAN)

-- ======================
-- UI
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFish08"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 280, 0, 44)
btn.Position = UDim2.new(0.5, -140, 0.15, 0)
btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
btn.TextColor3 = Color3.fromRGB(0, 255, 0)
btn.TextScaled = true
btn.Text = "AUTO FISH : OFF (0.8s)"
btn.Parent = gui

-- ======================
-- HELPERS
-- ======================
local function getFishingTool()
    local char = LocalPlayer.Character
    if not char then return nil end

    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            return tool
        end
    end
    return nil
end

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
-- MAIN LOOP
-- ======================
task.spawn(function()
    while true do
        if ENABLED then
            local startTime = os.clock()

            -- 1. matikan animasi (aman)
            removeAnimations()

            -- 2. auto "klik" tool (tanpa fast click manual)
            local tool = getFishingTool()
            if tool then
                pcall(function()
                    tool:Activate()
                end)
            end

            -- 3. jaga jarak waktu siklus (anti spam)
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
        and "AUTO FISH : ON (0.8s)"
        or "AUTO FISH : OFF (0.8s)"
end)

print("[AutoFish] 0.8s no-fast-click loaded")
