import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/subscription_controllers/subscription_controller.dart';
import '../../../global/api_response_model.dart';
import '../../../utils/app_images.dart';
import '../error/error_screen.dart';

class CustomPremiumCard extends StatelessWidget {

  const CustomPremiumCard(
      {super.key,
      required this.isPremiumPlus,});
  final bool isPremiumPlus;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscriptionController) {

      var premiumSubscriptionData = subscriptionController.subscriptionsPlanModel?.data?.attributes?.subscriptionsList?[0];
      var premiumPlusSubscriptionData = subscriptionController.subscriptionsPlanModel?.data?.attributes?.subscriptionsList?[1];

      List premiumFeaturesList = [
        premiumSubscriptionData?.isAddAvailable == true? "${"Ad. after".tr} ${premiumSubscriptionData?.addFrequency} ${"videos".tr}" : "Ad-free experience".tr,
        premiumSubscriptionData?.isEarlyAccessAvailable == true? "Early access is available".tr : "Early access isn't available".tr,
        premiumSubscriptionData?.isQuestionAccessUnlimited == true? "All available questions".tr : "${"Get".tr} ${premiumSubscriptionData?.questionAccessNumber} ${"questions".tr}",
        premiumSubscriptionData?.isCategoryAccessUnlimited == true? "Additional categories".tr : "${"Get".tr} ${premiumSubscriptionData?.categoryAccessNumber} ${"categories".tr}",
        "Messaging feature".tr,
        premiumSubscriptionData?.isGroupChatAvailable == true? "Group chat feature".tr : "Group chat feature not available".tr,
        "Community Discussion".tr
      ];

      List premiumPlusFeaturesList = [
        premiumPlusSubscriptionData?.isAddAvailable == true? "${"Ad. after".tr} ${premiumPlusSubscriptionData?.addFrequency} ${"videos".tr}" : "Ad-free experience".tr,
        premiumPlusSubscriptionData?.isEarlyAccessAvailable == true? "Early access is available".tr : "Early access isn't available".tr,
        premiumPlusSubscriptionData?.isQuestionAccessUnlimited == true? "All available questions".tr : "${"Get".tr} ${premiumPlusSubscriptionData?.questionAccessNumber} ${"questions".tr}",
        premiumPlusSubscriptionData?.isCategoryAccessUnlimited == true? "Additional categories".tr : "${"Get".tr} ${premiumPlusSubscriptionData?.categoryAccessNumber} ${"categories".tr}",
        "Messaging feature".tr,
        premiumPlusSubscriptionData?.isGroupChatAvailable == true? "Group chat feature".tr : "Group chat feature not available".tr,
        "Community Discussion".tr
      ];
      return switch(subscriptionController.status){
        Status.loading => const Center(child: CircularProgressIndicator()),
        Status.error => ErrorScreen(onTap: () {
          subscriptionController.subscriptionRepo();
        }),
        Status.completed => Container(
          margin: const EdgeInsets.only(right: 16),
          width: MediaQuery.of(context).size.width - 90.w,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: isPremiumPlus ? AppColors.black_500 : AppColors.blue_50,
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
                    text: isPremiumPlus? 'Premium Plus' : 'Premium',
                    fontSize: 24.h,
                    fontWeight: FontWeight.w500,
                    left: 8,
                    color: isPremiumPlus? Colors.white : AppColors.black_500,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomText(
                textAlign: TextAlign.start,
                  text: isPremiumPlus
                      ? "Get Dialogi Premium Plus".tr : "Get Dialogi Premium".tr,
                fontSize: 16.h,
                fontWeight: FontWeight.w500,
                color: isPremiumPlus? Colors.white : AppColors.black_500,
              ),
              Row(
                children: [
                  Icon(Icons.euro, color: isPremiumPlus? Colors.white : AppColors.black_500, size: 20,),
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    text: isPremiumPlus
                        ? '${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![1].price}/${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![1].expiryTime} '
                        : '${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].price}/${subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].expiryTime} ',
                    fontSize: 16.h,
                    fontWeight: FontWeight.w500,
                    color: isPremiumPlus? Colors.white : AppColors.black_500,
                  ),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Month".tr,
                    fontSize: 16.h,
                    fontWeight: FontWeight.w500,
                    color: isPremiumPlus? Colors.white : AppColors.black_500,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),

              Column(
                children: List.generate(
                  premiumPlusFeaturesList.length,
                      (index) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        const CustomImage(
                          imageSrc: AppIcons.checkCircle,
                          imageType: ImageType.svg,
                          size: 16,
                        ),
                        Flexible(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            fontSize: 12,
                            text: isPremiumPlus? premiumPlusFeaturesList[index] : premiumFeaturesList[index],
                            left: 8,
                            color: isPremiumPlus? Colors.white : AppColors.black_500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // if (isPremium)
              //   SizedBox(
              //     height: 40.h,
              //   ),
            ],
          ),
        )
      };
    },);
  }
}
