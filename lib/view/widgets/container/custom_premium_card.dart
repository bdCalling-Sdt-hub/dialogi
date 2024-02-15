import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPremiumCard extends StatelessWidget {
  const CustomPremiumCard(
      {super.key,
      required this.imageSrc,
      required this.premiumText,
      required this.getDialogiText,
      this.isPremium = true,
      required this.length,
      required this.addText,
      this.addTextColor = AppColors.black_500,
      this.getDialogiTextColor = AppColors.black_500,
      this.premiumTextColor = AppColors.black_500});

  final String imageSrc;
  final String premiumText;
  final String getDialogiText;
  final bool isPremium;
  final int length;
  final String addText;
  final Color addTextColor;
  final Color getDialogiTextColor;
  final Color premiumTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      margin: const EdgeInsets.only(right: 16),
      width: MediaQuery.of(context).size.width - 90.w,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: isPremium ? AppColors.blue_50 : AppColors.black_500,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.blue_500, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImage(
                imageSrc: imageSrc,
                imageType: ImageType.png,
                size: 46,
              ),
              CustomText(
                text: premiumText,
                fontSize: 24.h,
                fontWeight: FontWeight.w500,
                left: 8,
                color: premiumTextColor,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(
            textAlign: TextAlign.start,
            maxLines: 2,
            text: getDialogiText,
            fontSize: 16.h,
            fontWeight: FontWeight.w500,
            color: getDialogiTextColor,
          ),
          SizedBox(
            height: 16.h,
          ),
          if (isPremium)
            SizedBox(
              height: 90.h,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        const CustomImage(
                          imageSrc: AppIcons.checkCircle,
                          imageType: ImageType.svg,
                          size: 16,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: addText,
                          left: 8,
                          color: addTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // if (isPremium)
          //   SizedBox(
          //     height: 40.h,
          //   ),
        ],
      ),
    );
  }
}