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
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        appBarContent: GestureDetector(
            onTap: (){
              Get.back();

            },
            child: const CustomImage(imageSrc: AppIcons.chevronLeft,size: 24,)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///get otp
            CustomText(
              text: AppStrings.getOTP,
              color: AppColors.blue_500,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              top: 24.h,
              bottom: 8.h,
            ),
            ///otp text
            CustomText(
              textAlign: TextAlign.start,
              maxLines: 3,
              text: AppStrings.weHavesentaverificationcode,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              bottom: 44.h,
            ),

            ///pin code
            PinCodeTextField(
              cursorColor:Colors.black,
              appContext: (context),
              validator: (value){
                if (value!.length <= 6) {
                  return null;
                } else {
                  return "Please enter the OTP code.";
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
            SizedBox(height: 24.h,),

            ///didn't receive the code
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: AppStrings.didntReceivetheCode,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.blue_500,
                ),
                GestureDetector(
                  onTap: (){},
                  child: const CustomText(
                    text: AppStrings.resend,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: CustomElevatedButton(onPressed: (){
          Get.toNamed(AppRoutes.resetPasswordScreen);
        }, titleText: AppStrings.verify),
      ),
    );
  }
}
