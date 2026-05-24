import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/repositories/forecast_repository_impl.dart';

class ForecastsPage extends StatelessWidget {
  const ForecastsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecasts = ForecastRepositoryImpl().list();
    final formatter = NumberFormat.compact();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Forecast Intelligence',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Early yield visibility for cooperative planning and buyer commitments.',
        ),
        const SizedBox(height: 16),
        ...forecasts.map(
          (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: Text(item.zoneName),
              subtitle: Text(
                'Projected volume: ${formatter.format(item.predictedVolumeTons)} tons',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
