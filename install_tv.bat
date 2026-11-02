@echo off
setlocal enabledelayedexpansion
title CAI DAT VA CAU HINH TRON GOI TV LAUNCHER

cd /d "%~dp0"
set ADB=.\adb.exe

cls
echo ======================================================================
echo       TOOL CAI DAT TRON GOI TV LAUNCHER CHO ANDROID TV / XIAOMI MITV
echo            [Launcher + Ban phim + Google Voice + Debloat RAM]
echo ======================================================================
echo.

:: 1. Kiem tra cac file can thiet
if not exist "%ADB%" (
    echo [LOI] Khong tim thay file adb.exe trong thu muc!
    pause
    exit /b 1
)
if not exist "tvlauncher.apk" (
    echo [LOI] Khong tim thay file tvlauncher.apk!
    pause
    exit /b 1
)
if not exist "keyboard.apk" (
    echo [CANH BAO] Khong tim thay keyboard.apk. Se bo qua cai ban phim.
)
if not exist "google_voice.apk" (
    echo [CANH BAO] Khong tim thay google_voice.apk. Se bo qua cai Google Voice.
)

:: 2. Khoi dong ADB Server
echo [*] Dang khoi dong tien trinh ADB...
"%ADB%" start-server >nul 2>&1

:CHECK_DEVICE
echo [*] Dang kiem tra thiet bi ket noi...
set DEVICE_FOUND=0
set DEVICE_ID=
for /f "skip=1 tokens=1,2" %%i in ('"%ADB%" devices') do (
    if "%%j"=="device" (
        set DEVICE_FOUND=1
        set DEVICE_ID=%%i
    )
)

if "!DEVICE_FOUND!"=="1" (
    echo [OK] Da phat hien thiet bi ket noi: !DEVICE_ID!
    goto START_INSTALL
)

echo.
echo [!] Chua co thiet bi nao ket noi san qua USB hoac ADB Wi-Fi.
echo [*] Dang tu dong quet tim Smart TV trong mang noi bo (Port 5555 ADB)...
set SCAN_OUT=%TEMP%\tv_ip_found_%RANDOM%.txt
if exist "!SCAN_OUT!" del "!SCAN_OUT!" >nul 2>&1

if exist "%~dp0Find_IP_SmartTV.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Find_IP_SmartTV.ps1" -OutFile "!SCAN_OUT!"
)

set AUTO_IP=
if exist "!SCAN_OUT!" (
    for /f "usebackq tokens=*" %%a in ("!SCAN_OUT!") do (
        if "!AUTO_IP!"=="" set AUTO_IP=%%a
    )
    del "!SCAN_OUT!" >nul 2>&1
)

if not "!AUTO_IP!"=="" (
    echo.
    echo ======================================================================
    echo  [OK] DA TU DONG PHAT HIEN SMART TV TAI IP: !AUTO_IP!
    echo ======================================================================
    set TV_IP=!AUTO_IP!
    goto DO_CONNECT
)

echo.
echo [!] Quet tu dong khong tim thay TV nao dang mo cong ADB 5555.
echo.
echo ----------------------------------------------------------------------
echo  HUONG DAN BAT ADB TREN TV (DANH CHO TV MOI HOAC FACTORY RESET):
echo   1. Mo Cai dat TV (Settings) -^> Tuy chon thiet bi (Device Preferences)
echo   2. Chon Gioi thieu (About) -^> Bam lien tuc 7 lan vao "So ban dung" (Build Number)
echo      cho den khi xuat hien thong bao "Ban da la nha phat trien".
echo   3. Quay lai menu truoc -^> Chon "Tuy chon cho nha phat trien" (Developer options)
echo   4. BAT muc "Go loi USB" (USB Debugging) va "Go loi qua mang" (Wireless debugging).
echo   5. Xem IP TV tai: Cai dat -^> Mang va Internet -^> Wi-Fi dang ket noi.
echo ----------------------------------------------------------------------
echo.

set /p TV_IP=">> Nhap dia chi IP cua TV (Vi du: 192.168.18.235) hoac nhan Q de thoat: "
if /i "!TV_IP!"=="Q" exit /b 0
if "!TV_IP!"=="" (
    echo [LOI] Ban chua nhap dia chi IP!
    echo.
    goto CHECK_DEVICE
)

:DO_CONNECT
echo.
echo [*] Dang ket noi toi !TV_IP!:5555...
"%ADB%" connect !TV_IP!:5555
echo.
echo [LUU Y] Neu tren man hinh TV xuat hien hop thoai "Cho phep go loi USB?",
echo         hay tich chon "Luon cho phep tu may tinh nay" va bam "OK"!
echo.
ping -n 4 127.0.0.1 >nul

set DEVICE_FOUND=0
set DEVICE_ID=
for /f "skip=1 tokens=1,2" %%i in ('"%ADB%" devices') do (
    if "%%j"=="device" (
        set DEVICE_FOUND=1
        set DEVICE_ID=%%i
    )
)

if "!DEVICE_FOUND!"=="1" goto START_INSTALL

echo [X] Chua the xac thuc voi TV hoac TV chua chap nhan quyen ADB.
echo     Vui long kiem tra man hinh TV, tich chon cho phep go loi va thu lai.
echo.
set /p RETRY=">> Ban co muon thu ket noi lai khong? [Y/N, Mac dinh: Y]: "
if /i "!RETRY!"=="N" exit /b 1
goto CHECK_DEVICE

:START_INSTALL
echo.
echo ======================================================================
echo                    BAT DAU CAI DAT VA THIET LAP
echo ======================================================================
echo.

:: [BUOC 1]: CAI DAT BAN PHIM LEANKEY KEYBOARD
if not exist "keyboard.apk" (
    echo [1/6] Bo qua cai dat Ban phim [khong co file keyboard.apk].
    goto STEP2_VOICE
)
echo [1/6] Dang cai dat Ban phim TV [keyboard.apk]...
"%ADB%" install -r keyboard.apk
echo [*] Kich hoat va dat LeanKey Keyboard lam ban phim mac dinh...
"%ADB%" shell ime enable com.liskovsoft.leankeyboard/.ime.LeanKeyBoardIme >nul 2>&1
"%ADB%" shell ime set com.liskovsoft.leankeyboard/.ime.LeanKeyBoardIme >nul 2>&1

:STEP2_VOICE
:: [BUOC 2]: CAI DAT GOOGLE VOICE SEARCH
if not exist "google_voice.apk" (
    echo [2/6] Bo qua cai dat Google Voice [khong co file google_voice.apk].
    goto STEP3_LAUNCHER
)
echo [2/6] Dang cai dat Google Voice Assistant [google_voice.apk]...
"%ADB%" install -r google_voice.apk
echo [*] Cap quyen Micro va Vi tri cho Google Voice Katniss...
"%ADB%" shell pm grant com.google.android.katniss android.permission.RECORD_AUDIO >nul 2>&1
"%ADB%" shell pm grant com.google.android.katniss android.permission.ACCESS_COARSE_LOCATION >nul 2>&1
"%ADB%" shell pm grant com.google.android.katniss android.permission.ACCESS_FINE_LOCATION >nul 2>&1

:STEP3_LAUNCHER
:: [BUOC 3]: CAI DAT TV LAUNCHER
echo [3/6] Dang cai dat Launcher TV [tvlauncher.apk]...
"%ADB%" install -r tvlauncher.apk

echo [*] Cap toan bo quyen he thong cho Launcher [WRITE_SECURE_SETTINGS, STORAGE, DUMP]...
"%ADB%" shell pm grant com.ts.launcher android.permission.WRITE_SECURE_SETTINGS >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.CHANGE_CONFIGURATION >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.DUMP >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.READ_EXTERNAL_STORAGE >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.WRITE_EXTERNAL_STORAGE >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher MANAGE_EXTERNAL_STORAGE allow >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher RUN_IN_BACKGROUND allow >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher START_FOREGROUND allow >nul 2>&1
"%ADB%" shell dumpsys deviceidle whitelist +com.ts.launcher >nul 2>&1

:: [BUOC 4]: CO DINH HOME VA VOICE ACCESSIBILITY SERVICE
echo [4/6] Thiet lap Role HOME mac dinh va kich hoat Voice Accessibility Service...
"%ADB%" shell cmd role add-role-holder android.app.role.HOME com.ts.launcher >nul 2>&1
"%ADB%" shell cmd package set-home-activity --user 0 com.ts.launcher >nul 2>&1

:: Xoa rong truoc de tranh bug mCrashedServices cua Android roi ghi lai
"%ADB%" shell settings put secure enabled_accessibility_services "" >nul 2>&1
"%ADB%" shell settings put secure enabled_accessibility_services "com.ts.launcher/vn.herotran.launcher.VoiceAccessibilityService" >nul 2>&1
"%ADB%" shell settings put secure accessibility_enabled 1 >nul 2>&1

:: Co dinh Google Katniss lam tro ly giong noi mac dinh
"%ADB%" shell settings put secure assistant com.google.android.katniss/.search.serviceapi.KatnissVoiceInteractionService >nul 2>&1
"%ADB%" shell settings put secure voice_interaction_service com.google.android.katniss/.search.serviceapi.KatnissVoiceInteractionService >nul 2>&1
"%ADB%" shell settings put secure voice_recognition_service com.google.android.katniss/.search.serviceapi.KatnissRecognitionService >nul 2>&1

:: [BUOC 5]: CHONG ROM XIAOMI FORCE-STOP VA GIU CONG ADB 5555
echo [5/6] Cau hinh chong ROM Xiaomi kill app khi sleep STR va co dinh cong ADB 5555...
"%ADB%" shell settings put global disable_back_home_whitelist disable >nul 2>&1
"%ADB%" shell settings put global device_provisioned 1 >nul 2>&1
"%ADB%" shell settings put secure user_setup_complete 1 >nul 2>&1
"%ADB%" shell settings put global adb_enabled 1 >nul 2>&1
"%ADB%" shell settings put secure adb_enabled 1 >nul 2>&1
"%ADB%" shell setprop persist.adb.tcp.port 5555 >nul 2>&1
"%ADB%" shell setprop service.adb.tcp.port 5555 >nul 2>&1

:: [BUOC 6]: TAT CAC UNG DUNG RAC, QUANG CAO VA NGON RAM GOC [DEBLOAT]
echo.
echo ======================================================================
echo  [6/6] TOI UU HOA HE THONG: VO HIEU HOA CAC APP RAC VA NGON RAM TV
echo ======================================================================
echo  Danh sach cac app rac se duoc tat:
echo   - Launcher goc PatchWall [com.mitv.tvhome] - Quang cao va ngon RAM nang nhat
echo   - Thu thap thong tin / Do kiem [com.miui.tv.analytics]
echo   - Dich vu quang cao va thong bao day [com.xiaomi.mitv.tvpush.tvpushservice]
echo   - Man hinh cho online [com.xiaomi.mitv.hyper.screensaver]
echo   - Tro ly XiaoAI va Giong noi tieng Trung [com.xiaomi.voicecontrol, wakeupservice]
echo   - Thoi tiet tieng Trung chay ngam [com.xiaomi.tweather]
echo   - Lich, SmartPanel, Chan doan, Mua sam tieng Trung chay nen
echo ----------------------------------------------------------------------
set /p DO_DEBLOAT=">> Ban co muon vo hieu hoa toan bo app rac de TV sieu muot khong? [Y/N, Mac dinh: Y]: "
if "!DO_DEBLOAT!"=="" set DO_DEBLOAT=Y
if /i not "!DO_DEBLOAT!"=="Y" (
    echo [*] Bo qua buoc tat app rac.
    goto LAUNCH_HOME
)

echo [*] Dang vo hieu hoa cac ung dung bloatware rac...
set BLOAT_LIST=com.mitv.tvhome com.miui.tv.analytics com.xiaomi.mitv.tvpush.tvpushservice com.xiaomi.mitv.hyper.screensaver com.xiaomi.voicecontrol com.xiaomi.wakeupservice com.xiaomi.tweather com.xiaomi.mitv.calendar com.xiaomi.mitv.smartpanel com.xiaomi.mitv.healthdiagnosis com.xiaomi.mitv.karaoke.service com.xiaomi.screenrecorder com.xiaomi.mitv.shop com.mitv.toolhouse com.mitv.cloudcontrol
for %%p in (!BLOAT_LIST!) do (
    "%ADB%" shell pm disable-user --user 0 %%p >nul 2>&1
    echo     [-] Da tat: %%p
)
echo [OK] Da hoan tat tat bloatware! Giai phong khoang 300MB - 600MB RAM.

:LAUNCH_HOME
:: KHOI CHAY LAUNCHER
echo.
echo [*] Dang khoi chay Launcher tren TV...
"%ADB%" shell am start -n com.ts.launcher/vn.herotran.launcher.HomeActivity >nul 2>&1

echo.
echo ======================================================================
echo    CHUC MUNG! DA HOAN TAT CAI DAT VA TOI UU TOAN DIEN CHO TV!
echo ----------------------------------------------------------------------
echo  1. TV Launcher da tro thanh giao dien chinh mac dinh.
echo  2. Bam phim Home tren remote o bat ky app nao deu quay ve Launcher.
echo  3. Phim Voice tim kiem tieng Viet Google hoat dong tron tru.
echo  4. Tat/bat TV bang remote [STR sleep] khong bi man hinh den.
echo  5. He thong da duoc don sach app rac, RAM trong toi da.
echo  6. Cong ADB 5555 luon mo san cho lan bao tri tiep theo.
echo ======================================================================
echo.
pause
