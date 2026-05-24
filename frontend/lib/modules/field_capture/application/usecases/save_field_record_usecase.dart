import '../../field_capture.dart';

class SaveFieldRecordUseCase {
  const SaveFieldRecordUseCase(this._repository);

  final FieldCaptureRepository _repository;

  void call(FieldRecord record) {
    _repository.save(record);
  }
}
