# HƯỚNG DẪN ĐIỀU KHIỂN GIỌNG NÓI (VOICE SEARCH) — TV LAUNCHER

Tài liệu này hướng dẫn chi tiết cách phát âm, cú pháp câu lệnh và cơ chế hoạt động của tính năng tìm kiếm bằng giọng nói (**Voice Control Engine**) trên TV Launcher chạy ROM Xiaomi MiTV.

---

## 1. Cơ Chế Hoạt Động Của Trợ Lý Giọng Nói

Hệ thống điều khiển giọng nói trên TV Launcher hoạt động theo mô hình phối hợp giữa 3 thành phần:
1. **Google Katniss (Trợ lý giọng nói Google Assistant trên Android TV):** Thu âm từ micro remote Bluetooth và chuyển âm thanh thành văn bản dạng **chuỗi thời gian thực (Real-time Streaming STT)**.
2. **`VoiceAccessibilityService` (Dịch vụ Trợ Năng nền):** Lắng nghe sự kiện văn bản xuất hiện trên màn hình Katniss, trích xuất câu lệnh thoại của người dùng ngay lập tức.
3. **`HomeActivity.handleVoiceQuery` (Bộ tiền xử lý câu lệnh):** Chuẩn hóa văn bản tiếng Việt (loại bỏ dấu câu, chữ hoa, dấu chấm viết tắt), bóc tách số kênh hoặc tên ứng dụng thông qua Regex Engine để kích hoạt tác vụ đích mà không cần chờ Katniss tìm kiếm trên mạng.

---

## 2. Quy Tắc Phát Âm Vàng (Tránh Lỗi "Cướp Cò")

> [!IMPORTANT]
> **Nguyên tắc quan trọng nhất: NÓI DỨT KHOÁT — LIỀN MỘT MẠCH — KHÔNG NGẮT QUÃNG**

### Vì sao không được ngập ngừng?
Google Katniss stream từng từ người dùng vừa nói lên màn hình theo thời gian thực.
- **Nếu nói ngắt quãng:** *"Mở... VTV... [dừng 0.3s]... 1"*
  $\rightarrow$ Google Katniss sẽ đẩy chữ `"Mở VTV"` lên trước.
  $\rightarrow$ Launcher thấy chữ `"Mở VTV"` sẽ tưởng người dùng muốn mở ứng dụng **VTV Go** (trang chủ) nên lập tức kích hoạt app và bấm nút `Back` để đóng Mic!
  $\rightarrow$ Kết quả: Mở nhầm trang chủ VTV Go thay vì mở kênh VTV1.
- **Nếu nói liền mạch:** *"Mở VTV một"* hoặc *"Kênh 1"*
  $\rightarrow$ Text đẩy lên có đầy đủ cả tên kênh và số kênh ngay từ frame đầu tiên $\rightarrow$ Mở thẳng kênh truyền hình VTV1 tức thì.

---

## 3. Bảng Cú Pháp Mở Kênh Truyền Hình VTV (Qua VTV Go)

Hệ thống hỗ trợ phát trực tiếp luồng truyền hình trực tuyến của Đài Truyền hình Việt Nam thông qua ứng dụng **VTV Go**.

### 3.1. Cú pháp Khuyên Dùng (Chuẩn 100% — Ngắn gọn, không bao giờ nhầm)
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

### 3.2. Cú pháp đọc theo tên VTV (Cần đọc liền hơi)
> **Cú pháp:** `"Mở VTV [Số]"`, `"Xem VTV [Số]"`, `"VTV [Số]"` hoặc `"Mở VTV kênh [Số]"`

- *"Mở VTV một"* hoặc *"Mở VTV1"*
- *"Xem VTV hai"* hoặc *"VTV2"*
- *"Mở VTV ba"* hoặc *"VTV kênh 3"*
- *"Bật VTV sáu"* hoặc *"Xem VTV6"*
- *"Mở VTV chín"* hoặc *"VTV9"*

Hệ thống đã tự động nhận diện cả các trường hợp Google Assistant phiên âm dạng:
- Dấu chấm: `"V.T.V 1"`, `"V.T.V. 3"` $\rightarrow$ Tự chuẩn hóa về `vtv 1`, `vtv 3`.
- Gạch nối: `"V-T-V 2"` $\rightarrow$ Tự chuẩn hóa về `vtv 2`.
- Có chữ kênh ở giữa: `"VTV kênh 1"`, `"Mở VTV kênh 3"` $\rightarrow$ Bắt chính xác số kênh.

---

## 4. Bảng Cú Pháp Mở Nhanh Ứng Dụng (Quick App Launch)

Người dùng có thể mở bất kỳ ứng dụng nào cài đặt trên TV bằng giọng nói mà không cần di chuyển D-Pad trên remote.

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

## 5. Tìm Kiếm Nội Dung Video & Tra Cứu

Khi câu nói không khớp với lệnh mở kênh VTV hay lệnh mở ứng dụng, hệ thống sẽ tự động chuyển câu lệnh sang tính năng tìm kiếm nội dung:
1. **Tìm video YouTube:**
   - Cú pháp: *"Tìm kiếm [nội dung]"*, *"Karaoke [tên bài hát]"*, *"Phim [tên phim]"*.
   - Ví dụ: *"Karaoke Duyên Phận"*, *"Nhạc trẻ remix 2026"*, *"Hài Tết mới nhất"*.
   - Hệ thống tự động chuyển query sang ứng dụng YouTube TV chính thức để phát hoặc hiện danh sách video liên quan.
2. **Tìm kiếm tổng hợp:**
   - Trực tiếp hiển thị thẻ kết quả tìm kiếm của Google Assistant / Katniss.

---

## 6. Hướng Dẫn Thao Tác Remote Khi Dùng Giọng Nói

1. **Bấm nút Micro trên Remote Xiaomi:**
   - Bấm **1 lần dứt khoát** vào nút có biểu tượng Micro (hoặc icon Google Assistant).
2. **Quan sát vạch trạng thái:**
   - Khi dải 4 chấm màu Google (hoặc sóng âm) xuất hiện ở đáy màn hình và chuyển động nhấp nháy $\rightarrow$ Mic đã sẵn sàng thu âm.
3. **Phát âm câu lệnh:**
   - Để remote cách miệng khoảng **10 - 15 cm**.
   - Nói rõ ràng, tốc độ vừa phải, liền mạch (ví dụ: *"Kênh một"* hoặc *"Mở YouTube"*).
4. **Hệ thống phản hồi:**
   - Ngay khi nhận diện xong, màn hình sẽ hiện thông báo Toast nhẹ (ví dụ: `"Đang mở VTV1"` hoặc `"Đang mở ứng dụng"`) và tự động chuyển ngay sang nội dung yêu cầu trong vòng chưa đầy **0.5 giây**.

---

## 7. Khắc Phục Sự Cố Thường Gặp

| Hiện tượng | Nguyên nhân | Cách xử lý |
| :--- | :--- | :--- |
| **Nói "Mở VTV1" nhưng lại vào trang chủ VTV Go** | Đọc ngắt quãng khiến Google nhận diện chữ "VTV" trước khi người dùng kịp nói số 1 | Chuyển sang đọc ngắn gọn: **"Kênh 1"** hoặc nói liền một hơi **"Mở VTV một"**. |
| **Bấm nút Micro không thấy TV phản hồi** | Remote Bluetooth bị mất kết nối hoặc pin yếu | Bấm đồng thời phím `Mi` + `Tròn` trên remote để ghép nối lại Bluetooth, hoặc thay pin mới. |
| **Hiện thông báo "Không có kết nối Internet"** | TV vừa bật từ chế độ nghỉ STR, card Wi-Fi chưa kịp nhận IP | Đợi 2-3 giây để biểu tượng Wi-Fi trên thanh trạng thái sáng rõ rồi bấm mic lại. |
| **Đọc tên app tiếng Anh TV không hiểu** | Google nhận diện sang phiên âm tiếng Việt | Dùng các từ phiên âm tiếng Việt đã hỗ trợ (ví dụ thay vì đọc "Settings" hãy đọc *"Mở cài đặt"*). |

