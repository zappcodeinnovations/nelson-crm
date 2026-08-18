import 'dart:convert';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../routes/app_routes.dart';

/// Authentication controller managing login, OTP, session state.
class AuthController extends GetxController {
  late final AuthRepository _authRepo;
  final _storage = Get.find<SecureStorageService>();

  // State
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final currentUser = Rxn<UserModel>();

  // Form fields
  final phoneController = ''.obs;
  final passwordController = ''.obs;
  final otpController = ''.obs;
  final showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authRepo = Get.find<AuthRepository>();
  }

  /// Check if user is already logged in.
  Future<void> checkAuthState() async {
    try {
      final hasTokens = await _storage.hasTokens();
      if (hasTokens) {
        final userData = await _storage.getUserData();
        if (userData != null) {
          currentUser.value = UserModel.fromJson(jsonDecode(userData));
          isLoggedIn.value = true;
          Get.offAllNamed(AppRoutes.home);
          return;
        }
      }
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  /// Login with phone and password.
  Future<void> login(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      SnackbarUtils.showError('Please enter phone number and password.');
      return;
    }

    isLoading.value = true;
    try {
      final response = await _authRepo.login(phone: phone, password: password);
      await _saveSession(response);
      SnackbarUtils.showSuccess('Welcome, ${response.user.name}!');
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarUtils.showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify OTP.
  Future<void> verifyOtp(String phone, String otp) async {
    if (otp.isEmpty || otp.length != 6) {
      SnackbarUtils.showError('Please enter a valid 6-digit OTP.');
      return;
    }

    isLoading.value = true;
    try {
      final response = await _authRepo.verifyOtp(phone: phone, otp: otp);
      await _saveSession(response);
      SnackbarUtils.showSuccess('Welcome, ${response.user.name}!');
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarUtils.showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  /// Request password reset.
  Future<void> forgotPassword(String phone) async {
    if (phone.isEmpty) {
      SnackbarUtils.showError('Please enter your phone number.');
      return;
    }

    isLoading.value = true;
    try {
      await _authRepo.forgotPassword(phone: phone);
      SnackbarUtils.showSuccess('OTP sent to $phone');
      Get.toNamed(AppRoutes.otp, arguments: {'phone': phone, 'isReset': true});
    } catch (e) {
      SnackbarUtils.showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout and clear session.
  Future<void> logout() async {
    try {
      await _authRepo.logout();
    } catch (_) {}
    await _storage.clearAll();
    currentUser.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
  }

  /// Save authentication tokens and user data.
  Future<void> _saveSession(AuthResponseModel response) async {
    await _storage.saveAccessToken(response.accessToken);
    if (response.refreshToken != null) {
      await _storage.saveRefreshToken(response.refreshToken!);
    }
    await _storage.saveUserData(jsonEncode(response.user.toJson()));
    currentUser.value = response.user;
    isLoggedIn.value = true;
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }
}
