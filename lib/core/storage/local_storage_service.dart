import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _preferences;

  LocalStorageService(this._preferences);

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  bool? getBool(String key, String value) {
    return _preferences.getBool(key);
  }
}
