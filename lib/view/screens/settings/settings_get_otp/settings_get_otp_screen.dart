import 'package:dialogi_app/controllers/Auth/password_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../helper/prefs_helper.dart';

class SettingsGetOtp extends StatelessWidget {
  SettingsGetOtp({super.key});

  // PasswordController passwordController = Get.find<PasswordController>();
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
            text: AppStrings.getOTP.tr,
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
                  ///otp text
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: AppStrings.weHavesentaverificationcode.tr,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    bottom: 44.h,
                  ),

                  ///pin code
                  PinCodeTextField(
                    controller: passwordController.settingsOtpController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    cursorColor: Colors.black,
                    appContext: (context),
                    validator: (value) {
                      if (value!.length <= 6) {
                        return null;
                      } else {
                        return "Please enter the OTP code.".tr;
                      }
                    },
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 56.h,
                      fieldWidth: 44.w,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      borderWidth: 0.1,
                      errorBorderColor: AppColors.blue_300,
                      selectedColor: AppColors.blue_300,
                      activeColor: AppColors.blue_300,
                      inactiveColor: AppColors.blue_300,
                    ),
                    length: 6,
                    enableActiveFill: true,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  PrefsHelper.localizationCountryCode == "DE"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              text: AppStrings.didntReceivetheCode.tr,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.blue_500,
                            ),
                            passwordController.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : GestureDetector(
                                    onTap: () {
                                      passwordController.settingsOtpController
                                          .clear();
                                      passwordController
                                          .settingsForgetPasswordRepo();
                                    },
                                    child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: AppStrings.resend.tr,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.blue_500,
                                    ),
                                  ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              text: AppStrings.didntReceivetheCode.tr,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.blue_500,
                            ),
                            passwordController.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : GestureDetector(
                                    onTap: () {
                                      passwordController.settingsOtpController
                                          .clear();
                                      passwordController
                                          .settingsForgetPasswordRepo();
                                    },
                                    child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: AppStrings.resend.tr,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.blue_500,
                                    ),
                                  ),
                          ],
                        ),
                  const Spacer(),

                  ///<<<======================= Verify Button =====================>>>

                  passwordController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          buttonWidth: Get.width,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              passwordController.settingsVerifyOtpRepo();
                            }
                          },
                          titleText: AppStrings.verify.tr)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
