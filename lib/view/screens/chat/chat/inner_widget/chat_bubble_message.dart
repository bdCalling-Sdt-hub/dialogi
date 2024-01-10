
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';

class ChatBubbleMessage extends StatefulWidget {
  final String time;
  final String text;
  final bool isMe;
  final bool isEmoji;
  final int index;
  final int messageIndex;
  final VoidCallback onpress;

  const ChatBubbleMessage(
      {super.key,
        required this.time,
        required this.text,
        required this.isMe,
        required this.onpress,
        this.isEmoji = false,
        this.index = 0,
        this.messageIndex = 1});

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
          Row(
            mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isMe == false)
                const CustomImage(
                  size: 36,
                  imageSrc: AppImages.john,
                  imageType: ImageType.png,
                ),
              const SizedBox(
                width: 8,
              ),
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
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: widget.isMe ? AppColors.blue_500 : AppColors.whiteColor,
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

                        ],
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
                const CustomImage(
                  size: 36,
                  imageSrc: AppImages.profile,
                  imageType: ImageType.png,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

