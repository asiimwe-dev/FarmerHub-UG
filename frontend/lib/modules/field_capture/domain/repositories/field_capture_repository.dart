import '../entities/field_record.dart';

abstract class FieldCaptureRepository {
  void save(FieldRecord record);
  List<FieldRecord> getPendingRecords();
}
