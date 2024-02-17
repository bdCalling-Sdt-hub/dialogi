import 'dart:convert';

import 'package:dialogi_app/models/discussion_details_model.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/prefs_helper.dart';
import '../services/api_services.dart';
import '../services/api_url.dart';

class DiscussionDetailsController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List repliesList = [];
  int page = 1;

  DiscussionDetailsModel? discussionDetailsModel;

  final ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall(String discussionID) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await discussionDetailsRepo(discussionID);
      isMoreLoading = false;
      update();
    } else {}
  }

  Future<void> discussionDetailsRepo(String discussionID) async {
    print("=====================================> page $page");

    if (page == 1) {
      isLoading = true;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };
    var response = await ApiService.getApi(
        "${ApiConstant.discussions}/$discussionID?page=$page", header);

    print("===============================================================>statusCode ${response.statusCode}") ;
    print("===============================================================>message ${response.message}") ;
    print("===============================================================>responseJson ${response.responseJson}") ;

    if (response.statusCode == 200) {
      discussionDetailsModel =
          DiscussionDetailsModel.fromJson(jsonDecode(response.responseJson));

      for (var item
          in discussionDetailsModel!.data!.attributes!.discussion!.replies!) {
        repliesList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }
}
