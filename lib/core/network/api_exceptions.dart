/// API exception classes for centralized error handling.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({String message = 'Your session has expired. Please login again.'})
      : super(message: message, statusCode: 401);
}

class ForbiddenException extends ApiException {
  const ForbiddenException({String message = 'You do not have permission to perform this action.'})
      : super(message: message, statusCode: 403);
}

class NotFoundException extends ApiException {
  const NotFoundException({String message = 'The requested resource was not found.'})
      : super(message: message, statusCode: 404);
}

class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    String message = 'Please check your input and try again.',
    this.errors,
  }) : super(message: message, statusCode: 422);
}

class ServerException extends ApiException {
  const ServerException({String message = 'Something went wrong. Please try again later.'})
      : super(message: message, statusCode: 500);
}

class NetworkException extends ApiException {
  const NetworkException({String message = 'Please check your internet connection.'})
      : super(message: message, statusCode: null);
}

class TimeoutException extends ApiException {
  const TimeoutException({String message = 'Request timed out. Please try again.'})
      : super(message: message, statusCode: null);
}
