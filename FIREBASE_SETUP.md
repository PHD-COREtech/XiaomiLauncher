# Hướng Dẫn Thiết Lập Firebase Realtime Database Cho RemoteTV

Tài liệu này hướng dẫn cách tạo một cơ sở dữ liệu **Firebase Realtime Database (Hoàn toàn Miễn phí - 0đ)** để lấy **URL Database** và **Secret Key** kết nối với ứng dụng **RemoteTV** điều khiển Smart TV qua Internet.

---

## 1. Tổng Quan Về Chi Phí & Định Mức Miễn Phí
Firebase là dịch vụ điện toán đám mây của **Google**. Gói miễn phí (**Spark Plan**) cung cấp:
- **Chi phí:** 0đ vĩnh viễn (Không cần thẻ tín dụng / Visa).
- **Kết nối đồng thời:** Tối đa 100 thiết bị cùng lúc (gia đình chỉ dùng 2-4 thiết bị $\rightarrow$ Dư 96%).
- **Dung lượng lưu trữ:** 1 GB (Ứng dụng RemoteTV chỉ lưu ~100 bytes $\rightarrow$ Dùng chưa tới 0.0001%).
- **Băng thông:** 10 GB / tháng (Cả tháng sử dụng chỉ tốn ~5-10 MB).

---

## 2. Các Bước Thiết Lập (Mất khoảng 2 phút)

### Bước 1: Tạo Dự Án Firebase Mới
1. Dùng trình duyệt web truy cập vào: [https://console.firebase.google.com/](https://console.firebase.google.com/)
2. Đăng nhập bằng tài khoản **Gmail** của bạn.
3. Bấm vào nút **`+ Thêm dự án`** (hoặc **`Add project`**).
4. Đặt tên dự án (ví dụ: `my-remote-tv` hoặc `tivi-nha-toi`) $\rightarrow$ Bấm **Tiếp tục**.
5. Mục *Google Analytics*: Chọn **Tắt** (Disable) cho nhanh $\rightarrow$ Bấm **Tạo dự án** (Create project).
6. Chờ vài giây tạo xong $\rightarrow$ Bấm **Tiếp tục**.

---

### Bước 2: Tạo Realtime Database
1. Ở thanh menu bên trái, tìm mục **Xây dựng** (Build) $\rightarrow$ Chọn **Realtime Database**.
2. Bấm vào nút **Tạo cơ sở dữ liệu** (Create Database).
3. **Chọn vị trí lưu trữ (Location):**
   > [!TIP]
   > Hãy chọn **`Singapore (asia-southeast1)`** để có tốc độ phản hồi nhanh nhất và độ trễ thấp nhất từ Việt Nam (< 30ms).
4. Bấm **Tiếp theo** (Next).
5. **Quy tắc bảo mật (Security rules):**
   - Chọn **Bắt đầu ở chế độ thử nghiệm** (Start in test mode).
   - Bấm **Bật** (Enable).

---

### Bước 3: Lấy Đường Dẫn Database (Firebase URL)
Ngay sau khi tạo xong, bạn sẽ thấy giao diện Database. Ở tab **Dữ liệu** (Data), bạn sẽ thấy một đường link màu đen ở trên cùng.
- Đường link có dạng:
  ```text
  https://ten-du-an-cua-ban-default-rtdb.asia-southeast1.firebasedatabase.app/
  ```
- 👉 **Bấm vào biểu tượng Copy bên cạnh đường link này** (đây chính là **Firebase URL** cần nhập vào app).

---

### Bước 4: Lấy Khóa Bí Mật (Database Secret Key)
Khóa bí mật dùng để xác thực ứng dụng điện thoại và TV kết nối an toàn với Database của bạn:
1. Nhìn lên góc trên bên trái, bấm vào biểu tượng bánh răng **⚙️ (Cài đặt dự án / Project Settings)**.
2. Chuyển sang tab **Tài khoản dịch vụ** (Service accounts).
3. Ở cột bên trái của tab này, bấm chọn mục **Khóa bí mật của cơ sở dữ liệu** (Database secrets).
4. Bạn sẽ thấy một dòng khóa bí mật bị ẩn $\rightarrow$ Rê chuột vào và bấm nút **Hiển thị** (Show).
5. Bấm **Sao chép** (Copy) chuỗi ký tự đó (đây chính là **Secret Key**).

---

## 3. Nhập Cấu Hình Vào Ứng Dụng RemoteTV

1. Mở ứng dụng **RemoteTV** trên điện thoại.
2. Ở góc trên bên phải, bấm vào nút **CÀI ĐẶT ⚙️**.
3. Dán thông tin vừa lấy được vào 2 ô:
   - **Firebase Database URL:** Dán đường link ở **Bước 3**.
   - **Database Secret Key:** Dán chuỗi mã ở **Bước 4**.
4. Bấm **LƯU CẤU HÌNH CLOUD**.
5. Nhìn xuống dòng trạng thái dưới cùng màn hình: Nếu hiện `🌐 Chế độ Cloud sẵn sàng` hoặc `🟢 TV đang Online trên Cloud` là bạn đã kết nối thành công 100%!

---

## 4. Cấu Hình Cho Smart TV (Khi cài đặt lần đầu)
File APK trên Smart TV (`tvlauncher.apk`) sẽ kết nối vào cùng Database này để nhận lệnh:
- Lệnh từ điện thoại sẽ được gửi lên Cloud trong **0.1 giây**.
- TV tự động nhận lệnh qua cơ chế Server-Sent Events (SSE) và thực thi tắt TV, hẹn giờ tắt hoặc chỉnh âm lượng tức thì dù bạn đang ở cơ quan, quán cafe hay dùng mạng 4G.

