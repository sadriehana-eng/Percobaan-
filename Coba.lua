-- Fish It - Auto Fish 0.8s Real
-- Delta Compatible | Client-side only

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = false
local TARGET_TIME = 0.8 -- 0.8 detik per ikan

-- ======================
-- UI TOGGLE
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFishRealUI"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 280, 0, 44)
btn.Position = UDim2.new(0.5, -140, 0.15, 0)
btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
btn.TextColor3 = Color3.fromRGB(0, 255, 0)
btn.TextScaled = true
btn.Text = "AUTO FISH : OFF (0.8s)"
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
    ENABLED = not ENABLED
    btn.Text = ENABLED
        and "AUTO FISH : ON (0.8s)"
        or "AUTO FISH : OFF (0.8s)"
end)

-- ======================
-- HELPERS
-- ======================
local function removeAnimations()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        pcall(function() track:Stop() end)
    end
end

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
-- AUTO FISH LOOP
-- ======================
task.spawn(function()
    while true do
        if ENABLED then
            local tool = getFishingTool()
            if tool then
                -- hentikan animasi
                removeAnimations()
                -- gunakan Tool → lempar & tarik
                pcall(function() tool:Activate() end)
            end
            task.wait(TARGET_TIME)
        else
            task.wait(0.25)
        end
    end
end)

-- ======================
-- WATCH CHARACTER
-- ======================
local function onCharacter(char)
    -- nothing needed, loop cek Tool setiap frame
end

if LocalPlayer.Character then
    onCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(onCharacter)

print("[AutoFish] Toggle ON/OFF + 0.8s auto fish loaded")
