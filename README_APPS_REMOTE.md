# RemoteTV — Phone App for Xiaomi MiTV

## 1. Mục đích
Ứng dụng Android điều khiển và quản lý Smart TV từ xa qua 2 chế độ:
- **Cloud Internet (Firebase Realtime DB):** Điều khiển từ xa qua 4G (công ty -> TV ở nhà).
- **Mạng nội bộ (LAN):** Điều khiển qua Wi-Fi gia đình bằng ADB.

## 2. Các chức năng chính
- Cài đặt thời gian giới hạn xem TV (TV tự động đếm ngược và tắt màn hình khi hết giờ).
- Tắt TV từ xa tức thì.
- Tăng / giảm âm lượng TV.
- Quét tìm IP TV trong mạng LAN.
- Tự do nhập cấu hình Firebase URL & Secret Key riêng trong mục **Cài Đặt** (Xem hướng dẫn chi tiết tại [FIREBASE_SETUP.md](FIREBASE_SETUP.md)).
