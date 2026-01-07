-- Fish It - Auto Fish FIXED (Toggle + Auto)
-- Delta Compatible | Client-side only

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = false
local REEL_DELAY = 0.8 -- 0.8 detik per siklus

-- ======================
-- UI TOGGLE
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFishToggleUI"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 260, 0, 44)
btn.Position = UDim2.new(0.5, -130, 0.15, 0)
btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
btn.TextColor3 = Color3.fromRGB(0, 255, 0)
btn.TextScaled = true
btn.Text = "AUTO FISH : OFF"
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
    ENABLED = not ENABLED
    btn.Text = ENABLED and "AUTO FISH : ON" or "AUTO FISH : OFF"
end)

-- ======================
-- REMOVE ANIMATION
-- ======================
local function killAnimations()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        pcall(function() track:Stop() end)
    end
end

-- ======================
-- GET TOOL (PANCING)
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

-- ======================
-- MAIN LOOP
-- ======================
task.spawn(function()
    while true do
        if ENABLED then
            local tool = getFishingTool()
            if tool then
                -- 1. matikan animasi
                killAnimations()
                -- 2. "lempar & tarik" otomatis
                pcall(function() tool:Activate() end)
            end
            task.wait(REEL_DELAY)
        else
            task.wait(0.25)
        end
    end
end)

-- ======================
-- WATCH CHARACTER
-- ======================
local function onCharacter(char)
    -- nothing needed, loop cek tool setiap frame
end

if LocalPlayer.Character then
    onCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(onCharacter)

print("[AutoFish] Toggle UI loaded, auto fish loop active (0.8s)")
