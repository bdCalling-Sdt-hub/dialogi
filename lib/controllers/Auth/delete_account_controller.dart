

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
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

    print("=========================================> body $body") ;
    print("=========================================> body ${ApiConstant.users}") ;


    var response =
    await ApiService.deleteApi(ApiConstant.users, body: body);

    print("=========================================> response ${response.responseJson}") ;
    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      PrefsHelper.removeAllPrefData();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

}