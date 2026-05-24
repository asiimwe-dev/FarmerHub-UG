/// Application configuration for different environments
enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  static const String appName = 'Farmer Hub UG';
  static const String appVersion = '1.0.0';
  
  static late AppEnvironment environment;
  
  // API endpoints - environment-specific
  static String get apiBaseUrl {
    return switch (environment) {
      AppEnvironment.development => 'http://localhost:8000/api',
      AppEnvironment.staging => 'https://staging.farmerhub.example.com/api',
      AppEnvironment.production => 'https://api.farmerhub.ug/api',
    };
  }
  
  // Debug logging enabled
  static bool get isDebug {
    return environment == AppEnvironment.development;
  }
  
  // Initialize config for environment
  static void init(AppEnvironment env) {
    environment = env;
  }
}
