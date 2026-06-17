// import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final Map<String, dynamic> _memoryDb = {};

  LocalStorageService(dynamic _);

  Future<bool> setString(String key, String value) async {
    _memoryDb[key] = value;
    return true;
  }

  String? getString(String key) {
    return _memoryDb[key] as String?;
  }

  Future<bool> remove(String key) async {
    _memoryDb.remove(key);
    return true;
  }

  Future<bool> setBool(String key, bool value) async {
    _memoryDb[key] = value;
    return true;
  }

  bool? getBool(String key, [String? value]) {
    return _memoryDb[key] as bool?;
  }
}

