
import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/api_static_string.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("Access Token: ${PrefsHelper.token}");
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<SignInController>(builder: (controller) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 44,
                ),

                ///<<<=================== welcome text =========================>>>
                CustomText(
                  textAlign: TextAlign.start,
                  text: AppStrings.welcomeToThe.tr,
                  fontSize: 18.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: AppStrings.dialogiApp.tr,
                  fontSize: 30.h,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_500,
                ),

                SizedBox(
                  height: 64.h,
                ),

                ///<<<============== Email field ===============================>>>

                CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ApiStaticStrings.enterEmail.tr;
                    } else if (!ApiStaticStrings.emailRegexp
                        .hasMatch(controller.emailController.text)) {
                      return ApiStaticStrings.enterValidEmail.tr;
                    } else {
                      return null;
                    }
                  },
                  textEditingController: controller.emailController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.enterYourEmail.tr,
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

                const SizedBox(
                  height: 24,
                ),

                ///<<<==================== Password field =======================>>>

                CustomTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ApiStaticStrings.fieldCantBeEmpty.tr;
                    } else {
                      return null;
                    }
                  },
                  textEditingController: controller.passwordController,
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

                ///<<<================ forget password ==========================>>>
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgetPasswordScreen);
                  },
                  child: CustomText(
                    text: AppStrings.forgotPassword.tr,
                    color: AppColors.red_500,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    top: 24.h,
                    bottom: 24.h,
                  ),
                ),

                ///<<<================== signIn button ========================>>>

                controller.signInLoading?
                const Center(child: CircularProgressIndicator()):
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      controller.signInUser();
                    }
                    // Get.toNamed(AppRoutes.homeScreen);
                  },
                  titleText: AppStrings.signIn.tr,
                  buttonWidth: MediaQuery.of(context).size.width,
                ),

                ///or
                Center(
                  child: CustomText(
                    text: 'Or'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    top: 24.h,
                    bottom: 24.h,
                  ),
                ),

                ///<<<======================= google sign in ==================>>>

                GestureDetector(
                  onTap: controller.googleSignIn,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(
                          imageSrc: AppIcons.google,
                          size: 24,
                          imageType: ImageType.svg,
                        ),
                        CustomText(
                          text: AppStrings.continuewithGoogle.tr,
                          color: AppColors.black_500,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          left: 8.w,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                ///<<<==================== apple sign in =====================>>>

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomImage(
                        imageSrc: AppIcons.apple,
                        size: 24,
                        imageType: ImageType.svg,
                      ),
                      CustomText(
                        text: AppStrings.continuewithApple.tr,
                        color: AppColors.black_500,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        left: 8.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),

                ///don't have an account
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppStrings.donthaveanaccount.tr,
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signUpScreen);
                        },
                        child: CustomText(
                          text: AppStrings.signUp.tr,
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
        );
      },),
    );
  }
}