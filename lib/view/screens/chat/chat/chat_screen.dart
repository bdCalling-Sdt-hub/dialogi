import 'package:dialogi_app/controllers/chat/message_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/chat_model/chat_bubble_message.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../group_chat/group_chat/grp_chat_appbar/grp_chat_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessageController chatController = Get.put(MessageController());

  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String type = Get.parameters["type"] ?? "";

  @override
  void initState() {
    chatController.listenMessage(chatId);
    chatController.getMessageRepo(chatId);
    chatController.scrollController.addListener(() {
      chatController.scrollControllerCall(chatId);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("==============================================> chatId $chatId");
    return GetBuilder<MessageController>(builder: (controller) {
      return switch (controller.status) {
        Status.loading => const Center(child: CircularProgressIndicator()),
        Status.error =>
          ErrorScreen(onTap: () => controller.getMessageRepo(chatId)),
        Status.completed => Scaffold(
            appBar: CustomAppBar(
                appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CustomImage(
                      imageSrc: AppIcons.chevronLeft,
                      size: 24,
                    )),
                CustomText(
                  left: 25.w,
                  text: name,
                  fontSize: 18.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_500,
                ),
                type == "single" ? const SizedBox() : const GroupChatPopUps()
              ],
            )),
            body: controller.isMessage ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = controller.messages[index];

                  return ChatBubbleMessage(
                    index: index,
                    image: message.image,
                    messageIndex: controller.currentIndex,
                    isEmoji: controller.isInputField,
                    onpress: () {
                      setState(() {
                        controller.currentIndex = index;
                        controller.isInputField = controller.isInputField;
                      });
                    },
                    time: message.time,
                    text: message.text,
                    isMe: message.isMe,
                  );
                }),
            bottomNavigationBar: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: CustomTextField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          hintText: AppStrings.typemessage,
                          hintStyle: GoogleFonts.prompt(
                              fontSize: 14.h,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_300),
                          inputTextStyle: GoogleFonts.prompt(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.h,
                              color: AppColors.black_500),
                          fieldBorderColor: Colors.white,
                          fieldBorderRadius: 8,
                          textEditingController: controller.messageController,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (controller.messageController.text != "") {
                              controller.addNewMessage(chatId);
                            }
                          },
                          child: const CustomImage(
                            imageSrc: AppIcons.send,
                            imageType: ImageType.svg,
                            size: 32,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            )),
      };
    });
  }
}
