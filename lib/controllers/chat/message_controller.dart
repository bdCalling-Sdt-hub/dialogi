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
  bool isMessage = false;

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

      print("==========================> respone ${response.responseJson}");

      for (var item in messageModel.data!.attributes!.messageList!) {
        // messages.add(ChatMessageModel(localTime(item.createdAt!), item.message!,
        //     PrefsHelper.clientId == item.sender!.sId ? true : false));

        messages.add(ChatMessageModel(
            time: localTime(item.createdAt!),
            isQuestion: item.messageType == "question" ? true : false,
            text: item.message!,
            image: item.sender!.image!,
            isNotice: item.messageType == "notice" ? true : false,
            isMe: PrefsHelper.clientId == item.sender!.sId ? true : false));
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
    TimeOfDay currentTime = TimeOfDay.now();

    isMessage = true;
    update();

    messages.insert(
        0,
        ChatMessageModel(
            time: currentTime.format(Get.context!).toString(),
            text: messageController.text,
            image: PrefsHelper.myImage,
            isMe: true)

        // ChatMessageModel(
        //     currentTime.format(context).toString(),
        //     controller.messageController.text,
        //     true),
        );

    isMessage = false;
    update();

    print("====================================> image ${PrefsHelper.myImage}");

    var body = {
      "chat": chatId,
      "message": messageController.text,
      "sender": PrefsHelper.clientId
    };

    print("================================================> body $body");
    messageController.clear();

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
      messages.insert(
          0,
          ChatMessageModel(
              isQuestion: data['messageType'] == "question" ? true : false,
              isNotice: data['messageType'] == "notice" ? true : false,
              time: time,
              text: data['message'],
              image: data['sender']['image'],
              isMe: false));

      status = Status.completed;
      update();

      print(
          "============================================>messages ${messages.length}");
      print("============================================>data $data");
    });
  }

  String localTime(String createdAt) {
    DateTime localTime = DateTime.parse(createdAt).toLocal();
    var time = localTime.toString().split(" ")[1];
    var hour = time.split(":")[0];
    var minute = time.split(":")[1].split(":")[0];

    return "$hour:$minute";
  }

  void isEmoji(int index) {
    currentIndex = index;
    isInputField = isInputField;
    update();
  }
}
