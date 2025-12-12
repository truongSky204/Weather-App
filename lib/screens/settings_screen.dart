import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Temperature unit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<TemperatureUnit>(
            title: const Text('Celsius (°C)'),
            value: TemperatureUnit.celsius,
            groupValue: settings.temperatureUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setTemperatureUnit(v);
              }
            },
          ),
          RadioListTile<TemperatureUnit>(
            title: const Text('Fahrenheit (°F)'),
            value: TemperatureUnit.fahrenheit,
            groupValue: settings.temperatureUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setTemperatureUnit(v);
              }
            },
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          const Text(
            'Wind speed unit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<WindSpeedUnit>(
            title: const Text('Meters per second (m/s)'),
            value: WindSpeedUnit.ms,
            groupValue: settings.windSpeedUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setWindSpeedUnit(v);
              }
            },
          ),
          RadioListTile<WindSpeedUnit>(
            title: const Text('Kilometers per hour (km/h)'),
            value: WindSpeedUnit.kmh,
            groupValue: settings.windSpeedUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setWindSpeedUnit(v);
              }
            },
          ),
          RadioListTile<WindSpeedUnit>(
            title: const Text('Miles per hour (mph)'),
            value: WindSpeedUnit.mph,
            groupValue: settings.windSpeedUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setWindSpeedUnit(v);
              }
            },
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          const Text(
            'Time format',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<TimeFormatUnit>(
            title: const Text('24-hour format'),
            value: TimeFormatUnit.h24,
            groupValue: settings.timeFormatUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setTimeFormatUnit(v);
              }
            },
          ),
          RadioListTile<TimeFormatUnit>(
            title: const Text('12-hour format (AM/PM)'),
            value: TimeFormatUnit.h12,
            groupValue: settings.timeFormatUnit,
            onChanged: (v) {
              if (v != null) {
                context.read<SettingsProvider>().setTimeFormatUnit(v);
              }
            },
          ),

          const SizedBox(height: 32),
          const Text(
            'Note:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            '- Units are applied when displaying temperatures and wind speed.\n'
                '- Time format can be used for hourly forecast, sunrise/sunset, etc.',
          ),
        ],
      ),
    );
  }
}
