import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../../models/user_model.dart';
import '../auth_repository.dart';

class ApiAuthRepository implements AuthRepository {
  final ApiClient _apiClient;

  ApiAuthRepository(this._apiClient);

  @override
  Future<AuthResponseModel> login({required String phone, required String password}) async {
    final response = await _apiClient.post(
      ApiConfig.login,
      data: {
        'phone': phone,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> verifyOtp({required String phone, required String otp}) async {
    final response = await _apiClient.post(
      ApiConfig.verifyOtp,
      data: {
        'phone': phone,
        'otp': otp,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> forgotPassword({required String phone}) async {
    await _apiClient.post(
      ApiConfig.forgotPassword,
      data: {
        'phone': phone,
      },
    );
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    await _apiClient.post(
      ApiConfig.resetPassword,
      data: {
        'phone': phone,
        'otp': otp,
        'new_password': newPassword,
      },
    );
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await _apiClient.get(ApiConfig.profile);
    return UserModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } catch (_) {
      // Ignore errors on logout
    }
  }
}
