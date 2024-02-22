import 'dart:convert';

import 'package:dialogi_app/models/discussion_details_model.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../global/api_response_model.dart';
import '../helper/prefs_helper.dart';
import '../services/api_services.dart';
import '../services/api_url.dart';

class DiscussionDetailsController extends GetxController {
  Status status = Status.completed;
  bool isMoreLoading = false;
  bool isReplay = false;
  bool isLoadingReplay = false;
  List repliesList = [];
  int page = 1;

  DiscussionDetailsModel? discussionDetailsModel;

  final ScrollController scrollController = ScrollController();
  TextEditingController replyController = TextEditingController();

  Future<void> scrollControllerCall(String discussionID) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await discussionDetailsRepo(discussionID);
      isMoreLoading = false;
      update();
    }
  }

  Future<void> discussionDetailsRepo(String discussionID) async {
    print("=====================================> page $page");

    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
      "${ApiConstant.discussions}/$discussionID?page=$page",
    );

    if (response.statusCode == 200) {
      discussionDetailsModel =
          DiscussionDetailsModel.fromJson(jsonDecode(response.responseJson));

      for (var item
          in discussionDetailsModel!.data!.attributes!.discussion!.replies!) {
        repliesList.add(item);
      }

      print("=======================> ${repliesList.length}");
      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  Future<void> addReplyRepo(String DiscussionID) async {
    isLoadingReplay = true;
    update();

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    Map<String, String> body = {
      ///==================================> Discussion ID dite hobe<=====================================
      'discussion': DiscussionID,
      'reply': replyController.text
    };

    var response =
        await ApiService.postApi(ApiConstant.reply, body, header: header);

    if (response.statusCode == 201) {
      print("========================================> fgfgjhjh");
      replyController.clear();
      isMoreLoading = false;
      update();
      repliesList.clear();
      page = 1;
      await discussionDetailsRepo(DiscussionID);
      isMoreLoading = true;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoadingReplay = false;
    update();
    isReplay = false;
    update();
  }

  Future<void> addReply() async {
    isReplay = true;
    update();
  }
}
