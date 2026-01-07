-- Pastikan game sudah load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game.Players.LocalPlayer

-- Contoh: cari Value bernama "Luck"
local function getLuckValue()
    local stats = player:FindFirstChild("leaderstats")
    if not stats then return nil end
    return stats:FindFirstChild("Luck")
end

-- UI Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,200,0,40)
btn.Position = UDim2.new(0.5,-100,0.5,-20)
btn.Text = "Set Luck (Local)"
btn.Parent = game.CoreGui

btn.MouseButton1Click:Connect(function()
    local luck = getLuckValue()
    if luck and luck:IsA("NumberValue") then
        luck.Value = 2432642
        print("Luck diubah (client-side)")
    else
        warn("Luck Value tidak ditemukan")
    end
end)
