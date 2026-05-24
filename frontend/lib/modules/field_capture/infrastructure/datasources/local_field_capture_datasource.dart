import '../../domain/entities/field_record.dart';

class LocalFieldCaptureDataSource {
  final List<FieldRecord> _records = [];

  void save(FieldRecord record) {
    _records.add(record);
  }

  List<FieldRecord> readAll() {
    return List.unmodifiable(_records);
  }
}
