

import 'dart:convert';

import 'package:dialogi_app/controllers/Auth/sign_up_controller.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';

class PasswordController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  bool isLoading = false;
  var forgetPasswordToken = '';

  ///<<<==================Forget Password Repo===============================>>>

  Future<void> forgerPasswordRepo() async {
    isLoading = true;
    update();
    // var header = {
    //   'Content-Type': 'application/json',
    //   'Cookie': 'i18next=en'
    // };
    Map<String, String> body =
    {
      "email": emailController.text,
    };
    var response = await ApiService.postApi(ApiConstant.forgetPassword, body, isHeader: false, {});

    print("--------------------Status Code: ${response.statusCode}--------------------");

    if(response.statusCode == 200){

      Get.toNamed(AppRoutes.otpScreen);

    } else if(response.statusCode == 404){

      Utils.toastMessage(AppConstants.userNotExist);

    } else{

      Get.snackbar(response.statusCode.toString(), response.message);

    }
    isLoading = false;
    update();

  }

  ///<<<===================Verify Password Repo==============================>>>

  Future<void> verifyOtpRepo() async{
    isLoading = true;
    update();
    Map<String, String> body =
    {
      "email": emailController.text,
      "otp": otpController.text
    };
    var response = await ApiService.postApi(ApiConstant.verifyOtp, body, isHeader: false, {});

    if(response.statusCode == 200){
      
      var responseData = jsonDecode(response.responseJson);

      print("///////////////////////${responseData['data']["forgetPasswordToken"]}////////////////////");
      forgetPasswordToken = responseData['data']["forgetPasswordToken"];

      Get.toNamed(AppRoutes.resetPasswordScreen);

    } else if(response.statusCode == 400){

      Utils.toastMessage(response.message);

    } else{
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  ///<<<===================Verify Password Repo==============================>>>

  Future<void> resetPasswordRepo() async{
    isLoading = true;
    update();
    Map<String, String> header =
    {
      "Forget-password" : "Forget-password $forgetPasswordToken",
    };

    Map<String, String> body =
    {
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await ApiService.postApi(ApiConstant.resetPassword, body, header);

    if(response.statusCode == 200){
      Utils.toastMessage(response.message);
      Get.toNamed(AppRoutes.signInScreen);

    } else if(response.statusCode == 400){

      Utils.toastMessage(response.message);

    } else{
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}