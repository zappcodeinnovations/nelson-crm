import '../models/user_model.dart';

/// Authentication repository interface.
abstract class AuthRepository {
  Future<AuthResponseModel> login({required String phone, required String password});
  Future<AuthResponseModel> verifyOtp({required String phone, required String otp});
  Future<void> forgotPassword({required String phone});
  Future<void> resetPassword({required String phone, required String otp, required String newPassword});
  Future<UserModel> getProfile();
  Future<void> logout();
}
