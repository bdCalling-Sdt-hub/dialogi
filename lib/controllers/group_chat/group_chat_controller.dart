import 'package:dialogi_app/global/api_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/socket_service.dart';
import '../../view/widgets/chat_model/chat_message_model.dart';

class GroupChatController extends GetxController {

  Status status = Status.completed ;
  final ScrollController scrollController = ScrollController();
  final List<ChatMessageModel> messages = [
    ChatMessageModel(
        time: "3:20",
        text: "What does friendship mean to you!",
        image: "/uploads/users/transferred-1708428924239.png",
        isMe: false,
        isQuestion: true),
    ChatMessageModel(
        time: "3:20",
        text: "Hello",
        image: "/uploads/users/transferred-1708428924239.png",
        isMe: false),
    ChatMessageModel(
        time: "3:20",
        text: "Hi there!",
        image: "/uploads/users/transferred-1708428924239.png",
        isMe: false),
    ChatMessageModel(
        time: "3:20",
        text: "How are you?",
        image: "/uploads/users/transferred-1708428924239.png",
        isMe: false),
  ];
  int currentIndex = 0;
  bool isInputField = true;
  final TextEditingController messageController = TextEditingController();



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
