class SyncQueueService {
  int _pendingJobs = 0;

  int get pendingJobs => _pendingJobs;

  void enqueue() {
    _pendingJobs++;
  }

  void completeOne() {
    if (_pendingJobs > 0) {
      _pendingJobs--;
    }
  }
}
