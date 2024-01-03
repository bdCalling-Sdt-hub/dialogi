import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumText extends StatelessWidget {
  const PremiumText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          top: 50.h,
          fontWeight: FontWeight.w500,
          text: AppStrings.wanttojointhediscussion,
        ),
        GestureDetector(
          onTap: () {},
          child: CustomText(
            top: 8.h,
            fontSize: 18,
            color: AppColors.blue_500,
            fontWeight: FontWeight.w500,
            text: AppStrings.upgradetoPremium,
          ),
        ),
      ],
    );
  }
}
