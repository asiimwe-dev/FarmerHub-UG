import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/usecases/save_field_record_usecase.dart';
import 'domain/repositories/field_capture_repository.dart';
import 'infrastructure/datasources/local_field_capture_datasource.dart';
import 'infrastructure/repositories/field_capture_repository_impl.dart';

final localFieldCaptureDataSourceProvider =
    Provider<LocalFieldCaptureDataSource>((ref) {
  return LocalFieldCaptureDataSource();
});

final fieldCaptureRepositoryProvider = Provider<FieldCaptureRepository>((ref) {
  return FieldCaptureRepositoryImpl(ref.watch(localFieldCaptureDataSourceProvider));
});

final saveFieldRecordUseCaseProvider = Provider<SaveFieldRecordUseCase>((ref) {
  return SaveFieldRecordUseCase(ref.watch(fieldCaptureRepositoryProvider));
});
