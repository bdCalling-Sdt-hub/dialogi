import 'package:dialogi_app/controllers/community/community_member_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/community/inner_widget/change_community_name.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_community_popup.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemfour,
}

class CommunityChatPopUps extends StatelessWidget {
  CommunityChatPopUps({super.key, required this.chatId});

  String chatId;

  final CommunityMemberController communityMemberController =
      Get.put(CommunityMemberController());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColors.whiteColor,
      icon: const Icon(
        Icons.more_vert_outlined,
        color: AppColors.black_700,
      ),
      itemBuilder: (context) => [
        //================================Group Members=============================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();
                Get.toNamed(AppRoutes.communityMembers,
                    parameters: {
                      "chatId": chatId,

                    }

                );
              },
              child: const CustomText(
                fontSize: 14,
                text: AppStrings.communityMembers,
              )),
        ),
        //================================change Group Name=============================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();
                changeCommunityName(
                  context: context,
                  chatId: chatId,
                );
              },
              child: const CustomText(
                fontSize: 14,
                text: AppStrings.changeCommunityName,
              )),
        ),

        //================================Delete Conversation============================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();
                permissionCommunityPopUp(
                    context: context, ontapYes: () {}, ontapNo: () {});
              },
              child: const CustomText(
                fontSize: 14,
                text: AppStrings.deleteConversation,
              )),
        ),

        //================================Left Group==================================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemfour,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();

                permissionCommunityPopUp(
                    context: context,
                    ontapYes: () =>
                        communityMemberController.leaveCommunityRepo(chatId),
                    ontapNo: () {},
                    title: AppStrings.doYouWantToLeaveThisGroup);
              },
              child: const CustomText(
                fontSize: 14,
                color: AppColors.red_400,
                text: AppStrings.leaveCommunity,
              )),
        ),
      ],
    );
  }
}
