import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChatList extends StatelessWidget {
  const CustomChatList(
      {super.key,
      required this.image,
      required this.text,
      required this.description,
      required this.onTap});

  final String image;
  final String text;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 76.h,
              width: 76.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
                // shape: BoxShape.rectangle
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: text,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomText(
                    text: description,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
