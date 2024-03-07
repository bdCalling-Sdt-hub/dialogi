import 'package:dialogi_app/controllers/notification_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_notification.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  void initState() {
    notificationsController.notificationsRepo();
    notificationsController.scrollController.addListener(() {
      notificationsController.scrollControllerCall();
    });
    super.initState();
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
            CustomText(
              text: AppStrings.notification,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            const SizedBox(),
          ],
        )),
        body: GetBuilder<NotificationsController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading =>
                const Center(child: CircularProgressIndicator()),
              Status.error =>
                ErrorScreen(onTap: () => controller.notificationsRepo()),
              Status.completed => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.isMoreLoading
                          ? controller.notificationsList.length + 1
                          : controller.notificationsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = controller.notificationsList[index];

                        if (index < controller.notificationsList.length) {
                          return CustomNotification(
                              notificationText: item.message,
                              timeText:
                                  controller.getFormattedDate(item.createdAt));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
            };
          },
        ));
  }
}
