import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../models/chat_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class CommunityListController extends GetxController {
  Status status = Status.completed;

  bool isMoreLoading = false;

  int page = 1;

  List communityList = [];

  ChatModel chatModel = ChatModel();

  ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await communityRepo();
      isMoreLoading = false;
      update();
    } else {
      print(
          "======================================================> sdfdsjfdsklfjdslkfjsfjlksdjlkf");
    }
  }

  Future<void> communityRepo() async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.chats}?page=$page&type=community");

    if (response.statusCode == 200) {
      print(response.responseJson);
      chatModel = ChatModel.fromJson(jsonDecode(response.responseJson));

      if (chatModel.data?.attributes?.chatList != null &&
          chatModel.data!.attributes!.chatList!.isNotEmpty) {
        communityList.addAll(chatModel.data!.attributes!.chatList!);
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
}
