/// Application-wide constants for Nelson Staff CRM.
class AppConstants {
  AppConstants._();

  static const String appName = 'Nelson Staff CRM';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int defaultPageSize = 20;
  static const int searchDebounceMs = 400;

  // Timeouts
  static const int connectionTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String currentShiftKey = 'current_shift';
  static const String environmentKey = 'environment';

  // Date formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'dd MMM yyyy, hh:mm a';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss";

  // Shift timings
  static const String morningShiftStart = '08:00';
  static const String morningShiftEnd = '16:00';
  static const String eveningShiftStart = '16:00';
  static const String eveningShiftEnd = '00:00';
  static const String nightShiftStart = '00:00';
  static const String nightShiftEnd = '08:00';
}
