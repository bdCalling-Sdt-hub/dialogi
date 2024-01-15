import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // SignUpController controller=Get.put(SignUpController());
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
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Create new account
                CustomText(
                  text: AppStrings.createnewaccount,
                  color: AppColors.blue_500,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  top: 24.h,
                  bottom: 8.h,
                ),
                ///Join us
                const CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: AppStrings.joinusforbetterexperience,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                SizedBox(height: 64.h,),
                ///full name
                CustomTextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.fullname,
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
                    Icons.person,
                    size: 24.h,
                    color: AppColors.blue_500,
                  ),
                ),
                SizedBox(height: 24.h,),
                ///email
                CustomTextField(
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
                SizedBox(height: 24.h,),
                ///date of birth
                CustomTextField(
                  onTap: (){
                    controller.dateofbirthPicker(context);
                  },
                  readOnly: true,
                  textEditingController: controller.dobController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.dateofbirth,
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: CustomImage(imageSrc: AppIcons.dob,size: 12,),
                  )

                ),

                const SizedBox(height: 24,),
                ///address
                CustomTextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.address,
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
                    Icons.location_on_outlined,
                    size: 24.h,
                    color: AppColors.blue_500,
                  ),
                ),
                SizedBox(height: 64.h,),

                /// continue button
                CustomElevatedButton(onPressed: (){
                  Get.toNamed(AppRoutes.setPasswordScreen);
                }, titleText: AppStrings.continuee,buttonWidth: MediaQuery.of(context).size.width,),
                SizedBox(height: 24.h,),
                ///Already have an account?
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: AppStrings.alreadyhaveanaccount,
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.signInScreen);
                        },
                        child: const CustomText(
                          text: AppStrings.signIn,
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
          );
        }
      ),
    );
  }
}
