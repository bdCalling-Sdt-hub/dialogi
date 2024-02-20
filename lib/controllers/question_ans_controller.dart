import 'dart:convert';

import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/controllers/category/sub_category_controller.dart';
import 'package:dialogi_app/models/question_ans_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helper/prefs_helper.dart';
import '../models/reply_model.dart';
import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class QuestionAnsController extends GetxController {
  bool isLoading = false;
  bool isLoadingDiscussion = false;
  bool isLoadingMoreDiscussion = false;
  bool isLoadingReplay = false;
  bool isReplay = false;

  String replyDiscussionID = "";

  QuestionAnsModel? questionAnsModel;
  List discussionList = [];
  List<ReplyModel> replyList = [];

  int page = 1;
  int discussionPage = 1;
  int totalPages = 0;

  TextEditingController replyController = TextEditingController();
  TextEditingController discussionController = TextEditingController();

  CategoryController categoryController = Get.put(CategoryController());

  ScrollController discussionScrollController = ScrollController();

  SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  Future<void> scrollControllerCall(String subCategory) async {
    if (discussionScrollController.position.pixels ==
        discussionScrollController.position.maxScrollExtent) {
      isLoadingMoreDiscussion = true;

      update();
      await questionsRepo(subCategory);
      isLoadingMoreDiscussion = false;
      update();
    } else {
      print(
          "======================================================> sdfdsjfdsklfjdslkfjsfjlksdjlkf");
    }
  }

  Future<void> questionsRepo(String subCategory) async {
    if (discussionPage == 1) {
      isLoading = true;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    var response = await ApiService.getApi(
        "${ApiConstant.questions}/$subCategory/${categoryController.categoryId}?page=$page&limit=1&discussionLimit=5&discussionPage=$discussionPage",
        header:header);

    if (response.statusCode == 200) {
      print(response.responseJson);
      questionAnsModel =
          QuestionAnsModel.fromJson(jsonDecode(response.responseJson));

      for (var item
          in questionAnsModel!.data!.attributes!.questions![0].discussions!) {
        discussionList.add(item);
      }

      totalPages = questionAnsModel!.data!.attributes!.pagination!.totalPages!;
      discussionPage = discussionPage + 1;

      print(
          "========================================. ${discussionList.length}");
      print("========================================. ${discussionPage}");
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  Future<void> addReplyRepo() async {

    isLoadingReplay = true;
    update();

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    Map<String, String> body = {
      ///==================================> Discussion ID dite hobe<=====================================
      'discussion': replyDiscussionID,
      'reply': replyController.text
    };

    var response = await ApiService.postApi(ApiConstant.reply, body,header: header);

    if (response.statusCode == 201) {
      print("========================================> fgfgjhjh");
      replyController.clear() ;
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoadingReplay = false;
    update();
    isReplay = false;
    update();
  }

  Future<void> addDiscussionRepo(String subCategory) async {
    isLoadingDiscussion = false;
    update();

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    Map<String, String> body = {
      ///==================================> Discussion ID dite hobe<=====================================
      'question': "${questionAnsModel!.data!.attributes!.questions![0].sId}",
      'discussion': discussionController.text
    };

    var response =
        await ApiService.postApi(ApiConstant.discussions, body, header : header);

    if (response.statusCode == 201) {
      discussionController.clear() ;
      print("========================================> fgfgjhjh");
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoadingDiscussion = false;
    update();
  }

  Future<void> addReply(String id) async {
    replyDiscussionID = id;
    isReplay = true;
    update();

    print("===========================================> id : $id");
  }
}
