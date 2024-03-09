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

class SettingsResetPasswordScreen extends StatelessWidget {
  SettingsResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
            text: AppStrings.resetPassword.tr,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: GetBuilder<PasswordController>(
        builder: (passwordController) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppStrings.passwordMustHave.tr,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.h,
                    bottom: 24.h,
                  ),

                  ///<<<================ password text field =====================>>>

                  CustomTextField(
                    textEditingController:
                        passwordController.settingsPasswordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return ApiStaticStrings.fieldCantBeEmpty.tr;
                      } else if (value.length < 8) {
                        return ApiStaticStrings.passMustContainBoth.tr;
                      } else if (!ApiStaticStrings.passRegExp.hasMatch(value)) {
                        return ApiStaticStrings.passMustContainBoth.tr;
                      } else {
                        return null;
                      }
                    },
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    hintText: AppStrings.enteryourpassword.tr,
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

                  ///<<<================ confirm password field ==================>>>

                  CustomTextField(
                    textEditingController: passwordController.confirmPasswordController,
                    validator: (value) {
                      if(value != passwordController.settingsPasswordController.text){
                        return ApiStaticStrings.passDoesNotMatch.tr;
                      } else {
                        return null;
                      }
                    },
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    hintText: AppStrings.reenteryourpassword.tr,
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
                  const Spacer(),
                  passwordController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          buttonWidth: Get.width,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              passwordController.settingsResetPasswordRepo();
                            }
                          },
                          titleText: AppStrings.reset.tr),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
      //   child: CustomElevatedButton(onPressed: (){
      //     if(_formKey.currentState!.validate()){
      //       passwordController.settingsResetPasswordRepo();
      //     }
      //   }, titleText: AppStrings.reset),
      // ),
    );
  }
}
