# HƯỚNG DẪN CÀI ĐẶT TRỌN GÓI TV LAUNCHER & TỐI ƯU HỆ THỐNG
### (Dành cho Android TV, Xiaomi MiTV, Redmi TV — Cài mới hoặc sau khi Factory Reset)

Thư mục này chứa đầy đủ công cụ cài đặt tự động 1-Click cho TV Launcher, đi kèm Bàn phím gõ tiếng Việt, Dịch vụ tìm kiếm giọng nói Google Tiếng Việt, và bộ công cụ **Debloat tắt toàn bộ ứng dụng rác ngốn RAM của TV gốc**.

---

## 📦 1. Các file có trong thư mục này

| Tên File | Chức năng | Ghi chú |
| :--- | :--- | :--- |
| `install_tv.bat` | Script tự động kết nối, cài đặt, cấp quyền và debloat RAM | Chạy trực tiếp trên Windows (Khuyên dùng) |
| `debloat_xiaomi.bat` | Script chuyên dùng để tắt nhanh các app rác / ngốn RAM | Chạy riêng bất cứ lúc nào |
| `restore_bloatware.bat` | Script khôi phục (bật lại) toàn bộ các app gốc đã tắt | Dùng khi muốn đưa TV về nguyên bản |
| `tvlauncher.apk` | Bộ Launcher siêu nhẹ (231 KB), thuần Java 8 không thư viện rác | App ID: `com.ts.launcher` (Bypass whitelist Xiaomi) |
| `google_voice.apk` | Google Katniss Voice Search tiếng Việt chuẩn TV | Tích hợp nút Voice trên Remote |
| `keyboard.apk` | LeanKey Keyboard Pro (bàn phím tiếng Việt dành riêng cho Remote TV) | Tự động kích hoạt làm bàn phím chính |
| `adb.exe`, `AdbWinApi.dll`, `AdbWinUsbApi.dll` | Bộ công cụ ADB độc lập | Chạy ngay không cần cài đặt Android SDK |

---

## ⚙️ 2. Chuẩn bị trên TV (Sau khi Factory Reset hoặc trên TV mới)

Sau khi TV khởi động vào màn hình cài đặt ban đầu:
1. Kết nối TV vào cùng mạng Wi-Fi với máy tính.
2. **Bật chế độ Nhà phát triển (Developer Options)**:
   - Vào **Cài đặt (Settings)** -> **Tùy chọn thiết bị (Device Preferences)** -> **Giới thiệu (About)**.
   - Tìm mục **Số bản dựng (Build Number)**, bấm nút **OK** trên Remote liên tục **7 lần** cho đến khi thấy thông báo: *"Bạn đã là nhà phát triển!"*.
3. **Bật Gỡ lỗi USB (USB Debugging)**:
   - Quay lại menu trước -> Chọn **Tùy chọn cho nhà phát triển (Developer Options)**.
   - Bật mục **Gỡ lỗi USB (USB Debugging)** sang **ON**.
   - (Nếu có) Bật thêm mục **Gỡ lỗi qua mạng (Wireless debugging)**.
4. **Xem địa chỉ IP của TV**:
   - Vào **Cài đặt** -> **Mạng và Internet** -> Bấm vào tên Wi-Fi đang kết nối.
   - Ghi nhớ địa chỉ IP (Ví dụ: `192.168.1.50` hoặc `192.168.18.235`).

---

## 🚀 3. Các bước cài đặt bằng máy tính

1. Mở thư mục `INSTALL` trên máy tính Windows.
2. Nhấp đúp chuột vào file **`install_tv.bat`**.
3. Nếu TV chưa kết nối sẵn:
   - Tool sẽ yêu cầu bạn nhập địa chỉ IP của TV.
   - Nhập IP của TV (ví dụ: `192.168.18.235`) rồi bấm **Enter**.
4. **CHÚ Ý QUAN TRỌNG TRÊN MÀN HÌNH TV**:
   - Lúc này trên màn hình TV sẽ hiện một hộp thoại thông báo: **"Cho phép gỡ lỗi USB?" (Allow USB debugging?)**.
   - Dùng remote chọn tích vào ô **"Luôn cho phép từ máy tính này" (Always allow from this computer)**.
   - Bấm **OK**.
5. Script sẽ tự động thực hiện từ A đến Z:
   - Cài đặt Bàn phím TV và kích hoạt mặc định.
   - Cài đặt Google Voice và cấp quyền Micro, Vị trí.
   - Cài đặt Launcher, cấp quyền bảo mật `WRITE_SECURE_SETTINGS`, bộ nhớ, CPU/RAM.
   - Cố định phím Home và kích hoạt Accessibility Service.
   - Chống Xiaomi force-stop Launcher khi tắt TV (STR standby).
   - Tự động tắt toàn bộ app rác, quảng cáo ngốn RAM (Debloat).
   - Tự động bật Launcher lên màn hình TV!

---

## 🧹 4. Danh sách các Lệnh ADB Tắt Ứng Dụng Rác (Debloat RAM)

Dưới đây là danh sách chi tiết các lệnh ADB dùng để vô hiệu hóa (`disable-user`) các ứng dụng gốc ngốn RAM, quảng cáo và dịch vụ chạy nền vô ích của Xiaomi. Các lệnh này đã được tích hợp sẵn trong `install_tv.bat` và `debloat_xiaomi.bat`:

```bash
# 1. Launcher PatchWall gốc của Xiaomi (Chiếm 250MB - 400MB RAM, chứa quảng cáo liên tục)
adb shell pm disable-user --user 0 com.mitv.tvhome

# 2. Dịch vụ thu thập thông tin người dùng / telemetry chạy nền
adb shell pm disable-user --user 0 com.miui.tv.analytics

# 3. Dịch vụ đẩy quảng cáo và thông báo pop-up rác của Xiaomi
adb shell pm disable-user --user 0 com.xiaomi.mitv.tvpush.tvpushservice

# 4. Màn hình chờ trực tuyến Hyper screensaver (ngốn RAM và băng thông mạng)
adb shell pm disable-user --user 0 com.xiaomi.mitv.hyper.screensaver

# 5. Trợ lý ảo XiaoAI tiếng Trung (vô dụng khi đã có Google Tiếng Việt)
adb shell pm disable-user --user 0 com.xiaomi.voicecontrol

# 6. Dịch vụ lắng nghe từ khóa giọng nói XiaoAI tiếng Trung chạy ngầm
adb shell pm disable-user --user 0 com.xiaomi.wakeupservice

# 7. Widget / Ứng dụng thời tiết tiếng Trung chạy nền
adb shell pm disable-user --user 0 com.xiaomi.tweather

# 8. Ứng dụng Lịch Xiaomi tiếng Trung
adb shell pm disable-user --user 0 com.xiaomi.mitv.calendar

# 9. Bảng điều khiển nhà thông minh Xiaomi SmartPanel
adb shell pm disable-user --user 0 com.xiaomi.mitv.smartpanel

# 10. Dịch vụ chẩn đoán sức khỏe TV chạy nền
adb shell pm disable-user --user 0 com.xiaomi.mitv.healthdiagnosis

# 11. Dịch vụ hát Karaoke Xiaomi
adb shell pm disable-user --user 0 com.xiaomi.mitv.karaoke.service

# 12. Trình quay phim màn hình TV
adb shell pm disable-user --user 0 com.xiaomi.screenrecorder

# 13. Cửa hàng mua sắm Xiaomi Store tiếng Trung
adb shell pm disable-user --user 0 com.xiaomi.mitv.shop

# 14. Công cụ quản lý rác Xiaomi
adb shell pm disable-user --user 0 com.mitv.toolhouse

# 15. Dịch vụ quản lý đám mây Xiaomi
adb shell pm disable-user --user 0 com.mitv.cloudcontrol
```

> **Ghi chú**: Lệnh `pm disable-user --user 0` là phương thức an toàn nhất trên Android. Nó đóng băng hoàn toàn ứng dụng khỏi bộ nhớ và không thể tự khởi chạy ngầm, nhưng không xóa file khỏi ROM hệ thống. Bạn có thể khôi phục lại bất cứ lúc nào bằng lệnh:
> `adb shell pm enable <tên_package>` hoặc chỉ cần chạy file **`restore_bloatware.bat`**!

---

## ⚠️ 5. Các ứng dụng hệ thống TUYỆT ĐỐI KHÔNG ĐƯỢC TẮT

Không được tắt các package sau đây vì sẽ gây lỗi treo TV (bootloop) hoặc mất menu cài đặt:
- `com.xiaomi.mitv.settings` (Cài đặt hệ thống TV)
- `com.xiaomi.mitv.systemui` (Thanh trạng thái, hiển thị âm lượng)
- `com.xiaomi.mitv.tvmanager` (Quản lý phần cứng TV)
- `mitv.service` (Dịch vụ lõi phần cứng của Xiaomi MiTV)
- `com.xiaomi.setupwizard` (Trình thiết lập ban đầu)

---

## 🌟 6. Các tính năng sau khi cài đặt thành công

- **Mở máy là vào Launcher**: TV khởi động hoặc bật từ chế độ tắt bằng remote đều vào thẳng Launcher ngay lập tức.
- **Phím HOME chuẩn 100%**: Bấm nút Home ở bất kỳ ứng dụng nào (YouTube, VTVgo, NetFlix...) đều quay về màn hình chính tức thì.
- **Nút Voice remote**: Bấm nút Micro trên Remote Xiaomi/Android TV sẽ kích hoạt Google Assistant Katniss tiếng Việt siêu nhạy.
- **Bàn phím tiếng Việt**: Khi gõ tìm kiếm, bàn phím LeanKey tự mở to, dễ bấm bằng phím điều hướng remote.
- **Tiết kiệm RAM tối đa**: RAM trống thêm **300MB - 600MB**, CPU mát hơn và TV mượt mà hơn rất nhiều so với ROM gốc.
- **Đầy đủ Widget**: Thời tiết địa phương tự nhận diện, Lịch Âm ngày lễ Việt Nam, Bảng Giá Xăng Dầu Petrolimex và Bảng Giá Vàng SJC cập nhật trực tiếp.
