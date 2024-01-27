import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            /// profile image
            ///
            const ProfileImage(
                imageURl:
                    "https://images.unsplash.com/photo-1682687219356-e820ca126c92?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw0MXx8fGVufDB8fHx8fA%3D%3D"),

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
            const ProfileUserDetails(
              name: "Rafsan Hossain",
              email: "rafsan@gmail.com",
              dob: "12 jan 1999",
              address: "USA",
            )
          ],
        ),
      ),
    );
  }
}
