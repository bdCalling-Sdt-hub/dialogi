import 'dart:convert';
import 'dart:io';

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../helper/prefs_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  ///<<<===================Show Calender Date================================>>>

  Future<void> dateOfBirthPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              background: AppColors.whiteColor,
              primary: AppColors.blue_500, // <-- SEE HERE
              // onPrimary: AppColors.black_300, // <-- SEE HERE
              onSurface: AppColors.black_500, // <-- SEE HERE
            ),
          ),
          child: child!),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != birthDayController.text) {
      birthDayController.text = "${picked.year}-${picked.month}-${picked.day}";
      update();
    }
  }

  ///<<<==================Image Pick From Gallery============================>>>

  String? image;

  gallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery);
    if (getImages != null) {
      image = getImages.path;
      navigator!.pop();
      update();
    }
  }

  ///<<<====================Image Pick From Camera===========================>>>
  camera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.camera);
    if (getImages != null) {
      image = getImages.path;
      navigator!.pop();
      update();
    }
  }

  bool signUpLoading = false;

  ///<<<====================SignUp Api Call===========================>>>

  signUpUser() async {
    signUpLoading = true;
    update();

    print("Sign up controller called");

    // Map<String, String> headers = {
    //   'OTP': 'OTP ${otpController.text.isNotEmpty ? otpController.text : " "}',
    //   'Cookie': 'i18next=en'
    // };

    try{

      Map<String, String> body = {
        'fullName': nameController.text,
        'email': emailController.text,
        'dateOfBirth': birthDayController.text,
        'address': addressController.text,
        'password': passWordController.text,
      };

      print("+++++++++ Body: $body ++++++++");
      print("+++++++++ image: $image ++++++++");

      var response =
      await ApiService.signUpMultipartRequest (url: ApiConstant.signUp, imagePath: image, body: body, otp: otpController.text)
          .timeout(const Duration(seconds: 30));

      print("=============${response.statusCode}::::${response.responseJson}===============");
      var data = jsonDecode(response.responseJson);
      if (response.statusCode == 200) {

        if (otpController.text.isEmpty) {

          Fluttertoast.showToast(msg: "Otp send to you mail");
          Get.toNamed(
            AppRoutes.signupOtpScreen,
          );

        } else {

          Get.offAndToNamed(AppRoutes.signInScreen);
          PrefsHelper.setString(AppConstants.bearerToken, data['data']["accessToken"]);
          PrefsHelper.setString("clientId", data['data']["attributes"]["_id"]);
          PrefsHelper.token = data['data']["accessToken"];
          PrefsHelper.clientId = data['data']["attributes"]["_id"];

        }
      } else if (response.statusCode == 201) {

        if (otpController.text.isEmpty) {
          Fluttertoast.showToast(msg: "Otp send to you mail");
          Get.toNamed(
            AppRoutes.signupOtpScreen,
          );

        } else {

          Get.offAllNamed(AppRoutes.homeScreen);
          PrefsHelper.setString(AppConstants.bearerToken, data['data']["accessToken"]);
          PrefsHelper.setString("clientId", data['data']["attributes"]["_id"]);
          PrefsHelper.token = data['data']["accessToken"];
          PrefsHelper.clientId = data['data']["attributes"]["_id"];

        }
      }else {
        // ApiChecker.checkApi(response);
        // }
      }
      signUpLoading = false;
      update();
    } catch (e){
      print("Timeout occurred: $e");
      Fluttertoast.showToast(msg: AppConstants.connectionTimedOUt);
    }
  }
}
