import 'package:dialogi_app/controllers/question/discussion_platform.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void chooseDiscussPlatform({required BuildContext context}) {
  final DiscussionPlatformController discussionPlatformController =
      Get.put(DiscussionPlatformController());

  showDialog(
    context: context,
    builder: (context) {
      discussionPlatformController.checkDiscussion() ;
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
                    discussionPlatformController.discussPlatform.length,
                    (index) => Row(
                      children: [
                        Radio<String>(
                          value: discussionPlatformController
                              .discussPlatform[index],
                          groupValue:
                              discussionPlatformController.selectedPlatform,
                          onChanged: (value) {
                            setState(() {
                              discussionPlatformController.selectedPlatform =
                                  value!;
                            });
                          },
                        ),
                        CustomText(
                          text: discussionPlatformController
                              .discussPlatform[index],
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
                      if (discussionPlatformController.selectedPlatform ==
                          AppStrings.community) {
                        Get.toNamed(AppRoutes.sameCommunity);
                      } else {
                        Get.toNamed(AppRoutes.selectFriends, parameters: {
                          "discussPlatform":
                              discussionPlatformController.selectedPlatform
                        });
                      }
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
