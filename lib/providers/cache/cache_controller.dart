import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeonline/enums.dart';

class CacheController {
  /// SINGLETON

  CacheController._();

  static CacheController obj = CacheController._();

  factory CacheController() {
    return obj;
  }

  /// SHARED PREF.

  late SharedPreferences sharedPreferences;

  Future<void> get initCache async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// DATA

  Future<void> setter(CacheKeys key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key.name, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key.name, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key.name, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key.name, value);
    }
  }

  dynamic getter(CacheKeys key) => sharedPreferences.get(key.name);
}
