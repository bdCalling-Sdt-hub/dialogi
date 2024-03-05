import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../models/group_member_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class GroupMemberController extends GetxController {
  Status status = Status.completed;
  bool isMoreLoading = false ;
  List memberList = [];

  bool isLeave = false;

  GroupMemberModel? groupMemberModel;
  final ScrollController scrollController = ScrollController();

  int page = 1;

  Future<void> scrollControllerCall(String chatId) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = false ;
      update();
      await groupMemberRepo(chatId);
      isMoreLoading = false ;
      update();
    }
  }

  Future<void> groupMemberRepo(String chatId) async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response =
        await ApiService.getApi("${ApiConstant.chats}/$chatId?page=$page");

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.responseJson);
      }
      groupMemberModel =
          GroupMemberModel.fromJson(jsonDecode(response.responseJson));

      if (groupMemberModel?.data?.attributes != null) {
        memberList.addAll(groupMemberModel!.data!.attributes!);
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

  Future<void> leaveCommunityRepo(String chatId) async {
    isLeave = true;
    update();

    var body = {
      "type": "group" //or community
    };

    var response =
        await ApiService.patchApi("${ApiConstant.leave}/$chatId", body: body);

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      isLeave = false;
      update();
      Get.back(result: chatId);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }
}
