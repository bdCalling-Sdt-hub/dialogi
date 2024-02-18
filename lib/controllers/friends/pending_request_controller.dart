import 'dart:convert';

import 'package:dialogi_app/models/pending_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class PendingRequestController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List friendRequestList = [];

  PendingRequestModel? pendingRequestModel;

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

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    var response = await ApiService.getApi(
        "${ApiConstant.friends}?status=pending&page=$page",
        header: header);

    if (response.statusCode == 200) {
      print(response.responseJson);
      pendingRequestModel =
          PendingRequestModel.fromJson(jsonDecode(response.responseJson));

      for (var item in pendingRequestModel!.data!.attributes!.friendList!) {
        friendRequestList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }
}
