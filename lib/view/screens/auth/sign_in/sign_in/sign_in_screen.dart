import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 44,),

            /// welcome text
            CustomText(
              textAlign: TextAlign.start,
              text: 'Welcome to the',
              fontSize: 18.h,
              fontWeight: FontWeight.w500,
              bottom: 8,
            ),
            CustomText(
              textAlign: TextAlign.start,
              text: 'Dialogi App',
              fontSize: 30.h,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),

            SizedBox(height: 64.h,),
            ///email
            CustomTextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: 'Enter your email',
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

            const SizedBox(height: 24,),

            ///password
            CustomTextField(
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: 'Enter your password',
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

            ///forget password
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.forgetPasswordScreen);
              },
              child: CustomText(
                text: 'Forget Password',
                color: AppColors.red_500,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                top: 24.h,
                bottom: 24.h,
              ),
            ),

            ///signIn button
            CustomElevatedButton(onPressed: (){
              Get.toNamed(AppRoutes.homeScreen);
            }, titleText: 'Sign In',buttonWidth: MediaQuery.of(context).size.width,),

            ///or
            Center(
              child: CustomText(
                text: 'Or',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                top: 24.h,
                bottom: 24.h,
              ),
            ),

            ///google
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(imageSrc: AppIcons.google,size: 24,imageType: ImageType.svg,),
                  CustomText(
                    text: 'Continue with Google',
                    color: AppColors.black_500,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    left: 8.w,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24,),

            ///apple
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(imageSrc: AppIcons.apple,size: 24,imageType: ImageType.svg,),
                  CustomText(
                    text: 'Continue with Apple',
                    color: AppColors.black_500,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    left: 8.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 34.h,),

            ///don't have an account
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Don’t have an account?',
                    fontSize: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: const CustomText(
                      text: 'Sign Up',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue_500,
                      left: 4,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
