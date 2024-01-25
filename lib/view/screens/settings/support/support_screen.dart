import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const CustomImage(
                    imageSrc: AppIcons.chevronLeft,
                    size: 24,
                  ),
                ),
                CustomText(
                  text: AppStrings.support ,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.h,
                  color: AppColors.blue_500,
                ),
                const SizedBox()
              ],
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
          child: Column(
            children: [
              CustomText(
                textAlign: TextAlign.start,
                maxLines: 10,
                text:  '1. Lorem ipsum dolor sit amet consectetur. Imperdiet iaculis convallis bibendum massa id elementum consectetur neque mauris.',
                fontSize: 16.h,
                bottom: 16.h,
              ),
              CustomText(
                textAlign: TextAlign.start,
                maxLines: 10,
                text:  '2. Lorem ipsum dolor sit amet consectetur. Imperdiet iaculis convallis bibendum massa id elementum consectetur neque mauris.',
                fontSize: 16.h,
                bottom: 16.h,
              ),
              CustomText(
                textAlign: TextAlign.start,
                maxLines: 10,
                text:  '3. Lorem ipsum dolor sit amet consectetur. Imperdiet iaculis convallis bibendum massa id elementum consectetur neque mauris.',
                fontSize: 16.h,
                bottom: 16.h,
              ),
              CustomText(
                textAlign: TextAlign.start,
                maxLines: 10,
                text:  '4. Lorem ipsum dolor sit amet consectetur. Imperdiet iaculis convallis bibendum massa id elementum consectetur neque mauris.',
                fontSize: 16.h,
                bottom: 16.h,
              ),

            ],
          ),
        )
    );
  }
}
