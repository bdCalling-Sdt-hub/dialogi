


import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{


  static final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWM0YWUyMWZjMWNiYTIwOWFhNjQ0YjciLCJlbWFpbCI6InVzZXIuZGlhbG9naUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsInN1YnNjcmlwdGlvbiI6ImRlZmF1bHQiLCJpYXQiOjE3MDc5NzE4OTksImV4cCI6MTcwODA1ODI5OX0.Quz5oOWe9vaom7FiDv3qnqKwndZovlx8PCfJVWhOs78" ;

  ///<<<===========================Get Data Form Shared Preference===================>
  static Future<String> getString(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  ///<<<=====================Save Data To Shared Preference=======================>
  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   return preferences.setInt(key, value);
  }

  ///<<<==========================Remove Value==================================>
  static Future remove(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
 }

