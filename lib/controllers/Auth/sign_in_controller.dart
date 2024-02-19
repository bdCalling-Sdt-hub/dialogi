import 'dart:convert';
import 'dart:developer';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../services/api_url.dart';
import '../../testScreen/success_login.dart';

class SignInController extends GetxController {
  bool signInLoading = false;

  TextEditingController emailController =
  TextEditingController(text: kDebugMode ? "siamjht@gmail.com" : "");
  TextEditingController passwordController =
  TextEditingController(text: kDebugMode ? "hello999" : "");

  var headers = {
    'Content-Type': 'application/json',
  };

  ///<<<======================= General Sign In ==============================>>>

  Future<void> signInUser() async {
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


      PrefsHelper.token = data['data']["accessToken"];
      PrefsHelper.clientId = data['data']["attributes"]["_id"];


      print("==========================================->clientId ${data['data']["attributes"]["_id"]}") ;

      print(
          "=============================> token ${data['data']["accessToken"]}");
      Get.toNamed(AppRoutes.homeScreen);
      emailController.clear();
      passwordController.clear();
      signInLoading = false;
      update();

    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
  }

  ///<<<====================== Google Sign In =================================>>>

  Future googleSignIn() async {
    try{
      signInLoading = true;
      update();

      final user = await GoogleSignInService.login();
      await user?.authentication;
      log(user!.displayName.toString());
      log(user.email);
      log(user.id);
      log(user.photoUrl.toString());
      if(Get.context!.mounted){
        Get.to(SuccessLogin(name: user.displayName!, email: user.email));
        Get.snackbar(
            "User login details",
            "",
            backgroundColor: Colors.blue.shade200,
            messageText: Column(
              children: [
                Text("Name: ${user.displayName}\n Email: ${user.email} \n Id: ${user.id} \n"),
                Image.network(user.photoUrl.toString()),
              ],
            )
        );
        signInLoading = false;
        update();
      }

    } catch (exception){
      log(exception.toString());
    }
  }
}