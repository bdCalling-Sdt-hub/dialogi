import 'package:dialogi_app/controllers/Auth/password_controller.dart';
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

import '../../../../utils/api_static_string.dart';

class SettingsChangePasswordScreen extends StatelessWidget {
  SettingsChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  PasswordController passwordController = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      ///<<<=========================== App Bar ==============================>>>

      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const CustomImage(
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
          const SizedBox()
        ],
      )),

      ///<<<=========================== Body ==============================>>>

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///<<<==================== Current password ======================>>>

              CustomTextField(
                textEditingController: passwordController.currentPasswordController,
                // validator: (value) {
                //   if(value != passwordController.passwordController.text){
                //     return ApiStaticStrings.wrongPassword;
                //   } else if(value!.isEmpty){
                //     return ApiStaticStrings.fieldCantBeEmpty;
                //   } return null;
                // },
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
              SizedBox(
                height: 24.h,
              ),

              ///<<<======================= New password =======================>>>

              CustomTextField(
                textEditingController: passwordController.newPasswordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return ApiStaticStrings.fieldCantBeEmpty;
                  } else if (value.length < 8) {
                    return ApiStaticStrings.passwordLength;
                  } else if (!ApiStaticStrings.passRegExp.hasMatch(value)) {
                    return ApiStaticStrings.passMustContainBoth;
                  } else {
                    return null;
                  }
                },
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

              SizedBox(
                height: 24.h,
              ),

              ///<<<================= Re-enter new password ====================>>>

              CustomTextField(
                textEditingController: passwordController.reEnterNewPasswordController,
                validator: (value) {
                  if(value != passwordController.newPasswordController.text){
                    return ApiStaticStrings.passDoesNotMatch;
                  } else {
                    return null;
                  }
                },
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

              ///<<<======================= Forget Password ====================>>>

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.settingsForgetPasswordScreen);
                },
                child: CustomText(
                  text: AppStrings.forgotPassword,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.h,
                  color: AppColors.red_500,
                  top: 24.h,
                ),
              ),
              Spacer(),

              ///<<<===================== Update Button ========================>>>

              CustomElevatedButton(
                buttonWidth: Get.width,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      passwordController.changePasswordRepo();
                    }
                  },
                  titleText: AppStrings.update
              )
            ],
          ),
        ),
      ),
    );
  }
}
