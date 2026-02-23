import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static SharedPreferences? _preferences;

  static Future<void> initializeSharedPreference() async {
    log('share pref instance created');
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<bool> setStringValue(String key, String value) async {
    if (_preferences == null) {
      await initializeSharedPreference();
    }
    bool res = await _preferences!.setString(key, value);
    
    return res;
  }

  static String getStringValue(String key) {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _preferences?.getString(key) ?? "";
  }

  static Future<bool> setBoolValue(String key, bool value) async {
    if (_preferences == null) {
      await initializeSharedPreference();
    }
    return await _preferences!.setBool(key, value);
  }

  static bool getBoolValue(String key) {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _preferences?.getBool(key) ?? false;
  }

  static Future<void> clearData() async {
    if (_preferences == null) {
      await initializeSharedPreference();
    }
    await _preferences!.clear();
  }

  static Future<bool> deleteData(String key) async {
    if (_preferences == null) {
      await initializeSharedPreference();
    }
    return await _preferences!.remove(key);
  }
}
