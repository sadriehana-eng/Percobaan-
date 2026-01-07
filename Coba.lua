-- Script Fish It - Memaksa Bonus Luck menjadi 2432642%  
-- Pastikan game Fish It sudah terbuka di tab browser  

-- Fungsi untuk mencari alamat memori Bonus Luck  
local function FindBonusLuckAddress()  
    local result = {}  
    local found = 0x0  -- Alamat awal  

    -- Contoh pencarian (sesuaikan dengan alamat aktual)  
    local scan_results = memory.find("FishIt.exe", 0x10000000, 0x107FFFFFF, "a1 ?? ?? ?? ?? 89 45 ? 8b 45 ? 89 45 ? ff 15")  
    if scan_results.count > 0 then  
        found = scan_results[1].address + 0x35  -- Offset berdasarkan opcode  
        print("Alamat Bonus Luck ditemukan: " .. string.format("0x%X", found))  
        result.address = found  
        result.found = true  
    else  
        print("Gagal menemukan alamat. Cek kembali opcodes.")  
        result.found = false  
    end  

    return result  
end  

-- Tombol: Cari Alamat Bonus Luck  
local searchBtn = Instance.new("TextButton")  
searchBtn.Text = "🔍 Find Bonus Luck"  
searchBtn.Size = UDim2.new(0, 200, 0, 40)  
searchBtn.Position = UDim2.new(0.5, -100, 0.5, -20)  
searchBtn.MouseButton1Click:Connect(function()  
    local bonusLuck = FindBonusLuckAddress()  
    if bonusLuck.found then  
        print("✅ Alamat ditemukan!")  
    end  
end)  
searchBtn.Parent = game:GetService("CoreGui")  

-- Tombol: Set Bonus Luck menjadi 2432642%  
local setBtn = Instance.new("TextButton")  
setBtn.Text = "💥 Set 2432642%"  
setBtn.Size = UDim2.new(0, 200, 0, 40)  
setBtn.Position = UDim2.new(0.5, -100, 0.5, 30)  
setBtn.MouseButton1Click:Connect(function()  
    local bonusLuck = FindBonusLuckAddress()  
    if bonusLuck.found then  
        memory.write(bonusLuck.address, 2432642, "float")  -- Ganti dengan tipe data sesuai game  
        print("✅ Bonus Luck berhasil diubah menjadi 2432642%!")  
    end  
end)  
setBtn.Parent = game:GetService("CoreGui")  
