import 'dart:convert';

import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/controllers/category/sub_category_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/models/add_discussion_model.dart';
import 'package:dialogi_app/models/question_ans_model.dart';
import 'package:dialogi_app/services/admob_ad_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../helper/prefs_helper.dart';
import '../../models/access_status_model.dart';
import '../../models/reply_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';
import '../../view/screens/home/home_controller/home_controller.dart';

class QuestionAnsController extends GetxController {
  Status status = Status.completed;

  bool isLoadingDiscussion = false;
  bool isLoadingMoreDiscussion = false;
  bool isLoadingReplay = false;
  bool isReplay = false;
  bool isLike = false;
  bool isDislike = false;
  bool isAddDiscussion = false;

  String replyDiscussionID = "";
  int indexNumber = 0;

  QuestionAnsModel? questionAnsModel;
  AddDiscussionModel? addDiscussionModel;

  List discussionList = [];
  List<ReplyModel> replyList = [];

  int page = 1;
  int discussionPage = 1;
  int totalPages = 0;

  bool isDiscuss = false;
  bool isGroup = false;
  bool isCommunity = false;

  TextEditingController replyController = TextEditingController();
  TextEditingController discussionController = TextEditingController();

  CategoryController categoryController = Get.put(CategoryController());

  ScrollController discussionScrollController = ScrollController();

  SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  Future<void> scrollControllerCall(
      String subCategory, String categoryId) async {
    if (discussionScrollController.position.pixels ==
        discussionScrollController.position.maxScrollExtent) {
      isLoadingMoreDiscussion = true;

      update();
      await questionsRepo(subCategory, categoryId);
      isLoadingMoreDiscussion = false;
      update();
    } else {
      print(
          "======================================================> sdfdsjfdsklfjdslkfjsfjlksdjlkf");
    }
  }

  nextQuestion() {
    AdmobAdServices.interstitialAd.show();

    if (Homecontroller.status == Status.completed) {
      bool isAds = Homecontroller.accessStatusModel!.data!.questionAccessed! %
              Homecontroller.accessStatusModel!.data!.addFrequency! ==
          0;

      print("==============================> isAds $isAds");
      if (Homecontroller.accessStatusModel!.data!.isAddAvailable!) {
        if (isAds) {
          if (AdmobAdServices.isInterstitialAdReady.value) {
            try {
              AdmobAdServices.interstitialAd.show();
            } catch (e) {
              print(e.toString());
            }
          }
          AdmobAdServices.loadInterstitialAd();
        }
      }
    } else {
      Homecontroller.getAccessStatus();
    }
  }

  checkDiscuss() {
    if (Homecontroller.status == Status.completed) {
      if (Homecontroller.accessStatusModel!.data!.isGroupChatAvailable ==
              false &&
          Homecontroller
                  .accessStatusModel!.data!.isCommunityDiscussionAvailable ==
              false) {
        isDiscuss = true;
      }
    }
  }

  Future<void> questionsRepo(String subCategory, String categoryId) async {
    if (discussionPage == 1) {
      status = Status.loading;
      update();
    }

    getContextStatus();

    print(categoryId);

    var response = await ApiService.getApi(
        "${ApiConstant.questions}/$subCategory/$categoryId?page=$page&limit=1&discussionLimit=10&discussionPage=$discussionPage");

    print(
        "===========================================>${ApiConstant.questions}/$subCategory/$categoryId?page=$page&limit=1&discussionLimit=10&discussionPage=$discussionPage");

    print(
        "======================================> response ${response.responseJson}");
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
      print("========================================. $discussionPage");
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
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

    var response =
        await ApiService.postApi(ApiConstant.reply, body, header: header);

    if (response.statusCode == 201) {
      print("========================================> fgfgjhjh");
      replyController.clear();

      var item = discussionList[indexNumber];

      item.totalReplies = item.totalReplies + 1;
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

    print(header);

    var response =
        await ApiService.postApi(ApiConstant.discussions, body, header: header);

    if (response.statusCode == 201) {
      discussionController.clear();
      isAddDiscussion = true;
      update();
      print(
          "===========================================> respose ${response.responseJson}");

      addDiscussionModel =
          AddDiscussionModel.fromJson(jsonDecode(response.responseJson));

      var item = addDiscussionModel!.data!.attributes!;
      var data = Discussions(
          sId: item.sId,
          discussion: item.discussion,
          dislikes: item.dislikes,
          likes: item.likes,
          isLiked: false,
          isDisliked: false,
          totalReplies: 0,
          user: User(
              sId: PrefsHelper.clientId,
              image: PrefsHelper.myImage,
              fullName: PrefsHelper.myName));

      discussionList.add(data);

      isAddDiscussion = false;
      update();

      print("jkdhfsdjfjsdjfsjlf");
      print("========================================> fgfgjhjh");
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoadingDiscussion = false;
    update();
  }

  Future<void> addFavouriteRepo() async {
    isLoadingDiscussion = false;
    update();

    Map<String, String> body = {
      ///==================================> Discussion ID dite hobe<=====================================
      'question': "${questionAnsModel!.data!.attributes!.questions![0].sId}",
    };

    print("==========================================> body $body");

    var response = await ApiService.postApi(ApiConstant.favourite, body);

    if (response.statusCode == 201) {
      if (questionAnsModel!.data!.attributes!.questions![0].isFavourite! ==
          true) {
        questionAnsModel!.data!.attributes!.questions![0].isFavourite = false;
        update();
      } else {
        questionAnsModel!.data!.attributes!.questions![0].isFavourite = true;
        update();
      }

      print(
          "===========================================> respose ${response.responseJson}");
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoadingDiscussion = false;
    update();
  }

  Future<void> addReply(String id, int index) async {
    replyDiscussionID = id;
    indexNumber = index;
    isReplay = true;
    update();

    print("===========================================> id : $id");
  }

  discussionLike(String discussionId, int index) async {
    if (discussionList[index].isLiked == true) {
      discussionList[index].isLiked = false;
    } else {
      discussionList[index].isLiked = true;
    }

    update();

    print(
        "=========isLike ===================== ${discussionList[index].isLiked}");
    var body = {
      "type": "discussion", //it can be discussionn or reply
      "discussion": discussionId, //if type === discussion
      "user": PrefsHelper.clientId
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("dialogi-like", body, ack: (data) {
      isLike = true;
      update();

      var check = data['message'];

      if (check == "Liked successfully") {
        discussionList[index].likes = discussionList[index].likes + 1;
      } else {
        if (discussionList[index].likes != 0) {
          discussionList[index].likes = discussionList[index].likes - 1;
        }
      }

      isLike = false;
      update();

      print(
          "===============================================================> Received acknowledgment: $data");
      print(
          "===============================================================> discussionList[index].likes: ${discussionList[index].likes}");
    });
  }

  discussionDislike(String discussionId, int index) async {
    if (discussionList[index].isDisliked == true) {
      discussionList[index].isDisliked = false;
    } else {
      discussionList[index].isDisliked = true;
    }

    update();
    var body = {
      "type": "discussion", //it can be discussionn or reply
      "discussion": discussionId, //if type === discussion
      "user": PrefsHelper.clientId
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("dialogi-dislike", body, ack: (data) {
      isDislike = true;
      update();

      var check = data['message'];

      if (check == "Disliked successfully") {
        discussionList[index].dislikes = discussionList[index].dislikes + 1;
      } else {
        if (discussionList[index].dislikes != 0) {
          discussionList[index].dislikes = discussionList[index].dislikes - 1;
        }
      }

      isDislike = false;
      update();

      print(
          "===============================================================> Received acknowledgment: $data");
      print(
          "===============================================================> discussionList[index].dislikes: ${discussionList[index].likes}");
    });
  }

  getContextStatus() async {
    if (Homecontroller.status == Status.completed) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (Homecontroller.accessStatusModel!.data!.questionAccessNumber ==
              0) {
            Get.toNamed(AppRoutes.subscriptionsScreen);

            status = Status.error;
            update();
          }
        },
      );

      Homecontroller.status = Status.loading;
      update();

      var body = {
        "userId": PrefsHelper.clientId,
        "type": "question",
      };

      print("================================================> body $body");

      SocketServices.socket.emitWithAck("dialogi-content-access", body,
          ack: (data) {
        var check = data['status'];

        if (check == "Error") {
          Homecontroller.status = Status.error;
        } else {
          Homecontroller.accessStatusModel = AccessStatusModel.fromJson(data);
          Homecontroller.status = Status.completed;
        }

        print(
            "===============================================================> Received acknowledgment: $data");
      });
    } else {
      Homecontroller.getAccessStatus();
    }
  }
}
