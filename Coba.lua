-- Fish It - Auto Cast & Reel
-- Triggered by Tool Use
-- Delta Compatible | Client-side only

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ======================
-- CONFIG
-- ======================
local ENABLED = true
local REEL_DELAY = 0.8 -- waktu aman sebelum auto tarik (detik)

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
-- HANDLE TOOL
-- ======================
local function setupTool(tool)
    if not tool:IsA("Tool") then return end

    -- saat pancing dipakai
    tool.Activated:Connect(function()
        if not ENABLED then return end

        -- 1. hentikan animasi
        killAnimations()

        -- 2. tunggu waktu server yang masuk akal
        task.delay(REEL_DELAY, function()
            -- 3. auto tarik (tanpa click fast)
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

print("[AutoFish] Tool-based instant cast & reel loaded")
