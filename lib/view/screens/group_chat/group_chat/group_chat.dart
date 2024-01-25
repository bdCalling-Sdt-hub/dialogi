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
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessageModel> messages = [
    ChatMessageModel('03.20', 'What does friendship mean to you!', false,
        isQuestion: true),
    ChatMessageModel('03.20', 'Hello!', false),
    ChatMessageModel('11.05', 'Hi there!', true),
    ChatMessageModel('08.25', 'How are you?', false),
  ];

  int currentIndex = 0;

  bool isInputField = true;
  final TextEditingController messageController = TextEditingController();
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final message = messages[index];

            return ChatBubbleMessage(
              index: index,
              messageIndex: currentIndex,
              isEmoji: !isInputField,
              isQuestion: message.isQuestion,
              onpress: () {
                setState(() {
                  currentIndex = index;
                  isInputField = !isInputField;
                });
              },
              time: message.sender,
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
                      textEditingController: messageController,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (messageController.text == "") {
                        } else {
                          TimeOfDay currentTime = TimeOfDay.now();
                          messages.add(
                            ChatMessageModel(
                                currentTime.format(context).toString(),
                                messageController.text,
                                true),
                          );
                          setState(() {
                            _scrollToBottom();
                            messageController.clear();
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
        ));
  }
}
