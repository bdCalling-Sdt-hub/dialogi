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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/community/community_select_friend_controller.dart';

class CommunitySelectFriends extends StatefulWidget {
  const CommunitySelectFriends({super.key});

  @override
  State<CommunitySelectFriends> createState() => _CommunitySelectFriendsState();
}

class _CommunitySelectFriendsState extends State<CommunitySelectFriends> {


  CommunitySelectFriendsController communitySelectFriendsController = Get.put(CommunitySelectFriendsController()) ;

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
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_500,
                  text: AppStrings.selectFriends,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                              text:
                                  "${controller.selectedParticipants.length - 1}/5")),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.friendList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.selectedFriends[index],
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
                                                  "${ApiConstant.baseUrl}${controller.friendList[index].otherParticipant.image}"))),
                                    ),
                                    CustomText(
                                      left: 16,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                      text: controller.friendList[index]
                                          .otherParticipant!.fullName!,
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
                          },
                        ),
                      ),

                      //=================================Create Group Button==============================

                      SizedBox(
                        width: double.maxFinite,
                        child: controller.isCreateGroup
                            ? CustomElevatedButton(
                                onPressed: () {
                                  createGroupPopUp(
                                    context: context,
                                  );
                                },
                                titleText: AppStrings.createCommunity)
                            : CustomElevatedButton(
                                buttonColor: AppColors.gray_900,
                                onPressed: () {
                                  Utils.snackBarMessage(AppStrings.selectMember,
                                      AppStrings.pleaseSelectAtLeastTwoMembers);
                                },
                                titleText: AppStrings.createCommunity),
                      )
                    ],
                  ),
                ),
            };
          },
        ));
  }
}