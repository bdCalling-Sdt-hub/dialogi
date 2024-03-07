
import 'dart:developer';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutController extends GetxController{

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>This is Google signOut Method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>///

  static Future googleSignOut() async {
    try {
      await GoogleSignInService.logout();
      log('Sign Out Success');
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setBool("isProvider", false);
      PrefsHelper.isProvider = false ;
      // if (Get.context!.mounted) {
      //   Utils.snackBarMessage("Sign Out Success", "");
      //   // ScaffoldMessenger.of(Get.context!)
      //   //     .showSnackBar(const SnackBar(content: Text('Sign Out Success',style: TextStyle(color: Colors.white),)));
      // }
    } catch (exception) {
      log(exception.toString());
      // if (Get.context!.mounted) {
      //   Utils.snackBarMessage("Sign Out Failed", "");
        // ScaffoldMessenger.of(Get.context!)
        //     .showSnackBar(const SnackBar(content: Text('Sign Out Failed')));
      // }
    }
  }
}