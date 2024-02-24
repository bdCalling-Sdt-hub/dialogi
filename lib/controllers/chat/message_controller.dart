import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';
import '../../view/widgets/chat_model/chat_message_model.dart';

class MessageController extends GetxController {
  Status status = Status.completed;
  Status statusMore = Status.completed;

  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> messages = [];

  MessageModel messageModel = MessageModel();

  int currentIndex = 0;
  int page = 1;

  bool isInputField = true;
  final TextEditingController messageController = TextEditingController();

  Future<void> scrollControllerCall(String chatId) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      statusMore = Status.loading;
      update();
      await getMessageRepo(chatId);
      statusMore = Status.completed;
      update();
    }
  }

  Future<void> getMessageRepo(String chatID) async {
    print("=====================================> page $page");

    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(
      "${ApiConstant.messages}?chatId=$chatID&page=$page&limit=15",
    );

    if (response.statusCode == 200) {
      messageModel = MessageModel.fromJson(jsonDecode(response.responseJson));

      for (var item in messageModel.data!.attributes!.messageList!) {
        // messages.add(ChatMessageModel(localTime(item.createdAt!), item.message!,
        //     PrefsHelper.clientId == item.sender!.sId ? true : false));


        messages.add(ChatMessageModel(time: localTime(item.createdAt!), text: item.message!, image: item.sender!.image!, isMe: PrefsHelper.clientId == item.sender!.sId ? true : false));
      }

      print("=======================> ${messages.length}");
      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }

  addNewMessage(String chatId) async {
    var body = {
      "chat": chatId,
      "message": messageController.text,
      "sender": PrefsHelper.clientId
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-message", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");
    });
  }

  listenMessage(String chatId) async {
    SocketServices.socket.on('new-message::$chatId', (data) {
      status = Status.loading;
      update();

      var time = localTime(data['createdAt']);

      // messages.insert(0, ChatMessageModel(time, data['message'], false));
      messages.insert(0, ChatMessageModel(time: time, text: data['message'], image: data['sender']['image'], isMe: false));

      status = Status.completed;
      update();

      print(
          "============================================>messages ${messages.length}");
    });
  }

  String localTime(String createdAt) {
    DateTime localTime = DateTime.parse(createdAt).toLocal();
    var time = localTime.toString().split(" ")[1];
    var hour = time.split(":")[0];
    var minute = time.split(":")[1].split(":")[0];

    return "$hour:$minute";
  }
}