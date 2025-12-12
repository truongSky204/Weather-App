import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class WeatherDetailsSection extends StatelessWidget {
  final int humidity;
  final double windSpeed; // m/s
  final int pressure;
  final int? visibility;
  final int? cloudiness;

  const WeatherDetailsSection({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    this.visibility,
    this.cloudiness,
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              _item('Humidity', '$humidity%'),
              _item('Wind', settings.formatWindSpeed(windSpeed)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _item('Pressure', '$pressure hPa'),
              _item(
                'Visibility',
                visibility != null ? '${visibility! ~/ 1000} km' : '--',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _item(
                  'Cloudiness', cloudiness != null ? '$cloudiness%' : '--'),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
