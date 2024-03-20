import 'dart:convert';

import 'package:dialogi_app/controllers/community/community_list_controller.dart';
import 'package:dialogi_app/models/group_member_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class CommunityMemberController extends GetxController {
  Status status = Status.completed;
  Status statusMore = Status.completed;
  List communityList = [];

  bool isLeave = false;

  GroupMemberModel? communityMemberModel;
  final ScrollController scrollController = ScrollController();
  CommunityListController communityListController =
      Get.put(CommunityListController());

  int page = 1;

  Future<void> scrollControllerCall(String chatId) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      statusMore = Status.loading;
      update();
      await communityMemberRepo(chatId);
      statusMore = Status.completed;
      update();
    }
  }

  Future<void> communityMemberRepo(String chatId) async {
    if (page == 1) {
      communityList.clear() ;
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.chats}/$chatId?page=$page&type=community");

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.responseJson);
      }
      communityMemberModel =
          GroupMemberModel.fromJson(jsonDecode(response.responseJson));

      if (communityMemberModel?.data?.attributes != null) {
        communityList.addAll(communityMemberModel!.data!.attributes!);
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
    var body = {
      "type": "community" //or community
    };

    var response =
        await ApiService.patchApi("${ApiConstant.leave}/$chatId", body: body);

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.community);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }
}
