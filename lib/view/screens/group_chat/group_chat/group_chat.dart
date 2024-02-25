import 'package:dialogi_app/controllers/group_chat/group_chat_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/group_chat/group_chat/grp_chat_appbar/grp_chat_appbar.dart';
import 'package:dialogi_app/view/widgets/chat_model/chat_bubble_message.dart';
import 'package:dialogi_app/view/widgets/chat_model/chat_message_model.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  String chatId = Get.parameters["chatId"] ?? "";

  GroupChatController groupChatController = Get.put(GroupChatController());

  void _scrollToBottom() {
    groupChatController.scrollController.animateTo(
      groupChatController.scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }


  @override
  void initState() {

    groupChatController.listenMessage(chatId) ;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("===============================================>chatId $chatId");
    return GetBuilder<GroupChatController>(
      builder: (controller) {
        return switch (controller.status) {
          Status.loading => throw UnimplementedError(),
          Status.error => throw UnimplementedError(),
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
                    text: AppStrings.community,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue_500,
                  ),
                  const GroupChatPopUps()
                ],
              )),
              body: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = controller.messages[index];

                  return ChatBubbleMessage(
                    index: index,
                    image: message.image,
                    messageIndex: controller.currentIndex,
                    isEmoji: controller.isInputField,
                    isQuestion: message.isQuestion,
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
                },
              ),
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

                        //===========================Text Input Field=========================

                        Expanded(
                          child: CustomTextField(
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
                              if (controller.messageController.text == "") {
                              } else {
                                TimeOfDay currentTime = TimeOfDay.now();
                                controller.messages.add(ChatMessageModel(
                                        time: currentTime
                                            .format(context)
                                            .toString(),
                                        text: controller.messageController.text,
                                        image: PrefsHelper.myImage,
                                        isMe: true)

                                    // ChatMessageModel(
                                    //     currentTime.format(context).toString(),
                                    //     messageController.text,
                                    //     true),
                                    );
                                setState(() {
                                  _scrollToBottom();
                                  controller.messageController.clear();
                                });
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
                      height: 24.h,
                    ),
                  ],
                ),
              )),
        };
      },
    );
  }
}
