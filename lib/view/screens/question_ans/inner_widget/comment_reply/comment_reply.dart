import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentReply extends StatelessWidget {
  const CommentReply({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                text: AppStrings.discussions,
              ),
              GestureDetector(
                  onTap: () {},
                  child: const CustomImage(imageSrc: AppIcons.share)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: CustomTextField(
                hintText: AppStrings.enterTextHere,
              )),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: GestureDetector(
                    onTap: () {},
                    child: const CustomImage(imageSrc: AppIcons.send)),
              )
            ],
          ),
        )
      ],
    );
  }
}
