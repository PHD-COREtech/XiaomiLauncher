@echo off
chcp 65001 >nul
title KHÔI PHỤC LẠI CÁC ỨNG DỤNG GỐC XIAOMI
setlocal enabledelayedexpansion

cd /d "%~dp0"
set ADB=.\adb.exe

cls
echo ======================================================================
echo              KHÔI PHỤC LẠI CÁC ỨNG DỤNG GỐC XIAOMI
echo ======================================================================
echo.

set DEVICE_FOUND=0
for /f "skip=1 tokens=1,2" %%i in ('"%ADB%" devices') do (
    if "%%j"=="device" (
        set DEVICE_FOUND=1
        set DEVICE_ID=%%i
    )
)

if "!DEVICE_FOUND!"=="0" (
    set /p TV_IP=">> Nhập địa chỉ IP TV: "
    if "!TV_IP!"=="" set TV_IP=192.168.18.235
    "%ADB%" connect !TV_IP!:5555
)

echo.
echo [*] Đang khôi phục (bật lại) các ứng dụng gốc...
echo.

set BLOAT_LIST=com.mitv.tvhome com.miui.tv.analytics com.xiaomi.mitv.tvpush.tvpushservice com.xiaomi.mitv.hyper.screensaver com.xiaomi.voicecontrol com.xiaomi.wakeupservice com.xiaomi.tweather com.xiaomi.mitv.calendar com.xiaomi.mitv.smartpanel com.xiaomi.mitv.healthdiagnosis com.xiaomi.mitv.karaoke.service com.xiaomi.screenrecorder com.xiaomi.mitv.shop com.mitv.toolhouse com.mitv.cloudcontrol

for %%p in (!BLOAT_LIST!) do (
    "%ADB%" shell pm enable %%p >nul 2>&1
    echo     [+] Đã bật lại: %%p
)

echo.
echo ======================================================================
echo [OK] Đã hoàn thành khôi phục toàn bộ các ứng dụng gốc của TV.
echo ======================================================================
echo.
pause

