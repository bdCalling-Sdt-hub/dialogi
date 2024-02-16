import 'package:dialogi_app/controllers/Auth/password_controller.dart';
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

import '../../../../../utils/api_static_string.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

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
      body: GetBuilder<PasswordController>(
        builder: (controller) {
        return  Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///<<<======================forget pass text==========================>>>
                CustomText(
                  text: AppStrings.forgotPassword,
                  color: AppColors.blue_500,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  top: 24.h,
                  bottom: 8.h,
                ),

                ///fp text
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: AppStrings.pleaseEnteryourEmailAddresstoreset,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  bottom: 44.h,
                ),

                ///<<<========================email field=================================>>>
                CustomTextField(
                  textEditingController: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ApiStaticStrings.enterEmail;
                    } else if (!ApiStaticStrings.emailRegexp
                        .hasMatch(controller.emailController.text)) {
                      return ApiStaticStrings.enterValidEmail;
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.enterYourEmail,
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
                const Spacer(),
                ///<<<========================Get Otp Button============================>>>
                controller.isLoading? const Center(child: CircularProgressIndicator())
                  : CustomElevatedButton(
                    buttonWidth: Get.width,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        controller.forgerPasswordRepo();
                      }
                    },
                    titleText: AppStrings.getOTP)
              ],
            ),
          ),
        );
      },),
      // bottomNavigationBar: GetBuilder<ForgetPasswordController>(builder: (controller) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      //     child: CustomElevatedButton(
      //         onPressed: () {
      //           if(isFormKeyValidate){
      //             controller.forgerPasswordRepo();
      //           }
      //         },
      //         titleText: AppStrings.getOTP),
      //   );
      // },),
    );
  }
}
