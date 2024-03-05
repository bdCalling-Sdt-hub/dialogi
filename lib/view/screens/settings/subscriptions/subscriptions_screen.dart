import 'package:dialogi_app/controllers/subscription_controllers/payment_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/subscription_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/group_chat/select_friends/create_group_popup.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_premium_card.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/app_routes.dart';
import '../../../../models/access_status_model.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  SubscriptionController subscriptionController = Get.find<SubscriptionController>();
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    subscriptionController.subscriptionRepo();
    subscriptionController.subscriptionRepo();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Access model : ${Homecontroller.accessStatusModel?.status}");
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
            text: AppStrings.mySubscription,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
          )),
      body: Homecontroller.accessStatusModel?.status == "Success"
          ? GetBuilder<Homecontroller>(
          builder: (homeController) {
          return switch(Homecontroller.status){
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: (){
              Homecontroller.getAccessStatus();
            }),
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
                Center(
                  child: Container(
                    child: Column(
                      children: [

                      ],
                    ),
                  )
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomText(
                  text: AppStrings.currentPlan,
                  bottom: 16.h,
                ),

                ///<<<===================== Current Subscription Plan ========================>>>

                Container(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.black_50, width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: Homecontroller.accessStatusModel!.data!.type == "premium-plus" ? AppStrings.premiumPlus : AppStrings.premium,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                        color: AppColors.blue_500,
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
      },)
          : GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
          return switch(subscriptionController.status){
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: (){
              subscriptionController.subscriptionRepo();
            }),
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        text: AppStrings.noSubscriptionFound,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        bottom: 36.h,
                      ),

                      ///<<<=================== Get Premium  ==========================>>>

                      SingleChildScrollView(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        child: const Row(children: [
                          CustomPremiumCard(
                            isPremiumPlus: false,
                          ),
                          CustomPremiumCard(
                            isPremiumPlus: true,
                          )
                        ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          };
        },
      ),

      ///<<<===================== Subscription Button ========================>>>

      bottomNavigationBar: Homecontroller.accessStatusModel?.status == "Success" ? const SizedBox() : Padding(
        padding: const EdgeInsets.only(left: 24, right:  24, bottom: 30),
        child: CustomElevatedButton(
            buttonWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              // paymentController.makePaymentRepo();
              Get.toNamed(AppRoutes.purchaseScreen,
                  parameters: {
                    "premium":
                    currentIndex == 0 ? "true" : "false"
                  });
            },
            titleText: currentIndex == 0
                ? AppStrings.getPremium
                : AppStrings.getPremiumPlus),
      ),
    );
  }
}
