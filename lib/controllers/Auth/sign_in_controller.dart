

import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../services/api_url.dart';

class SignInController extends GetxController{
  bool signInLoading = false;


  TextEditingController emailController = TextEditingController(text: kDebugMode? "siamjht@gmail.com" : "");
  TextEditingController passwordController = TextEditingController(text: kDebugMode? "hello123" : "");

  var headers = {
    'Content-Type' : 'application/json',
  };

  signInUser() async{
    signInLoading = true;
    update();
    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.postApi(ApiConstant.signIn, jsonEncode(body), headers);

    // print("===========${response}===========");

    if(response.statusCode == 200){

      var data = jsonDecode(response.responseJson) ;

      PrefsHelper.setString(AppConstants.bearerToken, data["accessToken"]);
      Get.toNamed(AppRoutes.homeScreen);
      emailController.clear();
      passwordController.clear();
    } else{
      // ApiChecker.checkApi(response.responseJson);
    }
    signInLoading = false;
    update();
  }
}