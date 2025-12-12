🌤 Ứng dụng Thời Tiết Flutter – thoitietapp

Ứng dụng Flutter hiển thị thời tiết theo thời gian thực sử dụng API của OpenWeatherMap.
Hỗ trợ xem thời tiết hiện tại, dự báo 5 ngày, dự báo theo giờ, tìm kiếm thành phố, lưu yêu thích, định vị GPS, làm việc offline và tùy chọn đơn vị đo (°C/°F, m/s – km/h – mph, 12h/24h).

Ứng dụng được phát triển theo yêu cầu bài thực hành Chapter 4 – Weather Application with API Integration.

✨ Tính năng chính
🏙 Thời tiết hiện tại

Nhiệt độ & cảm giác như

Trạng thái thời tiết + icon

Thành phố, quốc gia

Thời gian, ngày tháng

Độ ẩm, áp suất, tầm nhìn, tốc độ gió

📅 Dự báo thời tiết

Dự báo theo giờ (24 giờ)

Dự báo 5 ngày

Nhiệt độ min – max

Mô tả thời tiết

Tốc độ gió theo từng giờ/ngày

📍 Định vị & vị trí người dùng

Lấy vị trí GPS tự động

Hiển thị thời tiết đúng địa phương

Xử lý quyền truy cập vị trí (grant / deny / deny forever)

Tự động fallback sang chế độ tìm kiếm nếu không cấp quyền

🔍 Tìm kiếm thành phố

Tìm theo tên thành phố

Lượt tìm gần đây

Lưu thành phố yêu thích (tối đa 5)

Nhấn để xem lại nhanh

📡 Hoạt động ngoại tuyến (Offline)

Lưu cache thời tiết cuối cùng

Sử dụng dữ liệu cũ khi:

Mất mạng

API trả lỗi

Hết giới hạn API

Hiển thị thông báo “Đang dùng dữ liệu cũ”

🔧 Cài đặt (Settings)

Người dùng có thể tùy chỉnh:

Đơn vị nhiệt độ

°C – Celsius

°F – Fahrenheit

Đơn vị tốc độ gió

m/s

km/h

mph

Định dạng thời gian

24h

12h (AM/PM)

Toàn bộ cài đặt được lưu bằng SharedPreferences.

🎨 Giao diện động theo thời tiết

BG gradient thay đổi tùy theo:

Trời nắng

Mây nhiều

Trời mưa

Buổi tối

Shimmer loading khi tải dữ liệu

Dark theme thẩm mỹ, chữ sáng dễ đọc

🗂 Cấu trúc thư mục dự án
lib/
main.dart

config/
api_config.dart

models/
weather_model.dart
forecast_model.dart

services/
weather_service.dart
location_service.dart
storage_service.dart

providers/
weather_provider.dart
settings_provider.dart

screens/
home_screen.dart
search_screen.dart
settings_screen.dart

widgets/
current_weather_card.dart
hourly_forecast_list.dart
daily_forecast_card.dart
weather_detail_item.dart
loading_shimmer.dart
error_widget_custom.dart

🔑 Thiết lập API (OpenWeatherMap)

Ứng dụng sử dụng API miễn phí từ OpenWeatherMap.

Cách tạo API Key:

Vào https://openweathermap.org/api

Tạo tài khoản → lấy API key

Tạo file .env trong thư mục gốc:

OPENWEATHER_API_KEY=YOUR_API_KEY_HERE


Đảm bảo file .env KHÔNG được đưa lên GitHub:

Trong .gitignore:

.env
*.env

▶️ Cách chạy ứng dụng
1. Clone project:
   git clone https://github.com/[username]/flutter_weather_app_[yourname].git
   cd flutter_weather_app_[yourname]

2. Cài đặt package:
   flutter pub get

3. Tạo file .env:
   cp .env.example .env


Sau đó dán API key vào .env.

4. Chạy ứng dụng:
   flutter run


Hoặc chọn Run trong VSCode / Android Studio.

🛠 Công nghệ sử dụng

Flutter & Dart

Provider (quản lý trạng thái)

OpenWeatherMap API

SharedPreferences

Geolocator & Geocoding

HTTP client (http package)

CachedNetworkImage

flutter_dotenv

intl

📸 Ảnh màn hình ứng dụng (Screenshots)

Lưu tất cả ảnh vào thư mục /screenshots trước khi nộp.

Màn hình chính – Trời nắng

Màn hình chính – Trời mưa

Màn hình chính – Trời nhiều mây

Màn hình ban đêm

Màn hình tìm kiếm

Màn hình cài đặt

Màn hình lỗi (Error)

Màn hình loading (Shimmer)

(Thay bằng hình thực tế của bạn sau khi chạy app)

⚠️ Giới hạn hiện tại

Chưa hỗ trợ cảnh báo thời tiết (Weather Alerts)

Chưa tích hợp bản đồ thời tiết (Radar map)

Chưa có widget màn hình chính (Android/iOS)

Chưa hỗ trợ đa ngôn ngữ

Dự báo dài hạn (7–14 ngày) chưa có

🚀 Hướng phát triển trong tương lai

Tích hợp Air Quality Index (AQI)

Thêm Weather Alerts (cảnh báo mưa bão)

Thêm biểu đồ nhiệt độ / mưa trực quan

Widget home screen

Hỗ trợ đa ngôn ngữ (VN/EN)

Fallback API thứ 2 khi hết giới hạn OpenWeatherMap

Tối ưu hiệu năng và caching

🧪 Kiểm thử (Testing)
Kiểm thử thủ công:

Mạng ổn định → tải thời tiết bình thường

Không có mạng → dùng dữ liệu cache

Tắt GPS → buộc chuyển sang tìm kiếm bằng tay

Sai tên thành phố → hiển thị lỗi

Thay đổi đơn vị đo trong Settings → cập nhật toàn app

Kéo để refresh → tải lại dữ liệu

Kiểm thử đơn vị (Unit Test – ví dụ):
test('Parse WeatherModel JSON', () {
final json = {
"name": "Ho Chi Minh City",
"sys": {"country": "VN"},
"main": {
"temp": 30.0,
"feels_like": 32.0,
"humidity": 70
},
"weather": [
{"description": "clear sky", "icon": "01d", "main": "Clear"}
],
"wind": {"speed": 3.5},
"dt": 1700000000
};

final model = WeatherModel.fromJson(json);
expect(model.cityName, "Ho Chi Minh City");
expect(model.temperature, 30.0);
});

📌 Thông tin sinh viên

Họ tên: [Lê Xuân Trường]

MSSV: [2224801030263]

Lớp: [d22ktpm01]

Bài thực hành: Chapter 4 – Weather App

Đã xóa thư mục build/, .dart_tool/, Pods/

Có thư mục screenshots/ đầy đủ hình

README.md hoàn chỉnh

API key sử dụng: OpenWeatherMap

Các tính năng đã làm:

Thời tiết hiện tại

Dự báo theo giờ & 5 ngày

Tìm kiếm, lưu lịch sử

Yêu thích

Cài đặt đơn vị đo

Offline cache

Dark theme + UI động

Đã kiểm thử thủ công trên Android