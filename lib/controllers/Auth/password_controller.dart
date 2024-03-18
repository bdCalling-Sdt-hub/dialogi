import 'dart:convert';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';

class PasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ///<<<============== Change Password Controllers ======================>>>
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterNewPasswordController = TextEditingController();

  ///<<<============== Settings Page Forget Password Controllers ============>>>
  // TextEditingController settingsEmailController = TextEditingController();
  TextEditingController settingsOtpController = TextEditingController();

  ///<<<============== Settings Reset Password Controllers ======================>>>
  TextEditingController settingsPasswordController = TextEditingController();
  TextEditingController settingsConfirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  String forgetPasswordToken = "";

  ///<<<==================Forget Password Repo===============================>>>

  Future<void> forgetPasswordRepo({bool isResend = false}) async {
    if(!isResend){
      isLoading = true;
      update();
    }
    Map<String, String> body = {
      "email": emailController.text,
    };
    var response = await ApiService.postApi(
      ApiConstant.forgetPassword,
      body,
    );

    print(
        "--------------------Status Code: ${response.statusCode}--------------------");

    if (response.statusCode == 200) {
      Utils.toastMessage(AppConstants.otpSend);
      Get.toNamed(AppRoutes.otpScreen);
    } else if (response.statusCode == 404) {
      Utils.toastMessage(AppConstants.userNotExist);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  ///<<<===================Verify Password Repo==============================>>>

  Future<void> verifyOtpRepo() async {
    isLoading = true;
    update();
    Map<String, String> body = {
      "email": emailController.text,
      "otp": otpController.text
    };
    var response = await ApiService.postApi(
      ApiConstant.verifyOtp,
      body,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.responseJson);

      print(
          "///////////////////////${responseData['data']["forgetPasswordToken"]}////////////////////");

      PrefsHelper.setString(AppConstants.forgetPasswordToken,
          responseData['data']["forgetPasswordToken"]);
      forgetPasswordToken = responseData['data']["forgetPasswordToken"];
      Get.toNamed(AppRoutes.resetPasswordScreen);
      print("Forget password token:=>>> ${responseData['data']["forgetPasswordToken"]}");

    } else if (response.statusCode == 400) {
      Utils.toastMessage(response.message);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    otpController.text = "";
    isLoading = false;
    update();
  }

  ///<<<===================Verify Password Repo==============================>>>

  Future<void> resetPasswordRepo() async {
    isLoading = true;
    update();
    Map<String, String> header = {
      "Forget-password": "Forget-password $forgetPasswordToken",
    };
    print("Forget Password Token ::::$forgetPasswordToken");

    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await ApiService.postApi(ApiConstant.resetPassword, body,
        header: header);

    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      Get.toNamed(AppRoutes.signInScreen);
    } else if (response.statusCode == 400) {
      Utils.toastMessage(response.message);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  ///<<<================== Change Password Repo =============================>>>

  Future<void> changePasswordRepo() async {
    print("Token:----------------${PrefsHelper.token}");

    isLoading = true;
    update();
    Map<String, String> header = {
      "Authorization": "Bearer ${PrefsHelper.token}"
    };

    Map<String, String> body = {
      "oldPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text
    };
    var response = await ApiService.patchApi(ApiConstant.changePassword,
        body: body, header: header);

    print('++++++++++++++++++++ ${response.responseJson} ++++++++++++++++++');

    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);

      currentPasswordController.text = "";
      newPasswordController.text = "";
      reEnterNewPasswordController.text = "";

      Get.toNamed(AppRoutes.settingsScreen);
    } else if (response.statusCode == 400) {
      Utils.toastMessage(response.message);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  ///<<<================ Settings Forget Password Repo ======================>>>

  Future<void> settingsForgetPasswordRepo({bool isReSend = false}) async {
    if(!isReSend){
      isLoading = true;
      update();
    }
    Map<String, String> body = {
      "email": PrefsHelper.myEmail,
    };
    var response = await ApiService.postApi(
      ApiConstant.forgetPassword,
      body,
    );

    print(
        "--------------------Status Code: ${response.statusCode}--------------------");

    if (response.statusCode == 200) {
      Utils.toastMessage(AppConstants.otpSend);
      Get.toNamed(AppRoutes.settingsGetOtp);
    } else if (response.statusCode == 404) {
      Utils.toastMessage(AppConstants.userNotExist);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  ///<<<==================== Settings Get Otp Repo ==========================>>>

  Future<void> settingsVerifyOtpRepo() async {
    isLoading = true;
    update();

    Map<String, String> body = {
      "email": PrefsHelper.myEmail,
      "otp": settingsOtpController.text
    };
    var response = await ApiService.postApi(
      ApiConstant.verifyOtp,
      body,
    );

    print("///////////////////////${response.message}////////////////////");

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.responseJson);

      print(
          "///////////////////////${responseData['data']["forgetPasswordToken"]}////////////////////");

      PrefsHelper.setString(AppConstants.forgetPasswordToken,
          responseData['data']["forgetPasswordToken"]);
      PrefsHelper.forgetPasswordToken =
          responseData['data']["forgetPasswordToken"];

      Get.toNamed(AppRoutes.settingsResetPasswordScreen);
    } else if (response.statusCode == 400) {
      Utils.toastMessage(response.message);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    settingsOtpController.text = "";
    isLoading = false;
    update();
  }

  ///<<<================== Settings Reset Password Repo =============================>>>

  Future<void> settingsResetPasswordRepo() async {
    isLoading = true;
    update();
    Map<String, String> header = {
      "Forget-password": "Forget-password ${PrefsHelper.forgetPasswordToken}",
    };

    Map<String, String> body = {
      "email": PrefsHelper.myEmail,
      "password": settingsPasswordController.text
    };
    var response = await ApiService.postApi(ApiConstant.resetPassword, body,
        header: header);

    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      Get.offNamed(AppRoutes.settingsScreen);
    } else if (response.statusCode == 400) {
      Utils.toastMessage(response.message);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}
