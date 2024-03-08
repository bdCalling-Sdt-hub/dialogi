import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class GroupChatPoopUpController extends GetxController {
  TextEditingController groupName = TextEditingController();

  Future<void> changeCommunityNameRepo(String chatId) async {
    Map<String, String> body = {
      'name': groupName.text,
    };
    var response = await ApiService.patchApi("${ApiConstant.groupName}/$chatId",
        body: body);

    print(
        "=============================================>response ${response.responseJson}");
    print(
        "=============================================>response ${ApiConstant.groupName}/$chatId");

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.chatListScreen);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  Future<void> deleteAccountRepo(String chatId) async {
    print(
        "=========================================> url ${ApiConstant.users}/$chatId");

    var response = await ApiService.deleteApi("${ApiConstant.chats}/$chatId");

    print(
        "=========================================> response ${response.responseJson}");
    if (response.statusCode == 200) {
      Utils.toastMessage(response.message);
      Get.back();
      Get.back();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
  }
}
