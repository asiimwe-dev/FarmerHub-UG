import 'package:equatable/equatable.dart';

class BatchRecord extends Equatable {
  const BatchRecord({
    required this.batchId,
    required this.cooperativeName,
    required this.provenanceArea,
    required this.createdAt,
  });

  final String batchId;
  final String cooperativeName;
  final String provenanceArea;
  final DateTime createdAt;

  @override
  List<Object?> get props => [batchId, cooperativeName, provenanceArea, createdAt];
}
