import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_button.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.noInternet.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Icon(
              Icons.wifi_off,
              size: 100,
            )),
            CustomText(
              text: AppStrings.noInternet.tr,
              fontSize: 18.sp,
              top: 16.h,
            ),
            CustomText(
              text: AppStrings.checkInternet.tr,
              top: 8.h,
              bottom: 20.h,
            ),
            CustomButton(
              onPressed: () => Get.back(),
              titleText: AppStrings.back.tr,
              buttonWidth: 80.w,
              buttonHeight: 40.h,
              buttonBgColor: AppColors.black_600,
            )
          ],
        ),
      ),
    );
  }
}
