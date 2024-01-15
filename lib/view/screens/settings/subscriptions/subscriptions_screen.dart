import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_premium_card.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const CustomImage(
                  imageSrc: AppIcons.chevronLeft,
                  size: 24,
                ),
              ),
              CustomText(
                text:AppStrings.subscriptions,
                fontWeight: FontWeight.w500,
                fontSize: 18.h,
                color: AppColors.blue_500,
              ),
              const SizedBox()
            ],
          )),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// premium package
             const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: [
                    CustomPremiumCard(
                        imageSrc: AppImages.premium,
                        premiumText: 'Premium',
                        getDialogiText: 'Get Dialogi Premium \$${50}/month',
                        length: 3,
                        addText: 'Ad-free experience'),
                    CustomPremiumCard(
                      isPremium: false,
                      imageSrc: AppImages.premium,
                      premiumText: 'Premium Plus',
                      getDialogiText: 'Get Dialogi Premium \$${100}/month',
                      length: 7,
                      addText: 'All premium features',
                      addTextColor: Colors.white,
                      premiumTextColor: Colors.white,
                      getDialogiTextColor: Colors.white,
                    )
                  ]
              ),
            ),
            const SizedBox(height: 24,),
            CustomText(
              text:AppStrings.currentPlan,
              bottom: 24.h,
            ),

            ///cancel plan
            Container(
              padding: const EdgeInsets.only(bottom: 16,top: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black_50,width: 1)
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:AppStrings.premiumPlus,
                    fontWeight: FontWeight.w500,
                    fontSize:16.h,
                    color: AppColors.blue_500,
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.homeScreen);
                    },
                    child: CustomText(
                      text:AppStrings.cancelPlan,
                      fontWeight: FontWeight.w500,
                      fontSize:16.h,
                      color: AppColors.red_500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16,top: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black_50,width: 1)
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:AppStrings.billedMonthly,
                    fontWeight: FontWeight.w500,
                    fontSize:16.h,
                  ),
                  CustomText(
                    text:'\$${50.00}',
                    fontWeight: FontWeight.w500,
                    fontSize:16.h,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16,top: 16),
              decoration: const BoxDecoration(

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:AppStrings.billingDate,
                    fontWeight: FontWeight.w500,
                    fontSize:16.h,
                  ),
                  CustomText(
                    text:'12/13/24',
                    fontWeight: FontWeight.w500,
                    fontSize:16.h,
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
