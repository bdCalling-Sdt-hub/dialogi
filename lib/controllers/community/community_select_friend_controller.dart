import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/premium_plus_model.dart';
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
  bool isMoreLoading = false;

  List friendList = [];
  List<bool> selectedFriends = [];
  bool isCreateGroup = false;
  bool isCreateCommunity = false;

  List<String> selectedParticipants = [];

  PremiumPlusModel? premiumPlusModel;

  int page = 1;
  final ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await friendListRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> friendListRepo() async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.premiumPlus}?status=accepted&page=$page");

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.responseJson);
      }
      premiumPlusModel =
          PremiumPlusModel.fromJson(jsonDecode(response.responseJson));

      if (premiumPlusModel?.data?.attributes?.userList != null) {
        friendList.addAll(premiumPlusModel!.data!.attributes!.userList!);
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
      selectedParticipants.add(friendList[index].sId);
      if (kDebugMode) {
        print("======================================> $selectedParticipants");
      }
    } else {
      selectedParticipants.remove(friendList[index].sId);
      if (kDebugMode) {
        print("======================================> $selectedParticipants");
      }
    }

    selectedFriends[index] = value;
    update();

    if (selectedParticipants.length > 1 && selectedParticipants.length < 5) {
      isCreateGroup = true;
      update();
      print("dkjfkljdshkfklds");
    } else {
      isCreateGroup = false;
      update();
    }
  }

  Future<void> createNewCommunityRepo(
      String questionId, String categoryId) async {
    isCreateCommunity = true;
    update();
    var body = {
      "participants": jsonEncode(selectedParticipants),
      "groupName": nameController.text,
      "category": categoryId,
      "type": "community",
      "groupAdmin": PrefsHelper.clientId,
      "question": questionId
    };

    print("===================================> body $body");
    var response = await ApiService.postApi(
      ApiConstant.communityChat,
      body,
    );

    print("===========${jsonDecode(response.responseJson)}===========");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.responseJson);

      print("=========================================> data $data");

      Get.toNamed(AppRoutes.chatScreen, parameters: {
        "chatId": data['data']['attributes']['_id'],
        "type": AppStrings.community,
        "name": nameController.text
      });
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isCreateCommunity = false;
    update();
  }
}
