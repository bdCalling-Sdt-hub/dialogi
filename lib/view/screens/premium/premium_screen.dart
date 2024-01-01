import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            CustomText(
              maxLines: 3,
              textAlign: TextAlign.start,
              text: 'Unlock premium access for unlimited Dialoginess!',
              fontSize: 30.h,
              fontWeight: FontWeight.w600,
              bottom: 24.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(2, (index) =>
                    Container(
                  margin: EdgeInsets.only(right: 16),
                  width: MediaQuery.of(context).size.width - 90.w,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.blue_50 ,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.blue_500, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppImages.premium,
                            imageType: ImageType.png,
                            size: 46,
                          ),
                          CustomText(
                            text: 'Premium',
                            fontSize: 24.h,
                            fontWeight: FontWeight.w500,
                            left: 8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'Get Dialogi Premium \$${50}/month',
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      const Row(
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.checkCircle,
                            imageType: ImageType.svg,
                            size: 16,
                          ),
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: 'Ad-free experience',
                            left: 8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.checkCircle,
                            imageType: ImageType.svg,
                            size: 16,
                          ),
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: 'Expanded question pool',
                            left: 8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.checkCircle,
                            imageType: ImageType.svg,
                            size: 16,
                          ),
                          Expanded(
                            child: CustomText(
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              text: 'Access to the additional categories',
                              left: 8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),),
              ),
            ),
             Column(
               children: [
                 CustomElevatedButton(
                   buttonWidth: MediaQuery.of(context).size.width,
                     onPressed: (){}, titleText: 'Get Premium'),
                 SizedBox(height: 16,),
                 GestureDetector(
                   onTap: (){
                     Get.toNamed(AppRoutes.signInScreen);
                   },
                   child: CustomText(
                     maxLines: 3,
                     textAlign: TextAlign.start,
                     text: 'Skip for now',
                     fontSize: 18.h,
                     fontWeight: FontWeight.w500,
                     color: AppColors.blue_500,
                   ),
                 ),
               ],
             )
          ],
        ),
      ),
    ));
  }
}
