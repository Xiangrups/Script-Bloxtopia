--!strict
-- LocalScript

-- Variabel untuk mengacu pada GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local cheatMenu = playerGui:WaitForChild("CheatMenu")
local mainFrame = cheatMenu:WaitForChild("MainFrame")

-- Dapatkan tombol toggle
local autoFishToggle = mainFrame:WaitForChild("AutoFishToggle")
local autoBreakPutToggle = mainFrame:WaitForChild("AutoBreakPutToggle")
local autoPlantToggle = mainFrame:WaitForChild("AutoPlantToggle")

-- Variabel status cheat
local isAutoFishOn = false
local isAutoBreakPutOn = false
local isAutoPlantOn = false

-- Fungsi untuk mengupdate tampilan tombol
local function updateButtonDisplay(button: GuiButton, isOn: boolean)
    if isOn then
        button.Text = button.Name .. " [ON]" -- Ganti dengan logika visual yang sesuai (misal: warna hijau)
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
    else
        button.Text = button.Name .. " [OFF]" -- Ganti dengan logika visual yang sesuai (misal: warna merah)
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Merah
    end
end

-- Fungsi Toggle Auto Fish
autoFishToggle.MouseButton1Click:Connect(function()
    isAutoFishOn = not isAutoFishOn -- Membalik status
    updateButtonDisplay(autoFishToggle, isAutoFishOn)
    
    if isAutoFishOn then
        print("Auto Fish AKTIF!")
        -- LOGIKA AUTO FISH AKAN DITARUH DI SINI (e.g., Loop untuk memancing)
    else
        print("Auto Fish NONAKTIF.")
        -- LOGIKA PEMBERHENTIAN AUTO FISH AKAN DITARUH DI SINI
    end
end)

-- Fungsi Toggle Auto Break and Put
autoBreakPutToggle.MouseButton1Click:Connect(function()
    isAutoBreakPutOn = not isAutoBreakPutOn
    updateButtonDisplay(autoBreakPutToggle, isAutoBreakPutOn)
    
    if isAutoBreakPutOn then
        print("Auto Break and Put AKTIF!")
        -- LOGIKA AUTO BREAK/PUT DI SINI
    else
        print("Auto Break and Put NONAKTIF.")
    end
end)

-- Fungsi Toggle Auto Plant
autoPlantToggle.MouseButton1Click:Connect(function()
    isAutoPlantOn = not isAutoPlantOn
    updateButtonDisplay(autoPlantToggle, isAutoPlantOn)
    
    if isAutoPlantOn then
        print("Auto Plant AKTIF!")
        -- LOGIKA AUTO PLANT DI SINI
    else
        print("Auto Plant NONAKTIF.")
    end
end)

-- Inisialisasi tampilan awal
updateButtonDisplay(autoFishToggle, isAutoFishOn)
updateButtonDisplay(autoBreakPutToggle, isAutoBreakPutOn)
updateButtonDisplay(autoPlantToggle, isAutoPlantOn)