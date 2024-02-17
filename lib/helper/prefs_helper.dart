


import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{


  static final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWNkZTRlNzI5NDM5M2M5NjljZmY0MzEiLCJlbWFpbCI6InVzZXIuZGlhbG9naUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsInN1YnNjcmlwdGlvbiI6ImRlZmF1bHQiLCJpYXQiOjE3MDgxNjExMzAsImV4cCI6MTcwODI0NzUzMH0.lJ1TQYBIzeo54HK-Zn_6gCrETOyzjHo3avK2JDRyhIM" ;

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

