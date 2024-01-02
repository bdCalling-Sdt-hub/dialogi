import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_settings_container.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            imageSrc: AppIcons.chevronLeft,
            size: 24,
          ),
          CustomText(
            text: 'Settings',
            fontWeight: FontWeight.w500,
            fontSize: 18.h,
            color: AppColors.blue_500,
          ),
          SizedBox()
        ],
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: Column(
          children: [
            CustomSettingsContainer(onTap: (){Get.toNamed(AppRoutes.settingsChangePasswordScreen  );}, imageSrc: AppIcons.lock, text: 'Change Password', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.translate, text: 'Change Language', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.subscriptions, text: 'Subscriptions', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.privacy, text: 'Privacy Policy', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.aboutUs, text: 'About Us', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.support, text: 'Support', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.faq, text: 'FAQ', icon: AppIcons.chevronRight),
            CustomSettingsContainer(onTap: (){}, imageSrc: AppIcons.deleteAccount , text: 'Delete Account', icon: AppIcons.chevronRight),
          ],
        ),
      ),
    );
  }
}
