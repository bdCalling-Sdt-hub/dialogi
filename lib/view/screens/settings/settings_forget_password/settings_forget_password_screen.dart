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

class SettingsForgetPasswordScreen extends StatefulWidget {
  const SettingsForgetPasswordScreen({super.key});

  @override
  State<SettingsForgetPasswordScreen> createState() =>
      _SettingsForgetPasswordScreenState();
}

class _SettingsForgetPasswordScreenState
    extends State<SettingsForgetPasswordScreen> {

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
            text: AppStrings.forgotPassword.tr,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: GetBuilder<PasswordController>(
        builder: (passwordController) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: AppStrings.pleaseEnteryourEmailAddresstoreset.tr,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  bottom: 44.h,
                ),

                ///<<<================= Email Text Field =======================>>>

                CustomTextField(
                  // textEditingController: passwordController.settingsEmailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ApiStaticStrings.enterEmail.tr;
                    } else if (!ApiStaticStrings.emailRegexp
                        .hasMatch("passwordController.settingsEmailController.text")) {
                      return ApiStaticStrings.enterValidEmail.tr;
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.email.tr,
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
                    Icons.mail_outline,
                    size: 24.h,
                    color: AppColors.blue_500,
                  ),
                ),

                ///<<<====================Get otp button ====================>>>
              ],
            ),
          ),
        );
      },),
      bottomNavigationBar: GetBuilder<PasswordController>(
        builder: (passwordController) {
          return passwordController.isLoading?
          const Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                child: CustomElevatedButton(
                buttonWidth: Get.width,
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    passwordController.settingsForgetPasswordRepo();
                  }
                },
                titleText: AppStrings.getOTP.tr),
              );
      },),
    );
  }
}
