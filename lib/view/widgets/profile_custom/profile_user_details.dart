import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';

import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserDetails extends StatelessWidget {
  const ProfileUserDetails(
      {super.key,
      required this.name,
      required this.email,
      required this.dob,
      required this.address});

  final String name;
  final String email;
  final String dob;
  final String address;

  @override
  Widget build(BuildContext context) {
    Widget customRow({required String icon, required String title}) {
      return Padding(
        padding: EdgeInsets.all(16.h),
        child: Row(
          children: [
            CustomImage(
              imageSrc: icon,
              size: 18,
            ),
            CustomText(
              text: title,
              fontSize: 16,
              left: 12,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          customRow(icon: AppIcons.person, title: name),
          customRow(icon: AppIcons.mail, title: email),
          dob.isNotEmpty
              ? customRow(icon: AppIcons.dob, title: dob)
              : const SizedBox(),
          address.isNotEmpty
              ? customRow(icon: AppIcons.location, title: address)
              : const SizedBox(),
        ],
      ),
    );
  }
}
