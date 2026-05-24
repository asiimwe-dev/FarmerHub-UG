import '../../domain/entities/field_record.dart';
import '../../domain/repositories/field_capture_repository.dart';
import '../datasources/local_field_capture_datasource.dart';

class FieldCaptureRepositoryImpl implements FieldCaptureRepository {
  const FieldCaptureRepositoryImpl(this._localDataSource);

  final LocalFieldCaptureDataSource _localDataSource;

  @override
  List<FieldRecord> getPendingRecords() {
    return _localDataSource.readAll();
  }

  @override
  void save(FieldRecord record) {
    _localDataSource.save(record);
  }
}
