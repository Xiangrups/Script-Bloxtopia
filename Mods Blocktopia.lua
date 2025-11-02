-- Variabel Status Global (Status saat ini)
isFishingActive = FALSE
isBreakingActive = FALSE
isPlantingActive = FALSE
isFastRunActive = FALSE

-- Sub-status untuk Auto Fishing (Menjaga siklus pancing)
isCasting = FALSE
isReeling = FALSE

-- Hotkeys untuk Toggle (Tombol pintas untuk mengaktifkan/menonaktifkan)
HOTKEY_TOGGLE_FISH = 'F1'
HOTKEY_TOGGLE_BREAK = 'F2'
HOTKEY_TOGGLE_PLANT = 'F3'
HOTKEY_TOGGLE_RUN = 'F4'
HOTKEY_EXIT = 'END'

-- Pengaturan Game (Sesuaikan dengan nilai game Anda)
NORMAL_WALK_SPEED = 16
FAST_WALK_SPEED = 60
FUNCTION AutoFishing()
    -- Tahap 1: Melempar Pancing ke Air Terdekat
    IF NOT isCasting AND NOT isReeling THEN
        closestWaterPos = FindClosestWaterLocation() -- (Membutuhkan API/Visual Detection)
        IF closestWaterPos IS NOT NULL THEN
            MoveMouseTo(closestWaterPos)
            SendInput('E') -- Asumsi: Tombol untuk melempar pancing
            isCasting = TRUE
            Log("Pancing dilempar. Menunggu gigitan...")
        ELSE
            Sleep(2000)
        END IF

    -- Tahap 2: Deteksi Gigitan dan Tarik Otomatis
    ELSE IF isCasting AND IsFishBiting() THEN -- (Membutuhkan API/Visual Detection)
        Log("Gigitan terdeteksi! Mulai menarik.")
        SendInput(MOUSE_LEFT_CLICK) -- Asumsi: Klik untuk menarik
        isReeling = TRUE
        isCasting = FALSE

    -- Tahap 3: Minigame Mengikuti Ikan (Kiri/Kanan)
    ELSE IF isReeling THEN
        direction = AnalyzeFishMovement() -- (Membutuhkan API/Visual Detection)
        
        IF direction == 'LEFT' THEN
            SendInput(HOLD_KEY_A) -- Tahan tombol Kiri
            ReleaseInput(KEY_D)
        ELSE IF direction == 'RIGHT' THEN
            SendInput(HOLD_KEY_D) -- Tahan tombol Kanan
            ReleaseInput(KEY_A)
        ELSE -- CENTER / Jeda
            ReleaseInput(KEY_A)
            ReleaseInput(KEY_D)
        END IF
        
        IF IsFishCaught() THEN
            Log("Ikan berhasil ditangkap. Siklus selesai.")
            isReeling = FALSE
            Sleep(2000) 
        ELSE IF IsLineBroken() THEN
            Log("Tali putus!")
            isReeling = FALSE
            Sleep(500)
        END IF
        
    ELSE
        Sleep(50) -- Jeda singkat saat menunggu gigitan
    END IF

END FUNCTION
FUNCTION DisplayMenu()
    -- Menampilkan status fitur saat ini (misalnya di konsol)
    PRINT("--- Auto Script Status ---")
    PRINT("F1 - Auto Fishing: " .. (isFishingActive AND "AKTIF" OR "NONAKTIF"))
    PRINT("F2 - Auto Break: " .. (isBreakingActive AND "AKTIF" OR "NONAKTIF"))
    PRINT("F3 - Auto Plant: " .. (isPlantingActive AND "AKTIF" OR "NONAKTIF"))
    PRINT("F4 - Fast Run: " .. (isFastRunActive AND "AKTIF" OR "NONAKTIF"))
    PRINT("END - Keluar Script")
    PRINT("-------------------------")
END FUNCTION

-- LOOP UTAMA (Berjalan terus-menerus hingga tombol END ditekan)
WHILE NOT IsKeyPressed(HOTKEY_EXIT) DO
    
    -- Memproses Toggle Hotkeys
    IF IsKeyPressed(HOTKEY_TOGGLE_FISH) THEN
        isFishingActive = NOT isFishingActive
        isCasting = FALSE
        isReeling = FALSE 
        DisplayMenu()
        Sleep(250)
    END IF
    
    IF IsKeyPressed(HOTKEY_TOGGLE_BREAK) THEN
        isBreakingActive = NOT isBreakingActive
        DisplayMenu()
        Sleep(250)
    END IF
    
    IF IsKeyPressed(HOTKEY_TOGGLE_PLANT) THEN
        isPlantingActive = NOT isPlantingActive
        DisplayMenu()
        Sleep(250)
    END IF
    
    IF IsKeyPressed(HOTKEY_TOGGLE_RUN) THEN 
        isFastRunActive = NOT isFastRunActive
        FastRun() -- Langsung panggil untuk update speed
        DisplayMenu()
        Sleep(250) 
    END IF
    
    -- Eksekusi Fitur yang Aktif
    IF isFishingActive THEN AutoFishing() END IF
    IF isBreakingActive THEN AutoBreak() END IF
    IF isPlantingActive THEN AutoPlant() END IF
    
    Sleep(10) -- Jeda kecil untuk menghemat resource
END WHILE

-- Pembersihan saat script dihentikan
Player.Character.WalkSpeed = NORMAL_WALK_SPEED
Log("Script dimatikan. Semua status dikembalikan normal.")