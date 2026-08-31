import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return CacheHelper.sharedPreferences.getString(key);
  }

  bool? getDataBool({required String key}) {
    return CacheHelper.sharedPreferences.getBool(key);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await CacheHelper.sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await CacheHelper.sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await CacheHelper.sharedPreferences.setInt(key, value);
    } else {
      return await CacheHelper.sharedPreferences.setDouble(key, value);
    }
  }

  dynamic getData({required String key}) {
    return CacheHelper.sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await CacheHelper.sharedPreferences.remove(key);
  }

  Future<bool> setStringList({required String key, required List<String> value}) async {
    return await CacheHelper.sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringList({required String key}) {
    return CacheHelper.sharedPreferences.getStringList(key);
  }

  Future<bool> containsKey({required String key}) async {
    return CacheHelper.sharedPreferences.containsKey(key);
  }

  Future<bool> clearData() async {
    return await CacheHelper.sharedPreferences.clear();
  }

  Future<dynamic> put({required String key, required dynamic value}) async {
    if (value is String) {
      return await CacheHelper.sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await CacheHelper.sharedPreferences.setBool(key, value);
    } else {
      return await CacheHelper.sharedPreferences.setInt(key, value);
    }
  }
}
