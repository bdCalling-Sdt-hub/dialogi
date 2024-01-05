import 'dart:io';

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_profile_container.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> profileDetails = [
    {
      'details': 'Bassie Cooper',
      'icon': AppIcons.person,
    },
    {
      'details': 'bassie@gmail.com',
      'icon': AppIcons.mail,
    },
    {
      'details': '12 Jan 1999',
      'icon': AppIcons.dob,
    },
    {
      'details': 'abc 12 st avenue New York, USA',
      'icon': AppIcons.location,
    },
  ];

  ///image
  String? image;
  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery);
    if (getImages != null) {
      image = getImages.path;
      print(image);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
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
                  onTap: (){
                    Get.toNamed(AppRoutes.editProfileScreen);
                  },
                  child: const CustomImage(imageSrc: AppIcons.edit,size: 24,))
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
                                      image: AssetImage(
                                          'assets/images/profile.png')),
                                  border: Border.all(
                                      color: AppColors.black_500, width: 1),
                                  shape: BoxShape.circle),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppColors.black_500,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.photo_camera_outlined,
                            size: 18,
                            color: AppColors.whiteColor,
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

            ///premium member
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.black_500,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.badgeCheck,
                    size: 24,
                  ),
                  CustomText(
                    text: AppStrings.premiumMember,
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

            ///profile details
            Column(
              children: List.generate(
                profileDetails.length,
                (index) => CustomProfileContainer(
                    text: profileDetails[index]['details'] ?? '',
                    icon: profileDetails[index]['icon'] ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
