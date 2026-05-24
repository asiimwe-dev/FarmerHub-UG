import '../infrastructure/sync_queue_service.dart';

class SyncCoordinator {
  SyncCoordinator(this._queueService);

  final SyncQueueService _queueService;

  int get pending => _queueService.pendingJobs;
}
