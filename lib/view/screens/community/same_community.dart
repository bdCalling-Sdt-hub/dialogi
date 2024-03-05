import 'package:dialogi_app/controllers/community/same_community_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/buttons/custom_elevated_button.dart';

class SameCommunity extends StatefulWidget {
  const SameCommunity({super.key});

  @override
  State<SameCommunity> createState() => _SameCommunityState();
}

class _SameCommunityState extends State<SameCommunity> {
  final SameCommunityController sameCommunityController =
      Get.put(SameCommunityController());

  String categoryId = "65db196f785f1b8de02c647c";

  @override
  void initState() {
    sameCommunityController.sameCommunityRepo(categoryId);
    sameCommunityController.scrollController.addListener(() {
      sameCommunityController.scrollControllerCall(categoryId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
          appBarContent: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                right: 20.w,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
                text: AppStrings.community,
              ),
            ),
          )
        ],
      )),
      body: GetBuilder<SameCommunityController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(
                onTap: () => controller.sameCommunityRepo(categoryId)),
            Status.completed => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.isMoreLoading
                      ? controller.chatList.length + 1
                      : controller.chatList.length,
                  itemBuilder: (context, index) {
                    var item = controller.chatList[index];
                    return GestureDetector(
                      onTap: () => controller.joinCommunityRepo(item.sId),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.transparent,
                                child: ClipOval(
                                  child: Image.network(
                                      "${ApiConstant.baseUrl}${item.image}"),
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: item.groupName,
                                      fontSize: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  },
                ),
              ),
          };
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: CustomElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.communitySelectFriends);
            },
            titleText: AppStrings.createNewCommunity),
      ),
    );
  }
}
