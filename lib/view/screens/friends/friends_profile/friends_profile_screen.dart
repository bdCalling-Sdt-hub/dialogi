import 'dart:io';

import 'package:dialogi_app/controllers/friends/friend_profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/profile_custom/profile_user_details.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
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

  ///image
  String? image;
  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery);
    if (getImages != null) {
      image = getImages.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    print("==================================> user ID $userID") ;
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
              text: 'Jhon zdoe',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            const SizedBox(),
          ],
        )),
        body: GetBuilder<FriendProfileController>(builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      /// profile image
                      Center(
                        child: SizedBox(
                          height: 108,
                          width: 108,
                          child: Stack(
                            children: [
                              Center(
                                child: Image.network(
                                    "${ApiConstant.baseUrl}/${controller.friendProfileModel!.data!.attributes!.userDetails!.image}"),
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

                      ///profile details
                      ProfileUserDetails(
                        name: controller.friendProfileModel!.data!.attributes!
                            .userDetails!.fullName!,
                        email: controller.friendProfileModel!.data!.attributes!
                            .userDetails!.email!,
                        dob: " ",
                        address: " ",
                      )
                    ],
                  ),
          );
        }),
        bottomNavigationBar: GetBuilder<FriendProfileController>(
          builder: (controller) {
            return controller.isLoading
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 20),
                    child: controller.friendProfileModel!.data!.attributes!
                                .friendRequestStatus ==
                            "rejected"
                        ? CustomElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.chatScreen);
                            },
                            titleText: AppStrings.sendRequest)
                        :controller.friendProfileModel!.data!.attributes!
                        .friendRequestStatus ==
                        "pending" ?
                    CustomElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.chatScreen);
                            },
                            titleText: AppStrings.requestSend) :

                    CustomElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.chatScreen);
                        },
                        titleText: AppStrings.message)



            );
          },
        ));
  }
}
