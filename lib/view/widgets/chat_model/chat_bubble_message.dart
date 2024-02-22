import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubbleMessage extends StatefulWidget {
  final String time;
  final String text;
  final String image;
  final bool isMe;
  final bool isEmoji;
  final int index;
  final int messageIndex;
  final bool isQuestion;
  final VoidCallback onpress;

  const ChatBubbleMessage(
      {super.key,
      required this.time,
      required this.text,
      required this.image,
      required this.isMe,
      required this.onpress,
      this.isEmoji = false,
      this.index = 0,
      this.messageIndex = 1,
      this.isQuestion = false});

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // //=======-============================Question====================================

          if (widget.isQuestion)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomImage(
                  size: 36,
                  imageSrc: AppImages.profile,
                  imageType: ImageType.png,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(left: 10.w),
                  width: 220,
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.blue_500,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: double.maxFinite,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.whiteColor),
                    child: const CustomText(
                      maxLines: 5,
                      text: "What does friendship mean to you?",
                    ),
                  ),
                )
              ],
            ),
          Row(
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isMe == false && widget.isQuestion == false)
                CircleAvatar(
                    backgroundColor: AppColors.background,
                    radius: 20.sp,
                    child: ClipOval(
                        child: Image.network(
                      "${ApiConstant.baseUrl}${widget.image}",
                    ))),
              const SizedBox(
                width: 8,
              ),
              if (widget.isQuestion == false)
                Expanded(
                  child: Column(
                    crossAxisAlignment: widget.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          widget.onpress();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: widget.isMe
                                ? AppColors.blue_500
                                : AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: widget.isMe
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                              bottomLeft: const Radius.circular(8),
                              bottomRight: const Radius.circular(8),
                              topRight: widget.isMe == false
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                            ),
                          ),
                          child: CustomText(
                            maxLines: 10,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w400,
                            text: widget.text,
                            color: widget.isMe
                                ? AppColors.whiteColor
                                : AppColors.black_500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        text: widget.time,
                        color: AppColors.black_500,
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                width: 8,
              ),
              if (widget.isMe)
                CircleAvatar(
                    backgroundColor: AppColors.background,
                    radius: 20.sp,
                    child: ClipOval(
                        child: Image.network(
                          "${ApiConstant.baseUrl}${widget.image}",
                        ))),            ],
          ),
        ],
      ),
    );
  }
}
