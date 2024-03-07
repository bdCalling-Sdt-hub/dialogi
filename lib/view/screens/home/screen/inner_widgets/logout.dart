import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_out_controller.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
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
          title: Text("Are you sure"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PrefsHelper.removeAllPrefData();
                  SignOutController.googleSignOut();
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
          ],
        );
      },
    );
  }
}
