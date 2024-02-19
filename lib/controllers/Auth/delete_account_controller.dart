

import 'package:dialogi_app/core/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class DeleteAccountController extends GetxController{

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> deleteAccountRepo() async {
    isLoading = true;
    update();

    Map<String, String> body = {
      'password': passwordController.text
    };

    var response =
        await ApiService.deleteApi(ApiConstant.users, body);

    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      Get.offAll(AppRoutes.signInScreen);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

}