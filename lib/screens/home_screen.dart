import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget_custom.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_detail_item.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<WeatherProvider>().refreshWeather(),
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.state == WeatherState.loading &&
                provider.currentWeather == null) {
              return const Center(child: LoadingShimmer());
            }

            if (provider.state == WeatherState.error &&
                provider.currentWeather == null) {
              return ErrorWidgetCustom(
                message: provider.errorMessage,
                onRetry: () =>
                    context.read<WeatherProvider>().fetchWeatherByLocation(),
              );
            }

            if (provider.currentWeather == null) {
              return const Center(child: Text('No weather data'));
            }

            final w = provider.currentWeather!;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CurrentWeatherCard(weather: w),

                  if (provider.isFromCache)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 8),
                      child: Text(
                        'Showing cached data (offline or previous error)',
                        style: TextStyle(
                          color: Colors.orange.shade200,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  HourlyForecastList(forecasts: provider.forecast),
                  DailyForecastSection(forecasts: provider.forecast),
                  WeatherDetailsSection(
                    humidity: w.humidity,
                    windSpeed: w.windSpeed,
                    pressure: w.pressure,
                    visibility: w.visibility,
                    cloudiness: w.cloudiness,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}
