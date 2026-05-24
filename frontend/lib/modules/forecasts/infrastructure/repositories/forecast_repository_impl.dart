import '../../domain/entities/yield_forecast.dart';
import '../../domain/repositories/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  @override
  List<YieldForecast> list() {
    return [
      YieldForecast(
        zoneName: 'Mukono Cooperative Corridor',
        predictedVolumeTons: 1280.5,
        updatedAt: DateTime.now(),
      ),
      YieldForecast(
        zoneName: 'Mbale Highlands',
        predictedVolumeTons: 930.2,
        updatedAt: DateTime.now(),
      ),
    ];
  }
}
