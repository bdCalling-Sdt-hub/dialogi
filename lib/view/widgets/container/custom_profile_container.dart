import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomProfileContainer extends StatelessWidget {
  const CustomProfileContainer({super.key, required this.text, required this.icon});

  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child:  Column(
        children: [
          Row(
            children: [
              CustomImage(imageSrc: icon,size: 18,),
              CustomText(
                text: text,
                fontSize: 16,
                left: 12,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
