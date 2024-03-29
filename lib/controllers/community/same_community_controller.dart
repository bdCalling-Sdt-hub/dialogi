import 'dart:convert';

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/models/same_community_model.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class SameCommunityController extends GetxController {
  Status status = Status.completed;
  bool isMoreLoading = false ;
  List chatList = [];
  bool isJoin = false;

  SameCommunityModel? sameCommunityModel;
  final ScrollController scrollController = ScrollController();
  int page = 1;

  Future<void> scrollControllerCall(String categoryId) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true ;
      update();
      await sameCommunityRepo(categoryId);
      isMoreLoading = false ;
      update();
    }
  }

  Future<void> sameCommunityRepo(String categoryId) async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.sameCommunity}?category=$categoryId&page=$page");

    if (kDebugMode) {
      print("====================> body ${response.responseJson}");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.responseJson);
      }
      sameCommunityModel =
          SameCommunityModel.fromJson(jsonDecode(response.responseJson));

      if (sameCommunityModel?.data?.attributes?.chatList != null) {
        chatList.addAll(sameCommunityModel!.data!.attributes!.chatList!);
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

  Future<void> joinCommunityRepo(String chatId, String name, String questionId) async {
    isJoin = true;
    update();

    var body = {
      "chatId": chatId,
      "question": questionId
    };

    if (kDebugMode) {
      print("====================> chatId ${chatId}");
    }

    var response = await ApiService.postApi(ApiConstant.joinCommunity, body);

    isJoin = true;
    update();

    if (kDebugMode) {
      print("====================> response ${response.responseJson}");
    }

    if (response.statusCode == 200) {

      Get.toNamed(AppRoutes.chatScreen, parameters: {
        "chatId": chatId,
        "type": AppStrings.community,
        "name": name
      });

    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }
}
