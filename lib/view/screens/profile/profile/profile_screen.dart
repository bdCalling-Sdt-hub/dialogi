import 'package:dialogi_app/controllers/profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/profile_custom/profile_image.dart';
import 'package:dialogi_app/view/widgets/profile_custom/profile_user_details.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState

    profileController.profileRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("=============================> ${PrefsHelper.clientId}");
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 4),
        appBar: CustomAppBar(
            appBarContent: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const CustomText(
              text: AppStrings.profile,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.editProfileScreen);
                },
                child: const CustomImage(
                  imageSrc: AppIcons.edit,
                  size: 24,
                ))
          ],
        )),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading => const CircularProgressIndicator(),
              Status.error =>
                ErrorScreen(onTap: () => controller.profileRepo()),
              Status.completed => SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: [
                      /// profile image
                      ///
                      ProfileImage(
                          imageURl: "${ApiConstant.baseUrl}${controller.profileModel.data!.attributes!.image!}"),

                      SizedBox(
                        height: 44.h,
                      ),

                      ///premium member
                      controller.profileModel.data!.attributes!.subscription ==
                              "default"
                          ? const SizedBox()
                          : Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.black_500,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const CustomImage(
                                        imageSrc: AppIcons.badgeCheck,
                                        size: 24,
                                      ),
                                      CustomText(
                                        text: controller.profileModel.data!.attributes!.subscription!,
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                        left: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 44.h,
                                ),
                              ],
                            ),

                      ///profile details
                      ProfileUserDetails(
                        name:
                            controller.profileModel.data!.attributes!.fullName!,
                        email: controller.profileModel.data!.attributes!.email!,
                        dob: " ",
                        address: " ",
                      )
                    ],
                  ),
                ),
            };
          },
        ));
  }
}
