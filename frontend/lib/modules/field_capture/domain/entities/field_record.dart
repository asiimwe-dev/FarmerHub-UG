import 'package:equatable/equatable.dart';

class FieldRecord extends Equatable {
  const FieldRecord({
    required this.id,
    required this.farmerName,
    required this.cropType,
    required this.acreageHectares,
    required this.plantDensityIndex,
    required this.recordedAt,
  });

  final String id;
  final String farmerName;
  final String cropType;
  final double acreageHectares;
  final double plantDensityIndex;
  final DateTime recordedAt;

  @override
  List<Object?> get props => [
        id,
        farmerName,
        cropType,
        acreageHectares,
        plantDensityIndex,
        recordedAt,
      ];
}
