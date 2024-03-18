import 'package:dialogi_app/controllers/profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/Testing/testing_screen.dart';
import 'package:dialogi_app/view/screens/home/screen/inner_widgets/logout.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final ProfileController profileController = Get.put(ProfileController());

  Widget customRow(
      {required String icon,
      required String text,
      required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
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
    return GetBuilder<ProfileController>(builder: (controller) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 20.w),
          child: Column(
            children: [
              //Profile Section
              switch (controller.status) {
                Status.loading =>
                  const Center(child: CircularProgressIndicator()),
                Status.error => Container(
                    height: 55,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.blue_200, width: 1)),
                  ),
                Status.completed => Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.blue_200, width: 1)),
                    child: Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiConstant.baseUrl}${controller.profileModel!.data!.attributes!.image}"))),
                        ),
                        CustomText(
                          text: controller
                              .profileModel!.data!.attributes!.fullName!,
                          left: 8.w,
                        )
                      ],
                    ),
                  ),
              },

              SizedBox(
                height: 44.h,
              ),

              ///<<<==================== Pending Request ======================>>>

              customRow(
                  icon: AppIcons.pendingReq,
                  text: AppStrings.pendingRequests.tr,
                  ontap: () {
                    Get.toNamed(AppRoutes.pendingRequestsScreen);
                  }),
              const SizedBox(
                height: 32,
              ),

              ///<<<======================= Settings ==========================>>>

              customRow(
                  icon: AppIcons.setting,
                  text: AppStrings.settings.tr,
                  ontap: () {
                    Get.toNamed(AppRoutes.settingsScreen);
                  }),
              const SizedBox(
                height: 32,
              ),

              ///<<<====================== favorite List =============================>>>

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.favoriteList);
                },
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border_outlined,
                        color: AppColors.blue_500,
                      ),
                      CustomText(
                        text: AppStrings.favoriteList.tr,
                        left: 16.w,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              ///<<<====================== Test Mobile Ad =============================>>>

              GestureDetector(
                onTap: () {
                  Get.to(AdmobAd());
                },
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: AppColors.blue_500,
                      ),
                      CustomText(
                        text: "Test Mobile Ad".tr,
                        left: 16.w,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              ///<<<====================== Logout =============================>>>

              LogOut.customRow(
                icon: AppIcons.logout,
                text: AppStrings.logout.tr,
              ),
            ],
          ));
    });
  }
}
