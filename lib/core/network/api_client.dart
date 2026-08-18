import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import '../constants/api_config.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage_service.dart';
import 'api_exceptions.dart';

/// Centralized Dio-based API client with interceptors and error handling.
class ApiClient extends GetxService {
  late final Dio _dio;

  Dio get dio => _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectionTimeoutMs),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _ErrorInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => Get.log(obj.toString()),
      ),
    ]);
  }

  // GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  // POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  // PUT
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(path, data: data, queryParameters: queryParameters, options: options);
  }

  // PATCH
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.patch(path, data: data, queryParameters: queryParameters, options: options);
  }

  // DELETE
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
  }
}

/// Attaches Bearer token to all authenticated requests.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final storage = Get.find<SecureStorageService>();
      final token = await storage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
      // Storage not initialized yet, skip
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Attempt token refresh
      try {
        final storage = Get.find<SecureStorageService>();
        final refreshToken = await storage.getRefreshToken();

        if (refreshToken != null && refreshToken.isNotEmpty) {
          final dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));
          final response = await dio.post(
            ApiConfig.refreshToken,
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccess = response.data['access'] as String?;
            final newRefresh = response.data['refresh'] as String?;

            if (newAccess != null) {
              await storage.saveAccessToken(newAccess);
              if (newRefresh != null) {
                await storage.saveRefreshToken(newRefresh);
              }

              // Retry the original request
              err.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
              final retryResponse = await dio.fetch(err.requestOptions);
              return handler.resolve(retryResponse);
            }
          }
        }
      } catch (_) {
        // Refresh failed, will throw UnauthorizedException
      }

      // Logout on refresh failure
      try {
        final storage = Get.find<SecureStorageService>();
        await storage.clearAll();
      } catch (_) {}
      Get.offAllNamed('/login');
    }
    handler.next(err);
  }
}

/// Maps Dio errors to application-specific exceptions.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const TimeoutException();
      case DioExceptionType.connectionError:
        throw const NetworkException();
      case DioExceptionType.badResponse:
        _handleBadResponse(err);
      default:
        throw ApiException(
          message: err.message ?? 'An unexpected error occurred.',
          statusCode: err.response?.statusCode,
        );
    }
    handler.next(err);
  }

  void _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;
    final message = data is Map ? (data['message'] as String?) : null;

    switch (statusCode) {
      case 401:
        throw UnauthorizedException(message: message ?? 'Your session has expired. Please login again.');
      case 403:
        throw ForbiddenException(message: message ?? 'You do not have permission to perform this action.');
      case 404:
        throw NotFoundException(message: message ?? 'The requested resource was not found.');
      case 422:
        final errors = data is Map ? (data['errors'] as Map<String, dynamic>?) : null;
        throw ValidationException(
          message: message ?? 'Please check your input and try again.',
          errors: errors?.map((k, v) => MapEntry(k, List<String>.from(v as List))),
        );
      case 500:
      default:
        throw ServerException(message: message ?? 'Something went wrong. Please try again later.');
    }
  }
}
