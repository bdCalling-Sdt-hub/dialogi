import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_notification.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const CustomImage(imageSrc: AppIcons.chevronLeft,size: 24,)),
              const CustomText(
                text: AppStrings.notification,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
              ),
              const SizedBox(),

            ],
          )),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index){
              return const CustomNotification(notificationText: 'You payment was successful.', timeText: '1 hour ago');
            }),
      )
    );
  }
}
