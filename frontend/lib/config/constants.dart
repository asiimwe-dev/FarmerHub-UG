/// Application-wide constants for FarmCom Core
class AppConstants {
  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration syncTimeout = Duration(seconds: 60);
  static const Duration offlineMessageTimeout = Duration(seconds: 5);

  // Field validation rules
  static const int minFieldNameLength = 2;
  static const int maxFieldNameLength = 100;
  static const double minFieldAreaHectares = 0.01;
  static const double maxFieldAreaHectares = 10000;
  
  // Crop validation rules
  static const List<String> supportedCrops = [
    'Maize',
    'Beans',
    'Coffee',
    'Cotton',
    'Cassava',
    'Banana',
    'Rice',
    'Wheat',
    'Sorghum',
  ];
  
  // Yield measurement units
  static const List<String> yieldUnits = [
    'kg/ha',
    'bags/ha',
    'tons/ha',
  ];
  
  // Sync configuration
  static const int maxSyncQueueSize = 1000;
  static const Duration syncRetryInterval = Duration(seconds: 30);
  static const int maxSyncRetries = 3;
  
  // Local storage
  static const String dbFileName = 'farmerhub.db';
  static const int dbVersion = 1;
  
  // UI
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const int itemsPerPage = 20;
}
