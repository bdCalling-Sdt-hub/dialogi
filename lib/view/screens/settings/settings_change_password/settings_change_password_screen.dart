import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsChangePasswordScreen extends StatefulWidget {
  const SettingsChangePasswordScreen({super.key});

  @override
  State<SettingsChangePasswordScreen> createState() => _SettingsChangePasswordScreenState();
}

class _SettingsChangePasswordScreenState extends State<SettingsChangePasswordScreen> {
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
                child: CustomImage(
                  imageSrc: AppIcons.chevronLeft,
                  size: 24,
                ),
              ),
              CustomText(
                text: AppStrings.changePassword,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Current password
            CustomTextField(
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.currentpassword,
              hintStyle: GoogleFonts.prompt(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_300),
              inputTextStyle: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  color: AppColors.black_500),
              fieldBorderColor: Colors.white,
              fieldBorderRadius: 8,
              isPrefixIcon: true,
              prefixIcon: Icon(
                Icons.lock_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
            SizedBox(height: 24.h,),

            ///New password
            CustomTextField(
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.newpassword,
              hintStyle: GoogleFonts.prompt(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_300),
              inputTextStyle: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  color: AppColors.black_500),
              fieldBorderColor: Colors.white,
              fieldBorderRadius: 8,
              isPrefixIcon: true,
              prefixIcon: Icon(
                Icons.lock_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),

            SizedBox(height: 24.h,),

            ///Re-enter new password
            CustomTextField(
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.reenteryourpassword,
              hintStyle: GoogleFonts.prompt(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_300),
              inputTextStyle: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  color: AppColors.black_500),
              fieldBorderColor: Colors.white,
              fieldBorderRadius: 8,
              isPrefixIcon: true,
              prefixIcon: Icon(
                Icons.lock_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.settingsForgetPasswordScreen);
              },
              child: CustomText(
                text: AppStrings.forgetPassword,
                fontWeight: FontWeight.w500,
                fontSize: 18.h,
                color: AppColors.red_500,
                top: 24.h,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: CustomElevatedButton(onPressed: (){
          Get.toNamed(AppRoutes.settingsScreen);
        }, titleText: AppStrings.update),
      ),
    );
  }
}
