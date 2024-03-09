import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_out_controller.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/image/custom_image.dart';
import '../../../../widgets/text/custom_text.dart';

class LogOut {
  static Widget customRow({required String icon, required String text}) {
    return GestureDetector(
      onTap: showLogOutPopup,
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            CustomImage(
              imageSrc: icon,
              size: 24.sp,
            ),
            CustomText(
              text: text,
              left: 16.w,
            )
          ],
        ),
      ),
    );
  }

  static showLogOutPopup() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.areYouSure.tr),
          actions: [
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.blue_500),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  PrefsHelper.removeAllPrefData();
                  SignOutController.googleSignOut();
                },
                child: Text(AppStrings.yes.tr, style: TextStyle(color: AppColors.whiteColor),)),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.blue_500),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.no.tr, style: TextStyle(color: AppColors.whiteColor),)),
          ],
        );
      },
    );
  }
}
