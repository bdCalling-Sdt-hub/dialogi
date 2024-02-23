import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../models/friend_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';

class SelectFriendsController extends GetxController {
  Status status = Status.completed;
  Status statusMore = Status.completed;
  List friendList = [];
  List<bool> selectedFriends = [];
  List<String> selectedParticipants = [PrefsHelper.clientId];

  FriendModel? friendListModel;

  String type = "";

  int page = 1;
  final ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      statusMore = Status.loading;
      update();
      await friendListRepo();
      statusMore = Status.completed;
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

      if (friendListModel?.data?.attributes?.friendList != null) {
        friendList.addAll(friendListModel!.data!.attributes!.friendList!);
      }

      selectedFriends = List.generate(friendList.length, (index) => false);
      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  selectParticipants(bool value, int index) {
    if (value == true) {
      selectedParticipants.add(friendList[index].participants[0].sId);
      print("======================================> ${selectedParticipants}");
    } else {
      selectedParticipants.remove(friendList[index].participants[0].sId);
      print("======================================> ${selectedParticipants}");
    }

    selectedFriends[index] = value;
    update();
  }

  createNewGroup() async {
    var body = {
      "participants": selectedParticipants,
      "subscription": PrefsHelper.mySubscription,
      "groupName": nameController.text,
      "type": type,
      "groupAdmin": PrefsHelper.clientId
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-chat", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");
      Get.toNamed(AppRoutes.chatScreen, parameters: {
        "chatId": data['data']['chatId'],
        "type": type,
        "name": nameController.text
      });

      nameController.clear();
    });
  }
}
