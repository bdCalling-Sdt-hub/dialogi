import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/friends/pending_request_controller.dart';

class CustomPendingRequests extends StatelessWidget {
  const CustomPendingRequests({super.key, required this.pendingText,required this.image, required this.timeText, required this.onTapReject, required this.onTapAccept});

  final String pendingText;
  final String timeText;
  final String image;
  final VoidCallback onTapReject;
  final VoidCallback onTapAccept;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingRequestController>(builder: (controller) {
      return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(image))
                ),
              ),
              SizedBox(width: 16.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: pendingText,
                    fontSize: 16.h,
                  ),
                  SizedBox(height: 8.h,),
                  CustomText(
                    text: timeText,
                    fontSize: 10.h,
                    color: AppColors.black_200,
                  ),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      GestureDetector(
                        onTap: onTapReject,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 36),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.black_500,width: 1)
                          ),
                          child: CustomText(
                            text: AppStrings.reject,
                            fontWeight: FontWeight.w600,

                          ),
                        ),
                      ),

                      SizedBox(width: 8.w,),

                      GestureDetector(
                        onTap: onTapAccept,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 36),
                          decoration: BoxDecoration(
                            color: AppColors.black_500,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomText(
                            text: AppStrings.accept,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

        Divider()
      ],
    );});
  }
}
