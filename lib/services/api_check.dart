

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:dialogi_app/utils/snack_bar.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if(response.statusCode == 401){
      await PrefsHelper.remove(AppConstants.bearerToken);
      Get.offAllNamed(AppRoutes.signInScreen);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}