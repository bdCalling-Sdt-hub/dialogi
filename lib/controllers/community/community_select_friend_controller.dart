import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/select_group_member_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';
import '../../utils/static_strings.dart';

class CommunitySelectFriendsController extends GetxController {
  Status status = Status.completed;
  Status statusMore = Status.completed;
  List friendList = [];
  List<bool> selectedFriends = [];
  bool isCreateGroup = false;

  List<String> selectedParticipants = [PrefsHelper.clientId];

  SelectGroupMemberModel? friendListModel;

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
        "${ApiConstant.getGroupFriends}?status=accepted&page=$page");

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.responseJson);
      }
      friendListModel =
          SelectGroupMemberModel.fromJson(jsonDecode(response.responseJson));

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
      selectedParticipants.add(friendList[index].otherParticipant.sId);
      if (kDebugMode) {
        print("======================================> $selectedParticipants");
      }
    } else {
      selectedParticipants.remove(friendList[index].otherParticipant.sId);
      if (kDebugMode) {
        print("======================================> $selectedParticipants");
      }
    }

    selectedFriends[index] = value;
    update();

    if (selectedParticipants.length < 5) {
      isCreateGroup = true;
      update();
      print("dkjfkljdshkfklds");
    } else {
      isCreateGroup = false;
      update();
    }
  }

  createNewGroup() async {
    var body = {
      "participants": selectedParticipants,
      "subscription": PrefsHelper.mySubscription,
      "groupName": nameController.text,
      "type": AppStrings.community,
      "groupAdmin": PrefsHelper.clientId
    };

    if (kDebugMode) {
      print("================================================> body $body");
    }

    SocketServices.socket.emitWithAck("add-new-chat", body, ack: (data) {
      if (kDebugMode) {
        print(
            "===============================================================> Received acknowledgment: $data");
      }
      Get.toNamed(AppRoutes.chatScreen, parameters: {
        "chatId": data['data']['chatId'],
        "type": AppStrings.community,
        "name": nameController.text
      });

      nameController.clear();
    });
  }
}
