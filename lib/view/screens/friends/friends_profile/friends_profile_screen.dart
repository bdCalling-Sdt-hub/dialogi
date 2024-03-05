import 'package:dialogi_app/controllers/friends/friend_profile_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/profile_custom/profile_user_details.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FriendsProfileScreen extends StatefulWidget {
  const FriendsProfileScreen({super.key});

  @override
  State<FriendsProfileScreen> createState() => _FriendsProfileScreenState();
}

class _FriendsProfileScreenState extends State<FriendsProfileScreen> {
  String userID = Get.parameters["userID"] ?? "";

  FriendProfileController friendProfileController =
      Get.put(FriendProfileController());

  @override
  void initState() {
    friendProfileController.friendProfileRepo(userID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("==================================> user ID $userID");
    return GetBuilder<FriendProfileController>(
      builder: (controller) {
        return switch (controller.status) {
          Status.loading => const Center(child: CircularProgressIndicator()),
          Status.error => ErrorScreen(
              onTap: () => friendProfileController.friendProfileRepo(userID)),
          Status.completed => Scaffold(
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
                  CustomText(
                    text: controller.friendProfileModel!.data!.attributes!
                        .userDetails!.fullName!,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue_500,
                  ),
                  const SizedBox(),
                ],
              )),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    /// profile image
                    Center(
                      child: SizedBox(
                        height: 108,
                        width: 108,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 108.w,
                                width: 108.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${ApiConstant.baseUrl}/${controller.friendProfileModel!.data!.attributes!.userDetails!.image}"),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.black_500,
                                        width: 3.w)),
                              ),
                            ),
                            SizedBox(
                              height: 44.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                // selectImage();
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: AppColors.black_500,
                                      shape: BoxShape.circle),
                                  child: const CustomImage(
                                    imageSrc: AppIcons.premiumPlus,
                                    imageType: ImageType.svg,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),

                    Container(
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.person,
                            size: 18,
                          ),
                          CustomText(
                            text: controller.friendProfileModel!.data!
                                .attributes!.userDetails!.fullName!,
                            fontSize: 16,
                            left: 12,
                          ),
                        ],
                      ),
                    ),

                    ///profile details
                    // ProfileUserDetails(
                    //   name: controller.friendProfileModel!.data!.attributes!
                    //       .userDetails!.fullName!,
                    //   email: controller.friendProfileModel!.data!
                    //       .attributes!.userDetails!.email!,
                    //   dob: " ",
                    //   address: " ",
                    // )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: userID == PrefsHelper.clientId
                      ? const SizedBox()
                      : controller.sendIsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : controller.friendProfileModel!.data!.attributes!
                                      .friendRequestStatus ==
                                  "accepted"
                              ? CustomElevatedButton(
                                  onPressed: () {
                                    controller.createChatRoom(
                                        userID,
                                        controller
                                            .friendProfileModel!
                                            .data!
                                            .attributes!
                                            .userDetails!
                                            .fullName!);

                                    // Get.toNamed(AppRoutes.chatScreen);
                                  },
                                  titleText: AppStrings.message)
                              : controller.friendProfileModel!.data!.attributes!
                                          .friendRequestStatus ==
                                      "pending"
                                  ? CustomElevatedButton(
                                      onPressed: () {
                                        // Get.toNamed(AppRoutes.chatScreen);
                                      },
                                      titleText: AppStrings.requestSend,
                                      buttonColor: AppColors.black_300,
                                    )
                                  : CustomElevatedButton(
                                      onPressed: () =>
                                          controller.sendRequestRepo(userID),
                                      titleText: AppStrings.sendRequest))),
        };
      },
    );
  }
}
