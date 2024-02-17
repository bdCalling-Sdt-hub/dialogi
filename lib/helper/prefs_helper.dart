import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class PrefsHelper {
  static String token = "";
  static String forgetPasswordToken = "";












  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(AppConstants.bearerToken) ??
        "";
    forgetPasswordToken =
        preferences.getString(AppConstants.forgetPasswordToken) ??
            "";

    print("..................$token............................");
  }

  ///<<<===========================Get Data Form Shared Preference===================>
  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  ///<<<=====================Save Data To Shared Preference=======================>
  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();



    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  ///<<<==========================Remove Value==================================>
  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
