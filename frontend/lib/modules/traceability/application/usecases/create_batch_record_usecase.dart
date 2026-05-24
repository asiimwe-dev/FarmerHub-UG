import '../../traceability.dart';

class CreateBatchRecordUseCase {
  const CreateBatchRecordUseCase(this._repository);

  final TraceabilityRepository _repository;

  void call(BatchRecord record) {
    _repository.create(record);
  }
}
