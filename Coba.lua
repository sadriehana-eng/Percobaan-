-- Pastikan game sudah load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Cari Luck di leaderstats
local function getLuckValue()
    local stats = player:FindFirstChild("leaderstats")
    if not stats then return nil end
    return stats:FindFirstChild("Luck")
end

-- Buat ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LuckGui"
gui.ResetOnSpawn = false

-- Anti error CoreGui (Delta compatible)
if gethui then
    gui.Parent = gethui()
else
    gui.Parent = game.CoreGui
end

-- Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 40)
btn.Position = UDim2.new(0.5, -100, 0.5, -20)
btn.Text = "Set Luck (Local)"
btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
    local luck = getLuckValue()
    if luck and luck:IsA("NumberValue") then
        luck.Value = 2432642
        print("Luck diubah (CLIENT ONLY)")
    else
        warn("Luck Value tidak ditemukan")
    end
end)
