import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }
enum WindSpeedUnit { ms, kmh, mph }
enum TimeFormatUnit { h24, h12 }

class SettingsProvider extends ChangeNotifier {
  static const _tempUnitKey = 'settings_temp_unit';
  static const _windUnitKey = 'settings_wind_unit';
  static const _timeFormatKey = 'settings_time_format';

  TemperatureUnit _temperatureUnit = TemperatureUnit.celsius;
  WindSpeedUnit _windSpeedUnit = WindSpeedUnit.mph;
  TimeFormatUnit _timeFormatUnit = TimeFormatUnit.h24;

  TemperatureUnit get temperatureUnit => _temperatureUnit;
  WindSpeedUnit get windSpeedUnit => _windSpeedUnit;
  TimeFormatUnit get timeFormatUnit => _timeFormatUnit;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _temperatureUnit = TemperatureUnit.values[
    prefs.getInt(_tempUnitKey) ?? TemperatureUnit.celsius.index];

    _windSpeedUnit = WindSpeedUnit.values[
    prefs.getInt(_windUnitKey) ?? WindSpeedUnit.ms.index]; // ✅ sửa mps → ms

    _timeFormatUnit = TimeFormatUnit.values[
    prefs.getInt(_timeFormatKey) ?? TimeFormatUnit.h24.index];

    notifyListeners();
  }


  Future<void> setTemperatureUnit(TemperatureUnit value) async {
    _temperatureUnit = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_tempUnitKey, value.index);
    notifyListeners();
  }

  Future<void> setWindSpeedUnit(WindSpeedUnit value) async {
    _windSpeedUnit = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_windUnitKey, value.index);
    notifyListeners();
  }

  Future<void> setTimeFormatUnit(TimeFormatUnit value) async {
    _timeFormatUnit = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_timeFormatKey, value.index);
    notifyListeners();
  }

  // ---- Helpers dùng trong UI ----

  String formatTemperature(double celsius) {
    switch (_temperatureUnit) {
      case TemperatureUnit.celsius:
        return '${celsius.round()}°C';
      case TemperatureUnit.fahrenheit:
        final f = celsius * 9 / 5 + 32;
        return '${f.round()}°F';
    }
  }

  String formatFeelsLike(double celsius) => formatTemperature(celsius);

  String formatWindSpeed(double metersPerSecond) {
    switch (_windSpeedUnit) {
      case WindSpeedUnit.ms:
        return '${metersPerSecond.toStringAsFixed(1)} m/s';
      case WindSpeedUnit.kmh:
        final kmh = metersPerSecond * 3.6;
        return '${kmh.toStringAsFixed(1)} km/h';
      case WindSpeedUnit.mph:
        final mph = metersPerSecond * 2.23694;
        return '${mph.toStringAsFixed(1)} mph';
    }
  }

  /// timeString là dạng "HH:mm" hoặc "HH:mm:ss", bạn có thể dùng dần
  String formatTime(DateTime time) {
    if (_timeFormatUnit == TimeFormatUnit.h24) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      int hour = time.hour;
      final suffix = hour >= 12 ? 'PM' : 'AM';
      if (hour == 0) hour = 12;
      if (hour > 12) hour -= 12;
      return '$hour:${time.minute.toString().padLeft(2, '0')} $suffix';
    }
  }
}
