import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerMethodsPMS {

  static SharedPreferences? _prefsPMS;

  static Future<SharedPreferences?> init() async {
    _prefsPMS = await SharedPreferences.getInstance();
    return _prefsPMS;
  }

  //sets
  static Future<bool?> setBool(String key, bool value) async =>
      await _prefsPMS?.setBool(key, value);

  static Future<bool?> setDouble(String key, double value) async =>
      await _prefsPMS?.setDouble(key, value);

  static Future<bool?> setInt(String key, int value) async =>
      await _prefsPMS?.setInt(key, value);

  static Future<bool?> setString(String key, String value) async =>
      await _prefsPMS?.setString(key, value);

  static Future<bool?> setStringList(String key, List<String> value) async =>
      await _prefsPMS?.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefsPMS?.getBool(key) ?? false;

  static double? getDouble(String key) => _prefsPMS?.getDouble(key) ?? 0.0;

  static int? getInt(String key) => _prefsPMS?.getInt(key) ?? 0;

  static String? getString(String key) => _prefsPMS?.getString(key) ?? "";

  static List<String>? getStringList(String key) => _prefsPMS?.getStringList(key) ?? [];

  //deletes..
  static Future<bool?> remove(String key) async => await _prefsPMS?.remove(key);

  static Future<bool?> clear() async {
    await _prefsPMS?.clear();
  }

}