

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}