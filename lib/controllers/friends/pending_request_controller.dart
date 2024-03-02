import 'dart:convert';

import 'package:dialogi_app/models/community_request_model.dart';
import 'package:dialogi_app/models/friend_model.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class PendingRequestController extends GetxController {
  Status status = Status.completed;
  Status communityStatus = Status.completed;
  bool isMoreLoading = false;
  bool actionIsLoading = false;
  List friendRequestList = [];
  List communityRequest = [];

  bool isCommunityRequest = false;

  FriendModel? pendingRequestModel;
  CommunityRequestModel? communityRequestModel;

  int page = 1;
  int communityPage = 1;
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
    isCommunityRequest = false;
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.friends}?status=pending&page=$page");

    print("====================> body ${response.responseJson}");

    if (response.statusCode == 200) {
      print(response.responseJson);
      pendingRequestModel =
          FriendModel.fromJson(jsonDecode(response.responseJson));

      for (var item in pendingRequestModel!.data!.attributes!.friendList!) {
        friendRequestList.add(item);
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

  Future<void> communityScrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await communityRequestRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> communityRequestRepo() async {
    isCommunityRequest = true;
    if (communityPage == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
        "${ApiConstant.communityChat}?page=$communityPage");

    print("====================> body ${response.responseJson}");

    if (response.statusCode == 200) {
      print(response.responseJson);
      communityRequestModel =
          CommunityRequestModel.fromJson(jsonDecode(response.responseJson));

      if (communityRequestModel?.data?.attributes?.communityRequestList !=
          null) {
        communityRequest.addAll(
            communityRequestModel!.data!.attributes!.communityRequestList!);
      }
      communityPage = communityPage + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  Future<void> requestActionRepo(String userId, String status, int index) async {
    actionIsLoading = true;
    update();

    Map<String, String> body = {
      "status": status,
    };

    print("===========================>body $body");
    print("===========================>body ${ApiConstant.friends}/$userId");
    var response =
        await ApiService.putApi("${ApiConstant.friends}/$userId", body);

    print(response.responseJson);

    if (response.statusCode == 200) {
      print(response.responseJson);

      friendRequestList.removeAt(index);
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    actionIsLoading = false;
    update();
  }


  Future<void> communityRequestActionRepo(String requestId, String status, int index) async {


    Map<String, String> body = {
      "status": status,
    };

    print("===========================>body $body");
    print("===========================>body ${ApiConstant.communityChat}/$requestId");
    var response =
        await ApiService.patchApi("${ApiConstant.communityChat}/$requestId", body: body);

    print(response.responseJson);

    if (response.statusCode == 200) {
      print(response.responseJson);

      communityRequest.removeAt(index);
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }


  }





  String getFormattedDate(String dateString) {
    // String dateString = "2024-02-01T04:39:03.524Z";
    DateTime originalDateTime = DateTime.parse(dateString);
    DateTime currentDateTime = DateTime.now();

    Duration difference = currentDateTime.difference(originalDateTime);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return ("${difference.inMinutes} minutes ago");
      } else {
        return ("${difference.inHours} hours ago");
      }
    } else {
      var createdAtTime = dateString.split(".")[0];
      var date = createdAtTime.split("T")[0];
      var time = createdAtTime.split("T")[1];
      return "${date} at $time";
    }
  }
}
