-- Fish It - Auto Fish (Toggle ON/OFF)
-- Delta Compatible | Client-side only

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = false
local REEL_DELAY = 0.8 -- waktu aman sebelum auto tarik (detik)

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

-- ======================
-- REMOVE ANIMATION
-- ======================
local function killAnimations()
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
-- HANDLE TOOL ACTIVATED
-- ======================
local function setupTool(tool)
    if not tool:IsA("Tool") then return end
    tool.Activated:Connect(function()
        if not ENABLED then return end

        -- 1. matikan animasi
        killAnimations()

        -- 2. tunggu waktu aman
        task.delay(REEL_DELAY, function()
            -- 3. auto tarik
            pcall(function()
                tool:Activate()
            end)
        end)
    end)
end

-- ======================
-- WATCH CHARACTER
-- ======================
local function onCharacter(char)
    for _, tool in ipairs(char:GetChildren()) do
        setupTool(tool)
    end
    char.ChildAdded:Connect(function(child)
        setupTool(child)
    end)
end

if LocalPlayer.Character then
    onCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(onCharacter)

-- ======================
-- TOGGLE BUTTON
-- ======================
btn.MouseButton1Click:Connect(function()
    ENABLED = not ENABLED
    btn.Text = ENABLED and "AUTO FISH : ON" or "AUTO FISH : OFF"
end)

print("[AutoFish] Toggle UI loaded. Click button to enable.")
