import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../services/api_url.dart';

class SignInController extends GetxController {
  bool signInLoading = false;

  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "user.dialogi@gmail.com" : "");
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "hello123" : "");

  var headers = {
    'Content-Type': 'application/json',
  };

  signInUser() async {
    signInLoading = true;
    update();
    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.postApi(ApiConstant.signIn, body,
       );

    print("===========${jsonDecode(response.responseJson)}===========");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.responseJson);


      print("=========================================> data $data") ;

      PrefsHelper.setString(AppConstants.bearerToken, data['data']["accessToken"]);
      PrefsHelper.setString("clientId", data['data']["attributes"]["_id"]);
      PrefsHelper.setString("myImage", data['data']["attributes"]["image"]);
      PrefsHelper.setString("myName", data['data']["attributes"]["fullName"]);


      PrefsHelper.token = data['data']["accessToken"];
      PrefsHelper.clientId = data['data']["attributes"]["_id"];
      PrefsHelper.myImage = data['data']["attributes"]["image"];
      PrefsHelper.myName = data['data']["attributes"]["fullName"];


      print("==========================================->clientId ${data['data']["attributes"]["_id"]}") ;

      print(
          "=============================> token ${data['data']["accessToken"]}");
      Get.toNamed(AppRoutes.homeScreen);
      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    signInLoading = false;
    update();
  }
}
