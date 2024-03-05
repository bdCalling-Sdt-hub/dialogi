import 'dart:convert';

import 'package:dialogi_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../helper/prefs_helper.dart';
import '../../models/chat_model.dart';
import '../../models/friend_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class FriendController extends GetxController {
  Status status = Status.completed;

  bool isMoreLoading = false ;

  int page = 1;

  List friendList = [];

  FriendModel friendListModel = FriendModel();

  ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = false ;
      update();
      await friendListRepo();
      isMoreLoading = false ;
      update();
    }
  }

  Future<void> friendListRepo() async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.friends}?status=accepted&page=$page");

    print("====================> body ${response.responseJson}");

    if (response.statusCode == 200) {
      print(response.responseJson);
      friendListModel = FriendModel.fromJson(jsonDecode(response.responseJson));

      if (friendListModel.data?.attributes?.friendList != null) {
        friendList.addAll(friendListModel.data!.attributes!.friendList!);
      }

      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  createChatRoom(String userId, String name) async {
    var body = {
      "participants": [userId, PrefsHelper.clientId],
      "subscription": "premium-plus"
      //groupName = "xyz"
      //type = ""
      //groupAdmin = "user ID"
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-chat", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");

      Get.toNamed(AppRoutes.chatScreen, parameters: {
        "chatId": data['data']['chatId'],
        "type": "single",
        "name": name
      });
    });
  }
}
