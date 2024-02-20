import 'dart:convert';

import 'package:dialogi_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../core/app_routes.dart';
import '../../models/friend_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class FriendController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List friendList = [];

  FriendModel? pendingRequestModel;

  int page = 1;
  final ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await myFriendRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> myFriendRepo() async {
    if (page == 1) {
      isLoading = true;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.friends}?status=accepted&page=$page");

    if (response.statusCode == 200) {
      print(response.responseJson);
      pendingRequestModel =
          FriendModel.fromJson(jsonDecode(response.responseJson));

      for (var item in pendingRequestModel!.data!.attributes!.friendList!) {
        friendList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }

  addNewChat() async {
    var body = {
      "participants": ["65cdfa0614dd5e651e5ce531", "65d45ec33b8aaf63cf093fc0"],
      "subscription": "premium-plus"
      //groupName = "xyz"
      //type = ""
      //groupAdmin = "user ID"
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-chat", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");

      Get.toNamed(AppRoutes.chatScreen);
    });
  }
}
