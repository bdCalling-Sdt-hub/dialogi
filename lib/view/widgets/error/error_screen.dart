import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const CustomImage(imageSrc: AppImages.noInternetImage),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppStrings.somethingWrong,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.black_500),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue_500,
                minimumSize: Size(Get.width / 1.6, 40.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32.r),
                  bottomLeft: Radius.circular(32.r),
                ))),
            child: Text(
              AppStrings.tryAgain,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
