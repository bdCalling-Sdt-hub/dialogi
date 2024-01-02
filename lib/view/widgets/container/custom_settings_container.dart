import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingsContainer extends StatelessWidget {
  const CustomSettingsContainer({super.key,required this.onTap, required this.imageSrc,required this.text,required this.icon});

  final VoidCallback ?onTap;
  final String imageSrc;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1,color: AppColors.black_50)
            )
        ),
        child: Row(
          children: [
             CustomImage(imageSrc: imageSrc,size: 18,),
            SizedBox(width: 16.w,),
            CustomText(
              text: text,
              fontSize: 18.h,
            ),
             Spacer(),
             CustomImage(imageSrc: icon,size: 24,),
          ],
        ),
      ),
    );
  }
}
