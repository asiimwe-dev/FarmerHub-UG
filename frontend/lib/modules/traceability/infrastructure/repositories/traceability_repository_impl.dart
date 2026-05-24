import '../../domain/entities/batch_record.dart';
import '../../domain/repositories/traceability_repository.dart';

class TraceabilityRepositoryImpl implements TraceabilityRepository {
  final List<BatchRecord> _records = [];

  @override
  List<BatchRecord> all() {
    return List.unmodifiable(_records);
  }

  @override
  void create(BatchRecord record) {
    _records.add(record);
  }
}
