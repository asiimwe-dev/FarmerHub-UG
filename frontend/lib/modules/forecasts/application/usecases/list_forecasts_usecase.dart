import '../../forecasts.dart';

class ListForecastsUseCase {
  const ListForecastsUseCase(this._repository);

  final ForecastRepository _repository;

  List<YieldForecast> call() {
    return _repository.list();
  }
}
