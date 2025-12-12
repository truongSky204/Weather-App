import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Endpoints
  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';
  static const String oneCall = '/onecall';

  static String get _apiKey =>
      dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  static String buildUrl(String endpoint, Map<String, dynamic> params) {
    if (_apiKey.isEmpty) {
      throw Exception('OPENWEATHER_API_KEY is missing in .env');
    }

    params['appid'] = _apiKey;
    params['units'] = 'metric';
    final uri = Uri.parse('$baseUrl$endpoint');
    return uri.replace(queryParameters: params).toString();
  }
}
