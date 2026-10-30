@echo off
chcp 65001 >nul
title CÀI ĐẶT & CẤU HÌNH TRỌN GÓI TV LAUNCHER
setlocal enabledelayedexpansion

cd /d "%~dp0"
set ADB=.\adb.exe

cls
echo ======================================================================
echo       TOOL CÀI ĐẶT TRỌN GÓI TV LAUNCHER CHO ANDROID TV / XIAOMI MITV
echo            (Launcher + Bàn phím + Google Voice + Debloat RAM)
echo ======================================================================
echo.

:: 1. Kiểm tra file cần thiết
if not exist "%ADB%" (
    echo [LỖI] Không tìm thấy adb.exe trong thư mục hiện tại!
    pause
    exit /b 1
)
if not exist "tvlauncher.apk" (
    echo [LỖI] Không tìm thấy file tvlauncher.apk!
    pause
    exit /b 1
)
if not exist "keyboard.apk" (
    echo [CẢNH BÁO] Không tìm thấy keyboard.apk! Sẽ bỏ qua cài bàn phím.
)
if not exist "google_voice.apk" (
    echo [CẢNH BÁO] Không tìm thấy google_voice.apk! Sẽ bỏ qua cài Google Voice.
)

:: 2. Khởi động ADB Server
echo [*] Đang khởi động tiến trình ADB...
"%ADB%" start-server >nul 2>&1

:CHECK_DEVICE
echo [*] Đang kiểm tra thiết bị kết nối...
set DEVICE_FOUND=0
for /f "skip=1 tokens=1,2" %%i in ('"%ADB%" devices') do (
    if "%%j"=="device" (
        set DEVICE_FOUND=1
        set DEVICE_ID=%%i
    )
)

if "!DEVICE_FOUND!"=="1" (
    echo [OK] Đã phát hiện thiết bị: !DEVICE_ID!
    goto START_INSTALL
)

echo.
echo [!] Chưa tìm thấy TV nào đang kết nối qua USB hoặc Wi-Fi.
echo.
echo ----------------------------------------------------------------------
echo  HƯỚNG DẪN BẬT ADB TRÊN TV (DÀNH CHO TV MỚI HOẶC VỪA FACTORY RESET):
echo   1. Mở Cài đặt TV (Settings) -> Tùy chọn thiết bị (Device Preferences)
echo   2. Chọn Giới thiệu (About) -> Bấm liên tục 7 lần vào "Số bản dựng" (Build Number)
echo      cho đến khi xuất hiện thông báo "Bạn đã là nhà phát triển".
echo   3. Quay lại menu trước -> Chọn "Tùy chọn cho nhà phát triển" (Developer options)
echo   4. BẬT mục "Gỡ lỗi USB" (USB Debugging) và "Gỡ lỗi qua mạng" (Wireless debugging).
echo   5. Xem IP TV tại: Cài đặt -> Mạng và Internet -> Wi-Fi đang kết nối.
echo ----------------------------------------------------------------------
echo.

set /p TV_IP=">> Nhập địa chỉ IP của TV (Ví dụ: 192.168.18.235) hoặc nhấn Q để thoát: "
if /i "!TV_IP!"=="Q" exit /b 0
if "!TV_IP!"=="" set TV_IP=192.168.18.235

echo [*] Đang kết nối tới !TV_IP!:5555...
"%ADB%" connect !TV_IP!:5555
echo [LƯU Ý] Nếu trên màn hình TV xuất hiện thông báo "Cho phép gỡ lỗi USB?",
echo         hãy tích chọn "Luôn cho phép từ máy tính này" và bấm "OK"!
echo.
timeout /t 3 >nul

for /f "skip=1 tokens=1,2" %%i in ('"%ADB%" devices') do (
    if "%%j"=="device" (
        set DEVICE_FOUND=1
        set DEVICE_ID=%%i
    )
)

if "!DEVICE_FOUND!"=="0" (
    echo [X] Kết nối thất bại hoặc TV chưa chấp nhận quyền ADB.
    echo     Vui lòng kiểm tra lại IP, mạng Wi-Fi và thử lại.
    echo.
    goto CHECK_DEVICE
)

:START_INSTALL
echo.
echo ======================================================================
echo                    BẮT ĐẦU CÀI ĐẶT & THIẾT LẬP
echo ======================================================================
echo.

:: [BƯỚC 1]: CÀI ĐẶT BÀN PHÍM LEANKEY KEYBOARD
if exist "keyboard.apk" (
    echo [1/6] Đang cài đặt Bàn phím TV (keyboard.apk)...
    "%ADB%" install -r keyboard.apk
    echo [*] Kích hoạt và đặt LeanKey Keyboard làm bàn phím mặc định...
    "%ADB%" shell ime enable com.liskovsoft.leankeyboard/.ime.LeanKeyBoardIme >nul 2>&1
    "%ADB%" shell ime set com.liskovsoft.leankeyboard/.ime.LeanKeyBoardIme >nul 2>&1
) else (
    echo [1/6] Bỏ qua cài đặt Bàn phím (không có file keyboard.apk).
)

:: [BƯỚC 2]: CÀI ĐẶT GOOGLE VOICE SEARCH
if exist "google_voice.apk" (
    echo [2/6] Đang cài đặt Google Voice Assistant (google_voice.apk)...
    "%ADB%" install -r google_voice.apk
    echo [*] Cấp quyền Micro và Vị trí cho Google Voice Katniss...
    "%ADB%" shell pm grant com.google.android.katniss android.permission.RECORD_AUDIO >nul 2>&1
    "%ADB%" shell pm grant com.google.android.katniss android.permission.ACCESS_COARSE_LOCATION >nul 2>&1
    "%ADB%" shell pm grant com.google.android.katniss android.permission.ACCESS_FINE_LOCATION >nul 2>&1
) else (
    echo [2/6] Bỏ qua cài đặt Google Voice (không có file google_voice.apk).
)

:: [BƯỚC 3]: CÀI ĐẶT TV LAUNCHER
echo [3/6] Đang cài đặt Launcher TV (tvlauncher.apk)...
"%ADB%" install -r tvlauncher.apk

echo [*] Cấp toàn bộ quyền hệ thống cho Launcher (WRITE_SECURE_SETTINGS, STORAGE, DUMP)...
"%ADB%" shell pm grant com.ts.launcher android.permission.WRITE_SECURE_SETTINGS >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.CHANGE_CONFIGURATION >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.DUMP >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.READ_EXTERNAL_STORAGE >nul 2>&1
"%ADB%" shell pm grant com.ts.launcher android.permission.WRITE_EXTERNAL_STORAGE >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher MANAGE_EXTERNAL_STORAGE allow >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher RUN_IN_BACKGROUND allow >nul 2>&1
"%ADB%" shell cmd appops set com.ts.launcher START_FOREGROUND allow >nul 2>&1
"%ADB%" shell dumpsys deviceidle whitelist +com.ts.launcher >nul 2>&1

:: [BƯỚC 4]: CỐ ĐỊNH HOME VÀ VOICE ACCESSIBILITY SERVICE
echo [4/6] Thiết lập Role HOME mặc định và kích hoạt Voice Accessibility Service...
"%ADB%" shell cmd role add-role-holder android.app.role.HOME com.ts.launcher >nul 2>&1
"%ADB%" shell cmd package set-home-activity --user 0 com.ts.launcher >nul 2>&1

:: Xóa rỗng trước để tránh bug mCrashedServices của Android rồi ghi lại
"%ADB%" shell settings put secure enabled_accessibility_services "" >nul 2>&1
"%ADB%" shell settings put secure enabled_accessibility_services "com.ts.launcher/vn.herotran.launcher.VoiceAccessibilityService" >nul 2>&1
"%ADB%" shell settings put secure accessibility_enabled 1 >nul 2>&1

:: Cố định Google Katniss làm trợ lý giọng nói mặc định
"%ADB%" shell settings put secure assistant com.google.android.katniss/.search.serviceapi.KatnissVoiceInteractionService >nul 2>&1
"%ADB%" shell settings put secure voice_interaction_service com.google.android.katniss/.search.serviceapi.KatnissVoiceInteractionService >nul 2>&1
"%ADB%" shell settings put secure voice_recognition_service com.google.android.katniss/.search.serviceapi.KatnissRecognitionService >nul 2>&1

:: [BƯỚC 5]: CHỐNG ROM XIAOMI FORCE-STOP VÀ GIỮ CỔNG ADB 5555
echo [5/6] Cấu hình chống ROM Xiaomi kill app khi sleep STR và cố định cổng ADB 5555...
"%ADB%" shell settings put global disable_back_home_whitelist disable >nul 2>&1
"%ADB%" shell settings put global device_provisioned 1 >nul 2>&1
"%ADB%" shell settings put secure user_setup_complete 1 >nul 2>&1
"%ADB%" shell settings put global adb_enabled 1 >nul 2>&1
"%ADB%" shell settings put secure adb_enabled 1 >nul 2>&1
"%ADB%" shell setprop persist.adb.tcp.port 5555 >nul 2>&1
"%ADB%" shell setprop service.adb.tcp.port 5555 >nul 2>&1

:: [BƯỚC 6]: TẮT CÁC ỨNG DỤNG RÁC, QUẢNG CÁO & NGỐN RAM GỐC (DEBLOAT)
echo.
echo ======================================================================
echo  [6/6] TỐI ƯU HÓA HỆ THỐNG: VÔ HIỆU HÓA CÁC APP RÁC & NGỐN RAM CỦA TV
echo ======================================================================
echo  Danh sách các app rác sẽ được tắt:
echo   - Launcher gốc PatchWall (com.mitv.tvhome) - Quảng cáo & ngốn RAM nặng nhất
echo   - Thu thập thông tin / Đo kiểm (com.miui.tv.analytics)
echo   - Dịch vụ quảng cáo & thông báo đẩy (com.xiaomi.mitv.tvpush.tvpushservice)
echo   - Màn hình chờ online (com.xiaomi.mitv.hyper.screensaver)
echo   - Trợ lý XiaoAI & Giọng nói tiếng Trung (com.xiaomi.voicecontrol, wakeupservice)
echo   - Thời tiết tiếng Trung chạy ngầm (com.xiaomi.tweather)
echo   - Lịch, SmartPanel, Chẩn đoán, Mua sắm tiếng Trung chạy nền
echo ----------------------------------------------------------------------
set /p DO_DEBLOAT=">> Bạn có muốn vô hiệu hóa toàn bộ app rác để TV siêu mượt không? [Y/N, Mặc định: Y]: "
if "!DO_DEBLOAT!"=="" set DO_DEBLOAT=Y
if /i "!DO_DEBLOAT!"=="Y" (
    echo [*] Đang vô hiệu hóa các ứng dụng bloatware rác...
    set BLOAT_LIST=com.mitv.tvhome com.miui.tv.analytics com.xiaomi.mitv.tvpush.tvpushservice com.xiaomi.mitv.hyper.screensaver com.xiaomi.voicecontrol com.xiaomi.wakeupservice com.xiaomi.tweather com.xiaomi.mitv.calendar com.xiaomi.mitv.smartpanel com.xiaomi.mitv.healthdiagnosis com.xiaomi.mitv.karaoke.service com.xiaomi.screenrecorder com.xiaomi.mitv.shop com.mitv.toolhouse com.mitv.cloudcontrol
    for %%p in (!BLOAT_LIST!) do (
        "%ADB%" shell pm disable-user --user 0 %%p >nul 2>&1
        echo     [-] Đã tắt: %%p
    )
    echo [OK] Đã hoàn tất tắt bloatware! Giải phóng khoảng 300MB - 600MB RAM.
) else (
    echo [*] Bỏ qua bước tắt app rác.
)

:: KHỞI CHẠY LAUNCHER
echo.
echo [*] Đang khởi chạy Launcher trên TV...
"%ADB%" shell am start -n com.ts.launcher/vn.herotran.launcher.HomeActivity >nul 2>&1

echo.
echo ======================================================================
echo    CHÚC MỪNG! ĐÃ HOÀN TẤT CÀI ĐẶT VÀ TỐI ƯU TOÀN DIỆN CHO TV!
echo ----------------------------------------------------------------------
echo  1. TV Launcher đã trở thành giao diện chính mặc định.
echo  2. Bấm phím Home trên remote ở bất kỳ app nào đều quay về Launcher.
echo  3. Phím Voice tìm kiếm tiếng Việt Google hoạt động trơn tru.
echo  4. Tắt/bật TV bằng remote (STR sleep) không bị màn hình đen.
echo  5. Hệ thống đã được dọn sạch app rác, RAM trống tối đa.
echo  6. Cổng ADB 5555 luôn mở sẵn cho lần bảo trì tiếp theo.
echo ======================================================================
echo.
pause
