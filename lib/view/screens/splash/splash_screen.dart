import 'dart:async';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/device_utils.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    Timer(const Duration(seconds: 2), () {
      getLoggedIn();
    });
    super.initState();
  }

  Future<void> getLoggedIn() async {
    print(
        "====================================================>token ${PrefsHelper.token}");

    try {
      // Get.toNamed(AppRoutes.premiumScreen);
      if (PrefsHelper.token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Get.offAllNamed(AppRoutes.signInScreen);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              imageSrc: AppImages.splashLogo,
              imageType: ImageType.png,
              size: 60,
            ),
            SizedBox(
              height: 16,
            ),
            CustomText(
              text: 'Dialogi',
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: AppColors.blue_500,
            )
          ],
        ),
      ),
    );
  }
}
