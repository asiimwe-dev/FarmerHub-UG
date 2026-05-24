import '../entities/batch_record.dart';

abstract class TraceabilityRepository {
  void create(BatchRecord record);
  List<BatchRecord> all();
}
