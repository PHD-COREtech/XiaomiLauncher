# HƯỚNG DẪN CÀI ĐẶT TRỌN GÓI TV LAUNCHER, TỐI ƯU HỆ THỐNG & ĐIỀU KHIỂN GIỌNG NÓI
### (Dành cho Xiaomi MiTV, Redmi TV (nội địa) — Cài mới hoặc sau khi Factory Reset)

<img width="1920" height="1080" alt="HOME_SCREEN" src="https://github.com/user-attachments/assets/d4a0c1d7-8fc4-476c-a025-d6c2b247165f" />

Thư mục này chứa đầy đủ công cụ cài đặt tự động 1-Click cho **TV Launcher**, đi kèm Bàn phím gõ tiếng Việt trên Remote, Dịch vụ tìm kiếm giọng nói Google Assistant tiếng Việt, bộ công cụ **Debloat tắt toàn bộ ứng dụng rác ngốn RAM của TV gốc**, tự động cài đặt **Múi giờ Việt Nam GMT+7**, và **Tài liệu hướng dẫn điều khiển giọng nói chi tiết**.

---

## 📺 1. Thiết Bị Hỗ Trợ & Yêu Cầu Đời Android

### 1.1. Các dòng TV tương thích
* **Tối ưu chuyên sâu & tương thích 100%:** Toàn bộ các dòng **Smart TV Xiaomi**, **Redmi TV** (cả bản **Nội địa Trung Quốc xách tay** chạy ROM gốc MIUI TV / HyperOS TV và bản **Quốc tế**).
  - *Các model tiêu biểu đã kiểm thử hoàn hảo:* Xiaomi Mi TV EA series (EA32, EA40, EA43, EA50, EA55, EA65, EA70, EA75...), dòng A series, A Pro, Redmi MAX (86", 98", 100"), Redmi Smart TV X series (X55, X65, X75), ES series, Mi TV P1, 4A, 4C, 4S... (Android 11, SDK 30)
  - *Giải quyết triệt để các hạn chế của ROM Xiaomi gốc:*
    - Chống lỗi ROM Xiaomi tự kill Launcher khi tắt TV bằng remote (chế độ STR standby) gây đen màn hình.
    - Vô hiệu hóa launcher PatchWall tiếng Trung cùng hệ thống quảng cáo ngốn tới 600MB RAM.
    - Cài đặt múi giờ chuẩn Việt Nam GMT+7 (`Asia/Ho_Chi_Minh`), không bị nhảy lệch sang giờ Bắc Kinh GMT+8.
    - Tích hợp tìm kiếm giọng nói tiếng Việt mượt mà ngay trên nút Micro của Remote Bluetooth gốc.

### 1.2. Đời Android & Cấu hình phần cứng yêu cầu
* **Phiên bản Android hỗ trợ:**
  - Hỗ trợ từ **Android TV 9.0 (Pie / API 28)**, **Android TV 10 (Q / API 29)**, **Android TV 11 (Red Velvet Cake / API 30)** đến **Android TV 12 (API 31/32)** và **Android TV 13 (API 33)**.
  - **Phiên bản khuyến nghị & tối ưu chuẩn nhất:** **Android TV 11 (targetSdk 30 / API level 30)** — hệ điều hành nền tảng của đa số dòng Xiaomi / Redmi TV.
* **Kiến trúc CPU:** Hỗ trợ đầy đủ cả vi xử lý **32-bit (armeabi-v7a)** và **64-bit (arm64-v8a)**.
* **Yêu cầu phần cứng tối thiểu:**
  - RAM: Từ **1 GB RAM** trở lên (Launcher siêu nhẹ ~210 KB kết hợp debloat giải phóng ~500MB RAM, giúp TV RAM yếu chạy mượt như máy mới).
  - Bộ nhớ trong (ROM): Trống tối thiểu **50 MB**.

---

## 📦 2. Các File Có Trong Thư Mục Này

| Tên File | Chức năng | Ghi chú |
| :--- | :--- | :--- |
| **`install_tv.bat`** | Script tự động quét IP, kết nối ADB, cài đặt trọn gói, chỉnh giờ GMT+7, cấp quyền và debloat RAM | Chạy trực tiếp trên Windows (Khuyên dùng) |
| **`debloat_xiaomi.bat`** | Script chuyên dùng để tự quét IP và tắt nhanh 15 app rác / ngốn RAM | Chạy riêng bất cứ lúc nào |
| **`restore_bloatware.bat`** | Script tự quét IP và khôi phục (bật lại) toàn bộ các app gốc đã tắt | Dùng khi muốn đưa TV về nguyên bản |
| **`Find_IP_SmartTV.bat`** | Công cụ độc lập quét tìm nhanh địa chỉ IP của Smart TV trong mạng LAN/Wi-Fi | Hiển thị ngay IP đang mở port 5555 |
| **`tvlauncher.apk`** | Bộ TV Launcher siêu nhẹ (~210 KB), thuần Java 8 không thư viện rác | Application ID: `com.ts.launcher` |
| **`google_voice.apk`** | Google Katniss Voice Search tiếng Việt chuẩn TV | Tích hợp nút Voice trên Remote |
| **`keyboard.apk`** | LeanKey Keyboard Pro (bàn phím tiếng Việt dành riêng cho Remote TV) | Tự động kích hoạt làm bàn phím chính |
| **`adb.exe`, `AdbWinApi.dll`, `AdbWinUsbApi.dll`** | Bộ công cụ kết nối Android Debug Bridge (ADB) độc lập | Chạy ngay không cần cài Android Studio |

---

## ⚙️ 3. Chuẩn Bị Trên TV (Sau khi Factory Reset hoặc trên TV mới)

Sau khi TV khởi động vào màn hình ban đầu:
1. Kết nối TV vào cùng mạng Wi-Fi với máy tính.
2. **Bật chế độ Nhà phát triển (Developer Options)**:
   - Vào **Cài đặt (Settings)** $\rightarrow$ **Tùy chọn thiết bị (Device Preferences)** $\rightarrow$ **Giới thiệu (About)**.
   - Tìm mục **Số bản dựng (Build Number)**, bấm nút **OK** trên Remote liên tục **7 lần** cho đến khi thấy thông báo: *"Bạn đã là nhà phát triển!"*.
3. **Bật Gỡ lỗi USB (USB Debugging)**:
   - Quay lại menu trước $\rightarrow$ Chọn **Tùy chọn cho nhà phát triển (Developer Options)**.
   - Bật mục **Gỡ lỗi USB (USB Debugging)** sang **ON**.
   - *(Nếu có)* Bật thêm mục **Gỡ lỗi qua mạng (Wireless debugging)**.
4. **Xem địa chỉ IP của TV (Tùy chọn)**:
   - Vào **Cài đặt** $\rightarrow$ **Mạng và Internet** $\rightarrow$ Bấm vào tên Wi-Fi đang kết nối để xem IP (ví dụ: `192.168.18.235` hoặc `192.168.18.228`).
   - *(Lưu ý: Tool hiện đã có tính năng tự động quét IP trong dải mạng Wi-Fi nội bộ, bạn không nhất thiết phải ghi nhớ IP).*

---

## 🚀 4. Các Bước Cài Đặt Tự Động 1-Click

1. Mở thư mục `INSTALL` trên máy tính Windows.
2. Nhấp đúp chuột vào file **`install_tv.bat`**.
3. **Cơ chế tự động kết nối thông minh**:
   - Tool tự động kiểm tra xem TV đã kết nối qua USB hoặc Wi-Fi chưa.
   - Nếu chưa có kết nối, tool sẽ **tự động quét đa luồng 60 luồng** dải IP mạng Wi-Fi/LAN trong vòng ~5 giây để tìm Smart TV đang mở cổng ADB 5555.
   - Khi tìm thấy Smart TV, tool sẽ **tự động kết nối** mà bạn không cần phải gõ tay địa chỉ IP!
   - *(Chỉ khi TV đang tắt màn hình hoặc chưa bật ADB thì tool mới dừng lại hiện bảng hướng dẫn và cho bạn nhập IP thủ công).*
4. **CHÚ Ý QUAN TRỌNG TRÊN MÀN HÌNH TV (Trong lần đầu tiên)**:
   - Lúc này trên màn hình TV sẽ hiện một hộp thoại thông báo: **"Cho phép gỡ lỗi USB?" (Allow USB debugging?)**.
   - Dùng remote chọn tích vào ô: **"Luôn cho phép từ máy tính này" (Always allow from this computer)**.
   - Bấm **OK**.
5. Script sẽ tự động thực hiện trọn gói từ A đến Z:
   - **[1/6]** Cài đặt Bàn phím TV LeanKey và kích hoạt mặc định.
   - **[2/6]** Cài đặt Google Voice Assistant Katniss và cấp quyền Micro, Vị trí.
   - **[3/6]** Cài đặt TV Launcher, cấp quyền bảo mật `WRITE_SECURE_SETTINGS`, bộ nhớ, CPU/RAM.
   - **[4/6]** Cố định Role HOME mặc định và kích hoạt dịch vụ Voice Accessibility Service.
   - **[5/6]** Cài đặt múi giờ Việt Nam GMT+7 (`Asia/Ho_Chi_Minh`), tự động đồng bộ giờ qua mạng, cấu hình chống ROM Xiaomi kill Launcher khi tắt TV (STR standby) và giữ cố định cổng ADB 5555.
   - **[6/6]** Tự động vô hiệu hóa toàn bộ app rác, quảng cáo ngốn RAM (Debloat).
   - Tự động khởi chạy Launcher lên màn hình TV!

---

## 🎙️ 5. HƯỚNG DẪN ĐIỀU KHIỂN & TÌM KIẾM GIỌNG NÓI (VOICE SEARCH)

Sau khi cài đặt xong, TV của bạn đã được trang bị công cụ nhận diện giọng nói tiếng Việt chuẩn xác và thông minh nhất. Dưới đây là hướng dẫn cách sử dụng remote và các câu lệnh mẫu:

### 4.1. Cơ Chế Hoạt Động Của Trợ Lý Giọng Nói
Hệ thống điều khiển giọng nói trên TV Launcher phối hợp mượt mà giữa 3 thành phần:
1. **Google Katniss (Google Assistant trên TV):** Thu âm từ micro remote Bluetooth và chuyển âm thanh thành văn bản dạng **chuỗi thời gian thực (Real-time Streaming STT)**.
2. **`VoiceAccessibilityService` (Dịch vụ Trợ Năng nền):** Lắng nghe sự kiện văn bản xuất hiện trên màn hình Katniss, trích xuất câu lệnh thoại của người dùng ngay lập tức.
3. **`HomeActivity.handleVoiceQuery` (Bộ tiền xử lý Regex):** Chuẩn hóa văn bản tiếng Việt (loại bỏ dấu câu, chữ hoa, dấu chấm viết tắt), bóc tách số kênh hoặc tên ứng dụng để mở ngay lập tức mà không cần chờ Katniss tìm kiếm trên mạng.

### 4.2. Quy Tắc Phát Âm Vàng (Tránh Lỗi "Cướp Cò")
> [!IMPORTANT]
> **Nguyên tắc quan trọng nhất: NÓI DỨT KHOÁT — LIỀN MỘT MẠCH — KHÔNG NGẮT QUÃNG**

- **Nếu nói ngắt quãng:** *"Mở... VTV... [dừng 0.3s]... 1"*
  $\rightarrow$ Google Katniss sẽ đẩy chữ `"Mở VTV"` lên trước.
  $\rightarrow$ Launcher thấy chữ `"Mở VTV"` sẽ tưởng người dùng muốn mở ứng dụng **VTV Go** (trang chủ) nên lập tức kích hoạt app và đóng Mic!
  $\rightarrow$ Kết quả: Mở nhầm trang chủ VTV Go thay vì kênh VTV1.
- **Nếu nói liền mạch:** *"Mở VTV một"* hoặc *"Kênh 1"*
  $\rightarrow$ Văn bản được đẩy lên có đầy đủ cả tên và số kênh ngay từ frame đầu tiên $\rightarrow$ Mở thẳng kênh truyền hình VTV1 tức thì.

---

### 4.3. Bảng Cú Pháp Mở Kênh Truyền Hình VTV (Qua VTV Go)

Hệ thống hỗ trợ phát trực tiếp luồng truyền hình trực tuyến của Đài Truyền hình Việt Nam thông qua ứng dụng **VTV Go**.

#### Cú pháp Khuyên Dùng (Chuẩn 100% — Ngắn gọn, không bao giờ nhầm):
> **Cú pháp:** `"Kênh + [Số kênh]"` hoặc `"Mở kênh + [Số kênh]"`

| Kênh mong muốn | Cú pháp đọc chuẩn | Kênh ID VTV Go | Ghi chú nội dung |
| :--- | :--- | :--- | :--- |
| **VTV1** | *"Kênh 1"* hoặc *"Mở kênh một"* | `channelId=1` | Thời sự - Chính luận tổng hợp |
| **VTV2** | *"Kênh 2"* hoặc *"Mở kênh hai"* | `channelId=2` | Khoa học & Giáo dục |
| **VTV3** | *"Kênh 3"* hoặc *"Mở kênh ba"* | `channelId=3` | Thể thao & Giải trí |
| **VTV4** | *"Kênh 4"* hoặc *"Mở kênh bốn"* / *"Kênh tư"* | `channelId=4` | Kênh truyền hình Đối ngoại |
| **VTV5** | *"Kênh 5"* hoặc *"Mở kênh năm"* | `channelId=5` | Kênh tiếng Dân tộc thiểu số |
| **VTV6** | *"Kênh 6"* hoặc *"Mở kênh sáu"* | `channelId=13` | Kênh Thể thao / VTV Cần Thơ |
| **VTV7** | *"Kênh 7"* hoặc *"Mở kênh bảy"* | `channelId=27` | Kênh Truyền hình Giáo dục Quốc gia |
| **VTV8** | *"Kênh 8"* hoặc *"Mở kênh tám"* | `channelId=36` | Kênh khu vực Miền Trung - Tây Nguyên |
| **VTV9** | *"Kênh 9"* hoặc *"Mở kênh chín"* | `channelId=39` | Kênh khu vực Đông Nam Bộ |

*(Lưu ý: Hệ thống phát sóng Quốc gia VTV chỉ có từ **VTV1 đến VTV9**, không có kênh VTV10).*

#### Cú pháp đọc theo tên VTV (Cần đọc liền hơi):
> **Cú pháp:** `"Mở VTV [Số]"`, `"Xem VTV [Số]"`, `"VTV [Số]"` hoặc `"Mở VTV kênh [Số]"`
- *"Mở VTV một"* hoặc *"Mở VTV1"*
- *"Xem VTV hai"* hoặc *"VTV2"*
- *"Mở VTV ba"* hoặc *"VTV kênh 3"*
- *"Bật VTV sáu"* hoặc *"Xem VTV6"*
- *"Mở VTV chín"* hoặc *"VTV9"*

*(Hệ thống đã tự động lọc các trường hợp phiên âm dấu chấm `"V.T.V 1"`, gạch nối `"V-T-V 2"` về chuẩn).*

---

### 4.4. Bảng Cú Pháp Mở Nhanh Ứng Dụng (Quick App Launch)

Bạn có thể mở bất kỳ ứng dụng nào trên TV bằng giọng nói mà không cần di chuyển D-Pad trên remote:

> **Cú pháp chung:** `"[Mở / Bật / Vào / Chạy] + [Tên ứng dụng]"`

| Ứng dụng | Các cách đọc được hỗ trợ | Package Name kích hoạt |
| :--- | :--- | :--- |
| **YouTube** | *"Mở YouTube"*, *"Vào du túp"*, *"Bật du tub"*, *"Iu túp"*, *"U túp"* | `com.google.android.youtube.tv` |
| **VTV Go** | *"Mở VTV"*, *"Mở VTV Go"*, *"Vào vê tê vê"* | `vn.vtv.vtvgotv` |
| **FPT Play** | *"Mở FPT"*, *"Bật FPT Play"*, *"Vào ép pê tê"* | `com.fpt.play` |
| **TV360** | *"Mở TV360"*, *"Bật TV 360"*, *"Mở Viettel TV"* | `com.viettel.tv360.tv` |
| **VieON** | *"Mở VieON"*, *"Vào vi e on"*, *"Bật Vie ON"* | `com.vieon.tv` |
| **iQIYI** | *"Mở iQIYI"*, *"Vào ai ci di"*, *"Bật ai ki di"* | `com.iqiyi.i18n.tv` |
| **Cài đặt TV** | *"Mở cài đặt"*, *"Vào thiết lập"*, *"Settings"*, *"Cài đặt TV"* | `com.xiaomi.mitv.settings` |
| **Các ứng dụng khác** | *"Mở [Tên app hiển thị]"* (ví dụ: *"Mở AnExplorer"*, *"Mở Downloader"*) | Tự động quét theo Application Label |

---

### 4.5. Tìm Kiếm Nội Dung Video & Tra Cứu

Khi câu nói không khớp với lệnh mở kênh VTV hay mở ứng dụng, hệ thống sẽ tự động chuyển câu lệnh sang tính năng tìm kiếm nội dung:
1. **Tìm video YouTube:**
   - Cú pháp: *"Tìm kiếm [nội dung]"*, *"Karaoke [tên bài hát]"*, *"Phim [tên phim]"*.
   - Ví dụ: *"Karaoke Duyên Phận"*, *"Nhạc trẻ remix 2026"*, *"Hài Tết mới nhất"*.
   - Hệ thống tự động chuyển query sang ứng dụng YouTube TV chính thức để phát hoặc hiện danh sách video liên quan.
2. **Tìm kiếm tổng hợp:**
   - Trực tiếp hiển thị thẻ kết quả tìm kiếm của Google Assistant / Katniss.

---

### 4.6. Hướng Dẫn Thao Tác Remote Khi Dùng Giọng Nói

1. **Bấm nút Micro trên Remote Xiaomi:** Bấm **1 lần dứt khoát** vào nút có biểu tượng Micro (hoặc icon Google Assistant).
2. **Quan sát vạch trạng thái:** Khi dải 4 chấm màu Google (hoặc sóng âm) xuất hiện ở đáy màn hình và chuyển động nhấp nháy $\rightarrow$ Mic đã sẵn sàng thu âm.
3. **Phát âm câu lệnh:** Để remote cách miệng khoảng **10 - 15 cm**. Nói rõ ràng, tốc độ vừa phải, liền mạch (ví dụ: *"Kênh một"* hoặc *"Mở YouTube"*).
4. **Hệ thống phản hồi:** Ngay khi nhận diện xong, màn hình sẽ hiện thông báo nhẹ (ví dụ: `"Đang mở VTV1"` hoặc `"Đang mở ứng dụng"`) và tự động chuyển ngay sang nội dung yêu cầu trong vòng chưa đầy **0.5 giây**.

---

### 4.7. Khắc Phục Sự Cố Giọng Nói Thường Gặp

| Hiện tượng | Nguyên nhân | Cách xử lý |
| :--- | :--- | :--- |
| **Nói "Mở VTV1" nhưng lại vào trang chủ VTV Go** | Đọc ngắt quãng khiến Google nhận diện chữ "VTV" trước khi người dùng kịp nói số 1 | Chuyển sang đọc ngắn gọn: **"Kênh 1"** hoặc nói liền một hơi **"Mở VTV một"**. |
| **Bấm nút Micro không thấy TV phản hồi** | Remote Bluetooth bị mất kết nối hoặc pin yếu | Bấm đồng thời phím `Mi` + `Tròn` trên remote để ghép nối lại Bluetooth, hoặc thay pin mới. |
| **Hiện thông báo "Không có kết nối Internet"** | TV vừa bật từ chế độ nghỉ STR, card Wi-Fi chưa kịp nhận IP | Đợi 2-3 giây để biểu tượng Wi-Fi trên thanh trạng thái sáng rõ rồi bấm mic lại. |
| **Đọc tên app tiếng Anh TV không hiểu** | Google nhận diện sang phiên âm tiếng Việt | Dùng các từ phiên âm tiếng Việt đã hỗ trợ (ví dụ thay vì đọc "Settings" hãy đọc *"Mở cài đặt"*). |

---

## 🧹 6. Danh Sách Các Lệnh ADB Tắt Ứng Dụng Rác (Debloat RAM)

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

> **Ghi chú**: Lệnh `pm disable-user --user 0` là phương thức an toàn nhất trên Android. Nó đóng băng hoàn toàn ứng dụng khỏi bộ nhớ và không thể tự khởi chạy ngầm, nhưng không xóa file khỏi ROM hệ thống. Bạn có thể khôi phục lại bất cứ lúc nào bằng cách chạy file **`restore_bloatware.bat`**!

---

## ⚠️ 7. Các Ứng Dụng Hệ Thống TUYỆT ĐỐI KHÔNG ĐƯỢC TẮT

Không được tắt các package sau đây vì sẽ gây lỗi treo TV (bootloop) hoặc mất menu cài đặt:
- `com.xiaomi.mitv.settings` (Cài đặt hệ thống TV)
- `com.xiaomi.mitv.systemui` (Thanh trạng thái, hiển thị âm lượng)
- `com.xiaomi.mitv.tvmanager` (Quản lý phần cứng TV)
- `mitv.service` (Dịch vụ lõi phần cứng của Xiaomi MiTV)
- `com.xiaomi.setupwizard` (Trình thiết lập ban đầu)

---

## 🌟 8. Các Tính Năng Sau Khi Cài Đặt Thành Công

- **Mở máy là vào Launcher**: TV khởi động hoặc bật từ chế độ tắt bằng remote (STR sleep) đều vào thẳng Launcher ngay lập tức.
- **Phím HOME chuẩn 100%**: Bấm nút Home ở bất kỳ ứng dụng nào (YouTube, VTV Go, NetFlix, FPT Play...) đều quay về màn hình chính tức thì.
- **Nút Voice remote**: Bấm nút Micro trên Remote Xiaomi/Android TV sẽ kích hoạt Google Assistant Katniss tiếng Việt siêu nhạy.
- **Múi giờ chuẩn Việt Nam**: Tự động đặt múi giờ GMT+7 (`Asia/Ho_Chi_Minh`), không lo bị nhảy sang giờ Bắc Kinh Trung Quốc.
- **Bàn phím tiếng Việt**: Khi gõ tìm kiếm, bàn phím LeanKey tự mở to, dễ bấm bằng phím điều hướng remote.
- **Tiết kiệm RAM tối đa**: RAM trống thêm **300MB - 600MB**, CPU mát hơn và TV mượt mà hơn rất nhiều so với ROM gốc.
- **Đầy đủ Widget**: Thời tiết địa phương tự nhận diện, Lịch Âm ngày lễ Việt Nam, Bảng Giá Xăng Dầu Petrolimex và Bảng Giá Vàng SJC cập nhật trực tiếp theo thời gian thực.
- **Tùy biến sắp xếp ứng dụng**: Tự do đổi chỗ, đưa app lên đầu hàng trên dock ngang theo ý thích người dùng.
