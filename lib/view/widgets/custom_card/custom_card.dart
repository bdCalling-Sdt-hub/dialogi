import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String img;
  final String title;
  final String queNum;

  const CustomCard(
      {super.key,
      required this.img,
      required this.title,
      required this.queNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.whiteColor),
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          //Image

          Expanded(
            flex: 2,
            child: Container(
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          //Title

          Expanded(
            child: Column(
              children: [
                CustomText(
                  top: 8.h,
                  bottom: 14.h,
                  fontSize: 18,
                  text: title,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_500,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Question Test

                    CustomText(
                      right: 8.w,
                      text: AppStrings.ques,
                      color: AppColors.black_300,
                    ),

                    //Number of Question

                    CustomText(
                      fontWeight: FontWeight.w500,
                      text: queNum,
                      // color: AppColors.blue_500,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
