import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';

/// Secure token storage using flutter_secure_storage.
class SecureStorageService extends GetxService {
  late final FlutterSecureStorage _storage;

  @override
  void onInit() {
    super.onInit();
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  // Access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: AppConstants.accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  // Refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  // User data (JSON string)
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: AppConstants.userDataKey, value: userData);
  }

  Future<String?> getUserData() async {
    return _storage.read(key: AppConstants.userDataKey);
  }

  // Clear all
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if tokens exist
  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
