import '../entities/yield_forecast.dart';

abstract class ForecastRepository {
  List<YieldForecast> list();
}
