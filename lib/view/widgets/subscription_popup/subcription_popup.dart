import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/static_strings.dart';
import '../buttons/custom_elevated_button.dart';
import '../image/custom_image.dart';
import '../text/custom_text.dart';

class SubscriptionPopup {
  static void showPopUpPremiumPackage() {
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          child: Container(
            height: 300.h,
            width: 300.w,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.r),
                  //     child: CustomImage(imageSrc: AppIcons.cancel),
                  //   ),
                  // ),
                  CustomImage(
                    imageSrc: AppIcons.crown,
                    size: 60.r,
                  ),

                  const CustomText(
                    maxLines: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    text: AppStrings.upgradetoPremiumfor,
                  ),

                  CustomElevatedButton(
                      buttonHeight: 40,
                      titleSize: 14,
                      onPressed: () {
                        Get.toNamed(AppRoutes.subscriptionsScreen);
                      },
                      titleText: AppStrings.gotoSubscriptions),
                ],
              ),
            ),
          ),
        ));
  }
}
