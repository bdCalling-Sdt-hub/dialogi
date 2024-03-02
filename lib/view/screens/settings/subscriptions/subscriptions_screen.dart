import 'package:dialogi_app/controllers/subscription_controllers/subscription_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/group_chat/select_friends/create_group_popup.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_premium_card.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
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
  SubscriptionController subscriptionController = Get.find<SubscriptionController>();

  @override
  void initState() {
    // TODO: implement initState
    subscriptionController.subscriptionRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var subscriptionList = subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList!;
    // print("===============> Subscription List: $subscriptionList <=================");
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
            ),
          ),
          CustomText(
            text: AppStrings.subscriptions,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
        return switch(subscriptionController.status){
          Status.loading => const Center(child: CircularProgressIndicator()),
          Status.error => ErrorScreen(onTap: (){}),
          Status.completed => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   child: ListView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     scrollDirection: Axis.horizontal,
                //     itemCount: subscriptionController.subscriptionsPlanModel!.data!.attributes!.subscriptionsList!.length,
                //     itemBuilder: (context, index) {
                //       return CustomPremiumCard(
                //         isPremium: false,
                //         imageSrc: AppImages.premium,
                //         premiumText: 'Premium Plus',
                //         getDialogiText: 'Get Dialogi Premium \$${100}/month',
                //         length: 7,
                //         addText: 'All premium features',
                //         addTextColor: Colors.white,
                //         premiumTextColor: Colors.white,
                //         getDialogiTextColor: Colors.white,
                //       );
                //     },),
                // ),

                ///<<<===================== premium package cards =======================>>>

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    CustomPremiumCard(
                      isPremiumPlus: false,
                    ),
                    CustomPremiumCard(
                      isPremiumPlus: true,
                    )
                  ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomText(
                  text: AppStrings.currentPlan,
                  bottom: 24.h,
                ),

                ///cancel plan
                Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.black_50, width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppStrings.premiumPlus,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                        color: AppColors.blue_500,
                      ),
                      InkWell(
                        onTap: () {
                          //Get.toNamed(AppRoutes.homeScreen);
                          permissionPopUp(
                              title: AppStrings.cancelSubscription,
                              context: context,
                              ontapYes: () {
                                navigator!.pop();
                              },
                              ontapNo: () {});
                        },
                        child: CustomText(
                          text: AppStrings.cancelPlan,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.h,
                          color: AppColors.red_500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.black_50, width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppStrings.billedMonthly,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                      CustomText(
                        text: '\$${50.00}',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppStrings.billingDate,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                      CustomText(
                        text: '12/13/24',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        };
      },),
    );
  }
}
