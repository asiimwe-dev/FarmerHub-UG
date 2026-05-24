/// Utility extensions for String operations
extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
  
  /// Check if string is valid email
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
  
  /// Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
  
  /// Remove extra whitespace
  String normalizeWhitespace() {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
