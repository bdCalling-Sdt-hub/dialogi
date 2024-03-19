import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/container/custom_premium_card.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/subscription_controllers/payment_controller.dart';
import '../../../controllers/subscription_controllers/subscription_controller.dart';
import '../../widgets/error/error_screen.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();

  // PaymentController paymentController = Get.find<PaymentController>();

  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    subscriptionController.subscriptionRepo();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<SubscriptionController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: () {
              controller.subscriptionRepo();
            }),
            Status.completed => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.cancel_rounded, size: 30.w,)),
                    ),
                    CustomText(
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      text: AppStrings.unlockPremiumAccess.tr,
                      fontSize: 30.h,
                      fontWeight: FontWeight.w600,
                      bottom: 24.h,
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
                    Column(
                      children: [
                        ///<<<================= Get Premium Button ====================>>>

                        CustomElevatedButton(
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
                                ? AppStrings.getPremium.tr
                                : AppStrings.getPremiumPlus.tr),
                        const SizedBox(
                          height: 16,
                        ),

                        ///======================== Skip for now =====================>>>

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed(AppRoutes.signInScreen);
                        //   },
                        //   child: CustomText(
                        //     maxLines: 3,
                        //     textAlign: TextAlign.start,
                        //     text: AppStrings.skipForNow,
                        //     fontSize: 18.h,
                        //     fontWeight: FontWeight.w500,
                        //     color: AppColors.blue_500,
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              )
          };
        },
      ),
    );
  }
}
