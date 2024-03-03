import 'dart:convert';

import 'package:dialogi_app/helper/local_time.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../models/chat_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';

class ChatListController extends GetxController {
  Status status = Status.completed;

  Status statusMore = Status.completed;

  int page = 1;

  List chatList = [];

  ChatModel chatModel = ChatModel();

  ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      statusMore = Status.loading;
      update();
      await chatRepo();
      statusMore = Status.completed;
      update();
    } else {
      print(
          "======================================================> sdfdsjfdsklfjdslkfjsfjlksdjlkf");
    }
  }

  Future<void> chatRepo() async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi("${ApiConstant.chats}?page=$page");

    if (response.statusCode == 200) {
      print(response.responseJson);
      chatModel = ChatModel.fromJson(jsonDecode(response.responseJson));

      if (chatModel.data?.attributes?.chatList != null &&
          chatModel.data!.attributes!.chatList!.isNotEmpty) {
        chatList.addAll(chatModel.data!.attributes!.chatList!);
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

  listenMessage() async {
    SocketServices.socket.on("update-chatlist::${PrefsHelper.clientId}",
        (data) {

      status = Status.loading;
      update();


      page = 1 ;
      ChatListModel chatListModel;
      chatListModel = ChatListModel.fromJson(data) ;
      if(chatListModel.chatList != null) {

        chatList.clear() ;
        chatList.addAll(chatListModel.chatList!);

        print("============================================>${data}");
      }



      status = Status.completed;
      update();
    });
  }
}
