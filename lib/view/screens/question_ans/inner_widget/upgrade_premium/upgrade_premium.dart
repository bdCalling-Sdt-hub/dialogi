import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpgradePremium extends StatelessWidget {
  const UpgradePremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///upgrade premium

        CustomText(
          text: AppStrings.wanttojointhediscussion,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.purchaseScreen);
          },
          child: CustomText(
            text: AppStrings.upgradetoPremium,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blue_500,
          ),
        ),
      ],
    );
  }
}
