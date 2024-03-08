
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';
import '../../utils/static_strings.dart';

class CommunityChatPopUpController extends GetxController {

  TextEditingController communityName = TextEditingController();
  RxBool isCommunityDelete = false.obs;
  bool isDeleteAccount = false;

  Future<void> changeCommunityNameRepo(String chatId) async {
    Map<String, String> body = {
      'name': communityName.text,
    };
    var response = await ApiService.patchApi("${ApiConstant.groupName}/$chatId",
        body: body);

    print(
        "=============================================>response ${response.responseJson}");

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.community);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  ///<<<==================== Group chat delete repo ============================>>>

  Future<void> deleteAccountRepo(String chatId) async {
    isCommunityDelete.value = true;
    isDeleteAccount = true;
    update();
    print(
        "=========================================> url ${ApiConstant.users}/$chatId");

    var response = await ApiService.deleteApi("${ApiConstant.chats}/$chatId");
    isCommunityDelete.value = false;
    isDeleteAccount = false;
    update();

    print(
        "=========================================> response ${response.responseJson}");
    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      Get.toNamed(AppRoutes.community);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
  }
}
