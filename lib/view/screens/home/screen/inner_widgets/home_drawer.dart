import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
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
  Widget customRow(
      {required String icon,
      required String text,
      required VoidCallback ontap}) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            CustomImage(
              imageSrc: icon,
              size: 24.sp,
            ),
            CustomText(
              text: text,
              left: 16.w,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 20.w),
        child: Column(
          children: [
            //Profile Section
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.blue_200, width: 1)),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.png'))),
                  ),
                  CustomText(
                    text: 'Bassie Cooper',
                    left: 8.w,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 44.h,
            ),

            //Pending  Req

            customRow(
                icon: AppIcons.pendingReq,
                text: AppStrings.pendingRequests,
                ontap: () {
                  Get.toNamed(AppRoutes.pendingRequestsScreen);
                }),
            const SizedBox(
              height: 32,
            ),

            //Settings

            customRow(
                icon: AppIcons.setting,
                text: AppStrings.settings,
                ontap: () {
                  Get.toNamed(AppRoutes.settingsScreen);
                }),
            const SizedBox(
              height: 32,
            ),

            //LogOut

            customRow(
                icon: AppIcons.logout,
                text: AppStrings.logout,
                ontap: () {
                  Get.offAllNamed(AppRoutes.signInScreen);
                }),
          ],
        ));
  }
}
