import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key, required this.notificationText, required this.timeText});

  final String notificationText;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
                color: AppColors.blue_500,
                shape: BoxShape.circle
            ),
          ),
          SizedBox(width: 8.w,),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.blue_50,
                shape: BoxShape.circle
            ),
            child: const Icon(Icons.notifications_none,color: AppColors.blue_500,),
          ),
          SizedBox(width: 8.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: notificationText,
                fontSize: 16.h,
              ),
              SizedBox(height: 8.h,),
              CustomText(
                text: timeText,
                fontSize: 10.h,
                color: AppColors.black_200,
              ),
            ],
          )
        ],
      ),
    );
  }
}
