import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.blue_200,width: 1)
            ),
            child: Row(
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/profile.png'))
                  ),
                ),
                CustomText(
                  text: 'Bassie Cooper',
                  left: 8.w,
                )
              ],
            ),
          ),
          SizedBox(height: 44.h,),
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.settingsScreen);
            },
            child: Container(
              decoration: const BoxDecoration(
              ),
              child: Row(
                children: [
                  const CustomImage(imageSrc: AppIcons.setting,size: 24,),
                  CustomText(
                    text: 'Settings',
                    left: 16.w,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 32,),
          Container(
            decoration: const BoxDecoration(
            ),
            child: Row(
              children: [
                const CustomImage(imageSrc: AppIcons.logout,size: 24,),
                CustomText(
                  text: 'Logout',
                  left: 16.w,
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
