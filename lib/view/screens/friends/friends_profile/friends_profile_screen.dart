import 'dart:io';

import 'package:dialogi_app/core/app_routes.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
                      child: image != null
                          ? Container(
                              height: 108.h,
                              width: 108.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(image!),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle),
                            )
                          : Container(
                              height: 108.h,
                              width: 108.w,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(AppImages.friends)),
                                  border: Border.all(
                                      color: AppColors.black_500, width: 1),
                                  shape: BoxShape.circle),
                            ),
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
            const ProfileUserDetails(
              name: "Rafsan Hossain",
              email: "rafsan@gmail.com",
              dob: "12 jan 1999",
              address: "USA",
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.chatScreen);
              }, titleText: AppStrings.message)),
    );
  }
}