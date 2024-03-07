import 'package:dialogi_app/controllers/profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
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
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 4),
        appBar: CustomAppBar(
            appBarContent: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            CustomText(
              text: AppStrings.profile,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            Obx(() => profileController.updateProfileAccess.value
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfileScreen);
                    },
                    child: const CustomImage(
                      imageSrc: AppIcons.edit,
                      size: 24,
                    ))
                : const SizedBox()),
          ],
        )),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading => const Center(child: CircularProgressIndicator()),
              Status.error =>
                ErrorScreen(onTap: () => controller.profileRepo()),
              Status.completed => SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: [
                      /// profile image
                      ///
                      // ProfileImage(imageURl: "${ApiConstant.baseUrl}${controller.profileModel.data!.attributes!.image!}"),

                      // Center(
                      //   child: Container(
                      //     height: 108.w,
                      //     width: 108.w,
                      //     decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //           image: NetworkImage("${ApiConstant.baseUrl}${controller.profileModel.data!.attributes!.image!}"),
                      //           fit: BoxFit.cover,
                      //         ),
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: AppColors.black_500, width: 3.w)),
                      //   ),
                      // ),

                      Center(
                        child: SizedBox(
                          height: 108.w,
                          width: 108.w,
                          child: Stack(
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.selectImageGallery();
                                  },
                                  child: Container(
                                    height: 108.w,
                                    width: 108.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "${ApiConstant.baseUrl}${controller.profileModel.data!.attributes!.image!}",
                                          ),
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.black_500,
                                            width: 3.w)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // controller.selectImageCamera();
                                  },
                                  child: controller.profileModel.data!
                                              .attributes!.subscription ==
                                          "default"
                                      ? const SizedBox()
                                      : controller.profileModel.data!
                                                  .attributes!.subscription ==
                                              "premium"
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                    color: AppColors.black_500,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.diamond_outlined,
                                                  color: AppColors.blue_300,
                                                ),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                    color: AppColors.black_500,
                                                    shape: BoxShape.circle),
                                                child: CustomImage(
                                                  imageSrc: AppImages.crown,
                                                  imageType: ImageType.png,
                                                  size: 30.sp,
                                                  imageColor: Colors.amber,
                                                ),
                                              ),
                                            ))
                            ],
                          ),
                        ),
                      ),

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
                                        text: controller.profileModel.data!
                                            .attributes!.subscription!,
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
                        dob: controller
                                .profileModel.data?.attributes?.dateOfBirth
                                ?.split('T')[0] ??
                            "",
                        address:
                            controller.profileModel.data?.attributes?.address ??
                                "",
                      )
                    ],
                  ),
                ),
            };
          },
        ));
  }
}
