// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  static const String appName = 'Arogya SMC';
  static const String appTagline = 'Your Health, Our Priority';
  static const String appVersion = '1.0.0';
  static const String corporationName = 'Solapur Municipal Corporation';

  // API backend (Android emulator uses 10.0.2.2 for host loopback)
  static const String apiBaseUrl = 'http://localhost:3000/api/public';
  static const String facilitiesEndpoint = '/facilities';
  static const String advisoriesEndpoint = '/advisories';
  static const String alertsEndpoint = '/alerts';
  static const String wardsEndpoint = '/wards';

  // Hive boxes
  static const String hospitalsBox = 'hospitals_box';
  static const String settingsBox = 'settings_box';
  static const String alertsBox = 'alerts_box';
  static const String advisoriesBox = 'advisories_box';

  // Cache duration in minutes
  static const int cacheDurationMinutes = 30;

  // Route names
  static const String splashRoute = '/';
  static const String welcomeRoute = '/welcome';
  static const String homeRoute = '/home';
  static const String hospitalsRoute = '/hospitals';
  static const String hospitalDetailRoute = '/hospital-detail';
  static const String alertsRoute = '/alerts';
  static const String profileRoute = '/profile';

  // Solapur bounding box (for location validation)
  static const double solapurLatMin = 17.60;
  static const double solapurLatMax = 17.75;
  static const double solapurLngMin = 75.85;
  static const double solapurLngMax = 75.98;
}
