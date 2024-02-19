import 'dart:convert';

import 'package:dialogi_app/models/friend_model.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class PendingRequestController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  bool actionIsLoading = false;
  List friendRequestList = [];

  FriendModel? pendingRequestModel;

  int page = 1;
  final ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await pendingRequestRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> pendingRequestRepo() async {
    if (page == 1) {
      isLoading = true;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.friends}?status=pending&page=$page");


    print("====================> body ${response.responseJson}") ;

    if (response.statusCode == 200) {
      print(response.responseJson);
      pendingRequestModel =
          FriendModel.fromJson(jsonDecode(response.responseJson));

      for (var item in pendingRequestModel!.data!.attributes!.friendList!) {

        if(item.participants!.length == 2){
          friendRequestList.add(item);

        }
      }
      page = page + 1;
    }else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message) ;
    }

    isLoading = false;
    update();
  }

  Future<void> requestActionRepo(String userId, String status, int index) async {
    actionIsLoading = true;
    update();

    Map<String, String> body = {
      "status": status,
    };


    print("===========================>body $body") ;
    print("===========================>body ${ApiConstant.friends}/$userId") ;
    var response = await ApiService.putApi(
        "${ApiConstant.friends}/$userId", body);

    print(response.responseJson);

    if (response.statusCode == 201) {
      print(response.responseJson);


      friendRequestList.removeAt(index);

    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message) ;
    }

    actionIsLoading = false;
    update();
  }
}
