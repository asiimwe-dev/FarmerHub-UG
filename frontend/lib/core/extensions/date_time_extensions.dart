/// Utility extensions for DateTime operations
extension DateTimeExtensions on DateTime {
  /// Format date as 'dd/MM/yyyy'
  String formatDate() => '$day/${month.toString().padLeft(2, '0')}/$year';
  
  /// Format time as 'HH:mm'
  String formatTime() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  
  /// Format as 'dd/MM/yyyy HH:mm'
  String formatDateTime() => '${formatDate()} ${formatTime()}';
  
  /// Get time ago description (e.g., '2 hours ago')
  String timeAgo() {
    final now = DateTime.now();
    final diff = now.difference(this);
    
    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else {
      return formatDate();
    }
  }
  
  /// Check if date is today
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
