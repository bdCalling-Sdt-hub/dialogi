import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            imageSrc: AppIcons.chevronLeft,
            size: 24,
          ),
          CustomText(
            text: 'Settings',
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          SizedBox()
        ],
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1,color: AppColors.black_50)
                  )
                ),
                child: Row(
                  children: [
                    CustomImage(imageSrc: AppIcons.lock,size: 18,),
                    SizedBox(width: 16.w,),
                    CustomText(
                      text: 'Settings',
                      fontSize: 18.h,
                    ),
                    Spacer(),
                    CustomImage(imageSrc: AppIcons.chevronRight,size: 24,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
