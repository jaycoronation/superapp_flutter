import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerMethodsVault {

  static SharedPreferences? _prefsVault;

  static Future<SharedPreferences?> init() async {
    _prefsVault = await SharedPreferences.getInstance();
    return _prefsVault;
  }

  //sets
  static Future<bool?> setBool(String key, bool value) async =>
      await _prefsVault?.setBool(key, value);

  static Future<bool?> setDouble(String key, double value) async =>
      await _prefsVault?.setDouble(key, value);

  static Future<bool?> setInt(String key, int value) async =>
      await _prefsVault?.setInt(key, value);

  static Future<bool?> setString(String key, String value) async =>
      await _prefsVault?.setString(key, value);

  static Future<bool?> setStringList(String key, List<String> value) async =>
      await _prefsVault?.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefsVault?.getBool(key) ?? false;

  static double? getDouble(String key) => _prefsVault?.getDouble(key) ?? 0.0;

  static int? getInt(String key) => _prefsVault?.getInt(key) ?? 0;

  static String? getString(String key) => _prefsVault?.getString(key) ?? "";

  static List<String>? getStringList(String key) => _prefsVault?.getStringList(key) ?? [];

  //deletes..
  static Future<bool?> remove(String key) async => await _prefsVault?.remove(key);

  static Future<bool?> clear() async {
    await _prefsVault?.clear();
  }

}