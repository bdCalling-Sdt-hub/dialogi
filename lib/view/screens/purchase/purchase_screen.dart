import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/alert_dialog/alert_dialog.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  String? premium = Get.parameters["premium"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )),
          CustomText(
            text: premium == "true"
                ? AppStrings.upgradetoPremium
                : AppStrings.upgradetoPremiumPlus,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox(),
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: AppStrings.addPaymentMethod,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.blue_500,
            ),
            SizedBox(
              height: 8.h,
            ),
            const CustomText(
              maxLines: 2,
              text: AppStrings.addPaymentMethodForUpgrade,
              fontSize: 16,
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                const CustomImage(
                  imageSrc: AppImages.visa,
                  imageType: ImageType.png,
                  size: 72,
                ),
                SizedBox(
                  width: 8.w,
                ),
                const CustomImage(
                  imageSrc: AppImages.masterCard,
                  imageType: ImageType.png,
                  size: 72,
                ),
                SizedBox(
                  width: 8.w,
                ),
                const CustomImage(
                  imageSrc: AppImages.paypal,
                  imageType: ImageType.png,
                  size: 72,
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),

            ///card holder name
            CustomTextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.entercardholdername,
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
            SizedBox(
              height: 24.h,
            ),

            ///card number
            CustomTextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.cardnumber,
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
                Icons.credit_card,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),

            ///cvv
            CustomTextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                hintText: AppStrings.cVVCVC,
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
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.lock_outlined,
                      size: 24,
                      color: AppColors.blue_500,
                    ))),

            const SizedBox(
              height: 24,
            ),

            ///dob
            CustomTextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.mMYY,
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
                Icons.date_range_outlined,
                size: 24.h,
                color: AppColors.blue_500,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: CustomElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogs(
                        successtext: AppStrings.successful,
                        completeText: AppStrings.proceedToPayment,
                        buttonText: AppStrings.gotoHome,
                        onPressed: () {
                          Get.toNamed(AppRoutes.homeScreen);
                        });
                  });
            },
            titleText: AppStrings.proceedToPayment),
      ),
    );
  }
}
