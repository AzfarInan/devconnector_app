import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<bool> setString(String key, String value) async {
    final prefs = await getPrefs();
    return prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await getPrefs();
    return prefs.getString(key);
  }
}
