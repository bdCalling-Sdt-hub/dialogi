import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController with GetxServiceMixin {
  void showPopUpPremiumPackage() {
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
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onPressed: () {},
                      titleText: AppStrings.gotoSubscriptions),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void onReady() {
    showPopUpPremiumPackage();
    super.onReady();
  }
}
