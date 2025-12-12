import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  WeatherModel? _currentWeather;
  List<ForecastModel> _forecast = [];
  WeatherState _state = WeatherState.initial;
  String _errorMessage = '';

  // Favorites & history
  List<String> _favoriteCities = [];
  List<String> _searchHistory = [];

  // Cache info
  bool _isFromCache = false;
  DateTime? _lastUpdate;

  WeatherProvider(
      this._weatherService,
      this._locationService,
      this._storageService,
      );

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  WeatherState get state => _state;
  String get errorMessage => _errorMessage;

  List<String> get favoriteCities => _favoriteCities;
  List<String> get searchHistory => _searchHistory;

  bool get isFromCache => _isFromCache;
  DateTime? get lastUpdate => _lastUpdate;

  Future<void> loadSavedCitiesAndHistory() async {
    _favoriteCities = await _storageService.getFavoriteCities();
    _searchHistory = await _storageService.getSearchHistory();
    notifyListeners();
  }

  Future<void> toggleFavoriteCity(String city) async {
    final normalized = city.trim();
    if (normalized.isEmpty) return;

    if (_favoriteCities.contains(normalized)) {
      _favoriteCities.remove(normalized);
    } else {
      if (_favoriteCities.length >= 5) {
        _favoriteCities.removeAt(0);
      }
      _favoriteCities.add(normalized);
    }
    await _storageService.saveFavoriteCities(_favoriteCities);
    notifyListeners();
  }

  bool isFavorite(String city) => _favoriteCities.contains(city.trim());

  Future<void> _addToSearchHistory(String city) async {
    final normalized = city.trim();
    if (normalized.isEmpty) return;

    _searchHistory.remove(normalized);
    _searchHistory.insert(0, normalized);
    if (_searchHistory.length > 10) {
      _searchHistory = _searchHistory.sublist(0, 10);
    }
    await _storageService.saveSearchHistory(_searchHistory);
    notifyListeners();
  }

  // --------- FETCH WEATHER ----------

  Future<void> fetchWeatherByCity(String cityName) async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      _currentWeather =
      await _weatherService.getCurrentWeatherByCity(cityName);
      _forecast = await _weatherService.getForecast(cityName);

      await _storageService.saveWeatherData(_currentWeather!);
      _lastUpdate = DateTime.now();
      _isFromCache = false;

      await _addToSearchHistory(_currentWeather!.cityName);

      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentLocation();
      _currentWeather = await _weatherService.getCurrentWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      final cityName = await _locationService.getCityName(
        position.latitude,
        position.longitude,
      );

      _forecast = await _weatherService.getForecast(cityName);

      await _storageService.saveWeatherData(_currentWeather!);
      _lastUpdate = DateTime.now();
      _isFromCache = false;

      await _addToSearchHistory(cityName);

      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();

      await loadCachedWeather();
    }

    notifyListeners();
  }

  Future<void> loadCachedWeather() async {
    final cachedWeather = await _storageService.getCachedWeather();
    if (cachedWeather != null) {
      _currentWeather = cachedWeather;
      _lastUpdate = await _storageService.getLastUpdateTime();
      _isFromCache = true;
      _state = WeatherState.loaded;
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_currentWeather != null) {
      await fetchWeatherByCity(_currentWeather!.cityName);
    } else {
      await fetchWeatherByLocation();
    }
  }
}
