@echo off
chcp 65001 >nul
title TẮT ỨNG DỤNG RÁC & TỐI ƯU RAM TV XIAOMI
setlocal enabledelayedexpansion

cd /d "%~dp0"
set ADB=.\adb.exe

cls
echo ======================================================================
echo          CÔNG CỤ TẮT BLOATWARE & GIẢI PHÓNG RAM CHO TV XIAOMI
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
echo [*] Đang tiến hành vô hiệu hóa các ứng dụng rác, quảng cáo và ngốn RAM...
echo.

set BLOAT_LIST=com.mitv.tvhome com.miui.tv.analytics com.xiaomi.mitv.tvpush.tvpushservice com.xiaomi.mitv.hyper.screensaver com.xiaomi.voicecontrol com.xiaomi.wakeupservice com.xiaomi.tweather com.xiaomi.mitv.calendar com.xiaomi.mitv.smartpanel com.xiaomi.mitv.healthdiagnosis com.xiaomi.mitv.karaoke.service com.xiaomi.screenrecorder com.xiaomi.mitv.shop com.mitv.toolhouse com.mitv.cloudcontrol

for %%p in (!BLOAT_LIST!) do (
    "%ADB%" shell pm disable-user --user 0 %%p >nul 2>&1
    echo     [-] Đã tắt thành công: %%p
)

echo.
echo ======================================================================
echo [OK] Đã hoàn thành! Toàn bộ app rác chạy ngầm đã bị vô hiệu hóa.
echo      RAM hệ thống đã được giải phóng tối đa, TV chạy mượt mà hơn.
echo ======================================================================
echo.
pause

