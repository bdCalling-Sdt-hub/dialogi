
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

import '../../../../../controllers/Auth/sign_up_controller.dart';
import '../../../../../utils/api_static_string.dart';

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        appBarContent: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const CustomImage(
              imageSrc: AppIcons.chevronLeft,
              size: 24,
            )),
      ),

      body: GetBuilder<SignUpController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///<<<====================Set password text=========================>>>
                    CustomText(
                      text: AppStrings.setPassword,
                      color: AppColors.blue_500,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      top: 24.h,
                      bottom: 8.h,
                    ),

                    ///fp text
                    CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      text: AppStrings.passwordshouldBe,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      bottom: 44.h,
                    ),

                    ///<<<=================Password field==============================>>>

                    CustomTextField(
                      textEditingController: controller.passWordController,
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
                      hintText: AppStrings.enteryourpassword,
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

                    ///<<<===================Re-enter password field========================>>>

                    CustomTextField(
                      textEditingController: controller.confirmPassWordController,
                      validator: (value) {
                        if(value != controller.passWordController.text){
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
                  ],
                ),
              ),
            );
          },),

      ///<<<================= Get Otp Button ==========================>>>

      bottomNavigationBar: GetBuilder<SignUpController>(
        builder: (controller) {
          return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: controller.signUpLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  controller.signUpUser();
                }
              },
              titleText: AppStrings.continuee),
        );
      },),
    );
  }
}
