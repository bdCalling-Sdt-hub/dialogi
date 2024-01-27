import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/container/custom_premium_card.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPremiumScreen extends StatefulWidget {
  const ChatPremiumScreen({super.key});

  @override
  State<ChatPremiumScreen> createState() => _ChatPremiumScreenState();
}

class _ChatPremiumScreenState extends State<ChatPremiumScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
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
          const CustomText(
            text: AppStrings.chat,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox(),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 3,
              textAlign: TextAlign.start,
              text: AppStrings.unlockPremiumAccess,
              fontSize: 30.h,
              fontWeight: FontWeight.w600,
              bottom: 24.h,
            ),
            SingleChildScrollView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              child: const Row(children: [
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
              ]),
            ),
            Column(
              children: [
                CustomElevatedButton(
                    buttonWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Get.toNamed(AppRoutes.purchaseScreen, parameters: {
                        "premium": currentIndex == 0 ? "true" : "false"
                      });
                    },
                    titleText: currentIndex == 0
                        ? AppStrings.getPremium
                        : AppStrings.getPremiumPlus),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.chatListScreen);
                  },
                  child: CustomText(
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    text: AppStrings.skipForNow,
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
    );
  }
}
