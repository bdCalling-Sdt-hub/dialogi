import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void chooseDiscussPlatform({required BuildContext context}) {
  String selectedPlatform = AppStrings.community;

  List<String> discussPlatform = [AppStrings.community, AppStrings.group];
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 300.h,
          width: double.maxFinite,
          child: StatefulBuilder(builder: (context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  fontSize: 18.w,
                  fontWeight: FontWeight.w500,
                  text: AppStrings.selectDiscussionPlatform,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    discussPlatform.length,
                    (index) => Row(
                      children: [
                        Radio<String>(
                          value: discussPlatform[index],
                          groupValue: selectedPlatform,
                          onChanged: (value) {
                            setState(() {
                              selectedPlatform = value!;
                            });
                          },
                        ),
                        CustomText(
                          text: discussPlatform[index],
                        ),
                      ],
                    ),
                  ),
                ),

                //========================Confirm Button==========================
                CustomElevatedButton(
                    buttonWidth: double.maxFinite,
                    onPressed: () {
                      navigator!.pop();
                      Get.toNamed(AppRoutes.selectFriends,
                          parameters: {"discussPlatform": selectedPlatform});
                    },
                    titleText: AppStrings.confirm)
              ],
            );
          }),
        ),
      );
    },
  );
}
