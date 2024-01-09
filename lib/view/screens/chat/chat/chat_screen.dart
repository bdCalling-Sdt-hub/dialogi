import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/chat/chat/inner_widget/chat_bubble_message.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inner_widget/chat_message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessageModel> messages = [
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
              const CustomText(
                text: AppStrings.chat,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
              ),
              const SizedBox(),
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

          padding: EdgeInsets.symmetric(vertical: 24,horizontal:20),
            duration: Duration(seconds: 1),
            child:Row(
              children: [
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

                ),),
                SizedBox(width: 8.w,),

                GestureDetector(
                    onTap: (){
                      if (messageController.text == "") {
                      } else {
                        TimeOfDay currentTime = TimeOfDay.now();
                        messages.add(
                          ChatMessageModel(currentTime.format(context).toString(),
                              messageController.text, true),
                        );
                        setState(() {
                          _scrollToBottom();
                          messageController.clear();
                        });
                      }
                    },
                    child: CustomImage(imageSrc: AppIcons.send,imageType: ImageType.svg,size: 32,))
              ],
            ),
          )
    );
  }
}
