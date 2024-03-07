import 'package:dialogi_app/controllers/friends/pending_request_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_pending_requests.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    pendingRequestController.communityScrollController.addListener(() {
      pendingRequestController.communityScrollControllerCall();
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
            CustomText(
              text: AppStrings.pendingRequests,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
            const SizedBox(),
          ],
        )),
        body: GetBuilder<PendingRequestController>(builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: () {
                controller.page = 1;
                controller.pendingRequestRepo();
              }),
            Status.completed => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.page = 1;
                                  controller.pendingRequestRepo();
                                },
                                child: CustomText(
                                  text: AppStrings.friendRequests,
                                  fontSize: 14,
                                  color: AppColors.blue_500,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              controller.isCommunityRequest
                                  ? const SizedBox()
                                  : Container(
                                      height: 2,
                                      color: Colors.blue,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                    )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.communityPage = 1;
                                  controller.communityRequestRepo();
                                },
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: AppStrings.communityRequests,
                                      fontSize: 14,
                                      color: AppColors.blue_500,
                                    ),
                                    controller.isCommunityRequest
                                        ? Container(
                                            color: Colors.red,
                                          )
                                        : Container(
                                            color: Colors.blue,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              controller.isCommunityRequest
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      height: 2,
                                      color: Colors.blue,
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Expanded(
                        child: controller.isCommunityRequest
                            ? ListView.builder(
                                itemCount: controller.isMoreLoadingCommunity
                                    ? controller.communityRequest.length + 1
                                    : controller.communityRequest.length,
                                controller:
                                    controller.communityScrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      controller.communityRequest.length) {
                                    var item =
                                        controller.communityRequest[index];
                                    return CustomPendingRequests(
                                      pendingText: item.chat.groupName,
                                      image:
                                          "${ApiConstant.baseUrl}/${item.chat.image}",
                                      timeText: controller
                                          .getFormattedDate(item.createdAt),
                                      onTapReject: () =>
                                          controller.communityRequestActionRepo(
                                              item.sId, "rejected", index),
                                      onTapAccept: () =>
                                          controller.communityRequestActionRepo(
                                              item.sId, "accepted", index),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                })
                            : ListView.builder(
                                controller: controller.scrollController,
                                itemCount: controller.isMoreLoading
                                    ? controller.friendRequestList.length + 1
                                    : controller.friendRequestList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item =
                                      controller.friendRequestList[index];

                                  if (index <
                                      controller.friendRequestList.length) {
                                    return CustomPendingRequests(
                                      pendingText:
                                          item.participants[0].fullName,
                                      image:
                                          "${ApiConstant.baseUrl}/${item.participants[0].image}",
                                      timeText: controller
                                          .getFormattedDate(item.createdAt),
                                      onTapReject: () =>
                                          controller.requestActionRepo(
                                              item.sId, "rejected", index),
                                      onTapAccept: () =>
                                          controller.requestActionRepo(
                                              item.sId, "accepted", index),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                })),
                  ],
                ),
              ),
          };
        }));
  }
}
