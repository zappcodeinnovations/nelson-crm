import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local storage service using SharedPreferences for non-sensitive data.
class LocalStorageService extends GetxService {
  late final SharedPreferences _prefs;

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // String
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  // Bool
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  // Int
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);

  // Remove
  Future<bool> remove(String key) => _prefs.remove(key);

  // Clear
  Future<bool> clear() => _prefs.clear();

  // Has key
  bool containsKey(String key) => _prefs.containsKey(key);
}
