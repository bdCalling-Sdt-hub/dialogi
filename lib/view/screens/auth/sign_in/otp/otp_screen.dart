import 'package:dialogi_app/controllers/Auth/password_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_up_controller.dart';
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

import '../../../../../helper/prefs_helper.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

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
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///<<<================Get otp text=============================>>>

                  CustomText(
                    text: AppStrings.getOTP.tr,
                    color: AppColors.blue_500,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    top: 24.h,
                    bottom: 8.h,
                  ),

                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: AppStrings.weHavesentaverificationcode.tr,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    bottom: 44.h,
                  ),

                  ///<<<====================Otp pin code field==========================>>>
                  PinCodeTextField(
                    autoDisposeControllers: false,
                    controller: controller.otpController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    appContext: (context),
                    validator: (value) {
                      if (value!.length != 6) {
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

                  ///didn't receive the code
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
                            InkWell(
                                    onTap: () {
                                      controller.settingsOtpController.clear();
                                      controller.forgetPasswordRepo();
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
                            InkWell(
                                    onTap: () {
                                      controller.otpController.clear();
                                      controller.forgetPasswordRepo(isResend: true);
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
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<PasswordController>(builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: CustomElevatedButton(
              buttonWidth: Get.width,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.verifyOtpRepo();
                }
              },
              titleText: AppStrings.verify.tr),
            );
      },),
    );
  }
}
