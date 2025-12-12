import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/forecast_model.dart';

class DailyForecastSection extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const DailyForecastSection({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    if (forecasts.isEmpty) return const SizedBox.shrink();

    // group theo ngày đơn giản: lấy mỗi 8 bản ghi ~ 1 ngày
    final days = <ForecastModel>[];
    for (int i = 0; i < forecasts.length; i += 8) {
      days.add(forecasts[i]);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '5-day forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...days.map(
                (f) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                title: Text(DateFormat('EEE, MMM d').format(f.dateTime)),
                subtitle: Text(f.description),
                trailing: Text(
                    '${f.tempMin.round()}° / ${f.tempMax.round()}°'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
