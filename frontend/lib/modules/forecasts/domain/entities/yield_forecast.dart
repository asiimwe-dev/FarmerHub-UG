import 'package:equatable/equatable.dart';

class YieldForecast extends Equatable {
  const YieldForecast({
    required this.zoneName,
    required this.predictedVolumeTons,
    required this.updatedAt,
  });

  final String zoneName;
  final double predictedVolumeTons;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [zoneName, predictedVolumeTons, updatedAt];
}
