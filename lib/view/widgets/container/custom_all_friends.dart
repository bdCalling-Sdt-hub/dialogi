import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAllFriends extends StatelessWidget {
  const CustomAllFriends(
      {super.key,
      required this.imageSrc,
      required this.text,
      required this.icon,
      required this.onTap});

  final VoidCallback onTap;
  final String text;
  final String icon;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: AppColors.black_50))),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(imageSrc)),
                  shape: BoxShape.circle),
            ),
            SizedBox(
              width: 16.w,
            ),
            CustomText(
              text: text,
              fontSize: 18.h,
            ),
            const Spacer(),
            CustomImage(
              imageSrc: icon,
              size: 24,
              imageColor: AppColors.blue_500,
            ),
          ],
        ),
      ),
    );
  }
}
