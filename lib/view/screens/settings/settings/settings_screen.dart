import 'package:dialogi_app/controllers/settings_controller/settings_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/settings/settings/inner_widgets/delete_account.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_settings_container.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    print(
        "======================================>isProvider ${PrefsHelper.isProvider}");
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.homeScreen);
            },
            child: const CustomImage(
              imageSrc: AppIcons.chevronLeft,
              size: 24,
            ),
          ),
          CustomText(
            text: AppStrings.settings.tr,
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            ///<<<=================== change password =======================>>>

            if (!PrefsHelper.isProvider)
              CustomSettingsContainer(
                  onTap: () {
                    Get.toNamed(AppRoutes.settingsChangePasswordScreen);
                  },
                  imageSrc: AppIcons.lock,
                  text: AppStrings.changePassword.tr,
                  icon: AppIcons.chevronRight),

            ///<<<==================== change Language ======================>>>
            CustomSettingsContainer(
                onTap: () {
                  Get.toNamed(AppRoutes.changeLanguageScreen);
                },
                imageSrc: AppIcons.translate,
                text: AppStrings.changeLanguage.tr,
                icon: AppIcons.chevronRight),

            ///<<<=================== Subscriptions =========================>>>
            CustomSettingsContainer(
                onTap: () {
                  Get.toNamed(AppRoutes.subscriptionsScreen);
                },
                imageSrc: AppIcons.subscriptions,
                text: AppStrings.mySubscription.tr,
                icon: AppIcons.chevronRight),

            ///<<<================== Privacy Policy =========================>>>

            CustomSettingsContainer(
                onTap: () {
                  settingsController.privacyPolicyRepo();
                },
                imageSrc: AppIcons.privacy,
                text: AppStrings.privacyPolicy.tr,
                icon: AppIcons.chevronRight),

            ///<<<================== about us ===============================>>>

            CustomSettingsContainer(
                onTap: () {
                  settingsController.aboutUsRepo();
                },
                imageSrc: AppIcons.aboutUs,
                text: AppStrings.aboutUs.tr,
                icon: AppIcons.chevronRight),

            ///<<<=================== supports ==============================>>>

            CustomSettingsContainer(
                onTap: () {
                  settingsController.supportsRepo();
                },
                imageSrc: AppIcons.support,
                text: AppStrings.support.tr,
                icon: AppIcons.chevronRight),

            ///<<<==================== faq =================================>>>>

            CustomSettingsContainer(
                onTap: () {
                  settingsController.faqRepo();
                },
                imageSrc: AppIcons.faq,
                text: AppStrings.fAQ.tr,
                icon: AppIcons.chevronRight),

            ///<<<=================== delete account ========================>>>

            CustomSettingsContainer(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const DeleteAccount();
                      });
                },
                imageSrc: AppIcons.deleteAccount,
                text: AppStrings.deleteAccount.tr,
                icon: AppIcons.chevronRight),
          ],
        ),
      ),
    );
  }
}
