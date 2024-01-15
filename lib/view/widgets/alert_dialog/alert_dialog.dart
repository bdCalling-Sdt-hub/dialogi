import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertDialogs extends StatelessWidget {
  const AlertDialogs({super.key, required this.successtext, required this.completeText, required this.buttonText, required this.onPressed});
  final String successtext;
  final String completeText;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      title: Column (
        children: [
          CustomImage(imageSrc: AppIcons.greatJob,size: 50,),
          SizedBox(height: 24.h,),
          CustomText(
            text: successtext,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.blue_500,
          ),
          SizedBox(height: 8.h,),
          CustomText(
            maxLines: 2,
            text: completeText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 24.h,),
          CustomElevatedButton(
              buttonHeight: 40,
              titleSize: 14,
              onPressed: onPressed,
              titleText: buttonText),
        ],
      ),
    );
  }
}
