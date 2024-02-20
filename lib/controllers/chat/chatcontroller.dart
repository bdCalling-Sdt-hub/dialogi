import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';
import '../../view/widgets/chat_model/chat_message_model.dart';

class ChatController extends GetxController {
  bool isLoading = false;

  List chatList = [];

  int page = 1;

  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> messages = [
    ChatMessageModel('03.20', 'Hello!', false),
    ChatMessageModel('11.05', 'Hi there!', true),
    ChatMessageModel('08.25', 'How are you?', false),
  ];

  int currentIndex = 0;

  bool isInputField = true;
  final TextEditingController messageController = TextEditingController();

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }

  addNewMessage() async {
    var body = {
      "chat": "65c737a68232196334a2bac5",
      "message": "Hello all",
      "sender": "65c5ebae58a33b0e714e39af"
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-message", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");
    });
  }


  listenMessage() async {
    SocketServices.socket.on('chat-notification::${PrefsHelper.clientId}', (data) {
      print("================> get Data on socket: $data");
    });
  }








}
