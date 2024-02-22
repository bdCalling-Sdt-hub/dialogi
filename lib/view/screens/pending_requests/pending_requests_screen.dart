import 'package:dialogi_app/controllers/friends/pending_request_controller.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_pending_requests.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/prefs_helper.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  PendingRequestController pendingRequestController =
      Get.put(PendingRequestController());

  @override
  void initState() {
    pendingRequestController.pendingRequestRepo();
    pendingRequestController.scrollController.addListener(() {
      pendingRequestController.scrollControllerCall();
    });

    // TODO: implement initState
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
            const CustomText(
              text: AppStrings.pendingRequests,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            const SizedBox(),
          ],
        )),
        body: GetBuilder<PendingRequestController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: ListView.builder(
                itemCount: controller.friendRequestList.length,
                itemBuilder: (BuildContext context, int index) {

                  var item = controller.friendRequestList[index]
                  ;
                  return CustomPendingRequests(
                      pendingText: item.participants[0].fullName,
                      image: "${ApiConstant.baseUrl}/${item.participants[0].image}",
                      timeText: controller.getFormattedDate(item.createdAt),
                      onTapReject: () => controller.requestActionRepo(item.sId, "rejected", index),
                      onTapAccept: () => controller.requestActionRepo(item.sId, "accepted", index),);
                }),
          );
        }));
  }
}
