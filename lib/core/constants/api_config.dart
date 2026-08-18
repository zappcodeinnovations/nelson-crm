/// API configuration with environment support.
///
/// Use `--dart-define=API_ENV=development` to switch environments.
class ApiConfig {
  ApiConfig._();

  static const String _envKey = String.fromEnvironment(
    'API_ENV',
    defaultValue: 'development',
  );

  static String get baseUrl {
    switch (_envKey) {
      case 'production':
        return const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.nelsonhospitals.com/v1',
        );
      case 'staging':
        return const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://staging-api.nelsonhospitals.com/v1',
        );
      case 'development':
      default:
        return const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://143.244.143.84/v1',
        );
    }
  }

  static bool get isMockMode {
    return const String.fromEnvironment('USE_MOCK', defaultValue: 'true') ==
        'true';
  }

  static String get environment => _envKey;

  // API Endpoints
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';

  static const String leads = '/leads';
  static const String followUps = '/follow-ups';
  static const String calls = '/calls';
  static const String doctors = '/doctors';
  static const String appointments = '/appointments';
  static const String patients = '/patients';
  static const String shifts = '/shifts';
  static const String notifications = '/notifications';
  static const String analytics = '/analytics';
  static const String departments = '/departments';
}
