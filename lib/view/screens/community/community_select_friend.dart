import 'package:dialogi_app/controllers/group_chat/select_friends_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/group_chat/select_friends/create_group_popup.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/community/community_select_friend_controller.dart';
import 'inner_widget/create_community_popup.dart';

class CommunitySelectFriends extends StatefulWidget {
  const CommunitySelectFriends({super.key});

  @override
  State<CommunitySelectFriends> createState() => _CommunitySelectFriendsState();
}

class _CommunitySelectFriendsState extends State<CommunitySelectFriends> {
  CommunitySelectFriendsController communitySelectFriendsController =
      Get.put(CommunitySelectFriendsController());

  String questionId = Get.parameters["questionId"] ?? "";
  String categoryId = Get.parameters["categoryId"] ?? "";

  @override
  void initState() {
    communitySelectFriendsController.friendListRepo();
    communitySelectFriendsController.scrollController.addListener(() {
      communitySelectFriendsController.scrollControllerCall();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("===============================> questionId $questionId");
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_500,
                  text: AppStrings.selectFormPremiumPlus.tr,
                ),
              ),
            )
          ],
        )),
        body: GetBuilder<CommunitySelectFriendsController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading =>
                const Center(child: CircularProgressIndicator()),
              Status.error =>
                ErrorScreen(onTap: () => controller.friendListRepo()),
              Status.completed => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                              text:
                                  "${controller.selectedParticipants.length}/5")),
                      Expanded(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.isMoreLoading
                              ? controller.friendList.length + 1
                              : controller.friendList.length,
                          itemBuilder: (context, index) {
                            if (index < controller.friendList.length) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value:
                                            controller.selectedFriends[index],
                                        activeColor: AppColors.blue_300,
                                        onChanged: (value) => controller
                                            .selectParticipants(value!, index),
                                      ),
                                      Container(
                                        height: 50.w,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${ApiConstant.baseUrl}${controller.friendList[index].image}"))),
                                      ),
                                      CustomText(
                                        left: 16,
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500,
                                        text: controller
                                            .friendList[index]!.fullName!,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: double.maxFinite,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                    ),
                                    color: AppColors.gray_600,
                                  )
                                ],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),

                      //=================================Create Group Button==============================

                      Container(
                        padding: EdgeInsets.only(bottom: 24.h),
                        width: double.infinity,
                        child: controller.isCreateGroup
                            ? CustomElevatedButton(
                                onPressed: () {
                                  createCommunityPopUp(
                                      context: context,
                                      questionId: questionId,
                                      categoryId: categoryId);
                                },
                                titleText: AppStrings.createCommunity.tr)
                            : CustomElevatedButton(
                                buttonColor: AppColors.gray_900,
                                onPressed: () {
                                  Utils.snackBarMessage(
                                      AppStrings.selectMember.tr,
                                      controller.selectedParticipants.length < 2 ?
                                      AppStrings.pleaseSelectAtLeastTwoMembers.tr : "Please, select  Five members".tr );
                                },
                                titleText: AppStrings.createCommunity.tr),
                      ),
                    ],
                  ),
                ),
            };
          },
        ));
  }
}
