import 'package:dialogi_app/controllers/group_chat/group_chat_popUp_controller.dart';
import 'package:dialogi_app/controllers/group_chat/group_member_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'change_group_name.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemfour,
}

class GroupChatPopUps extends StatelessWidget {
  GroupChatPopUps({super.key, required this.chatId});

  String chatId;

  final GroupMemberController groupMemberController =
      Get.put(GroupMemberController());

  GroupChatPoopUpController groupChatPoopUpController = Get.put(GroupChatPoopUpController()) ;

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
                Get.toNamed(AppRoutes.groupMembers, parameters: {
                  "chatId": chatId,
                });
              },
              child: const CustomText(
                fontSize: 14,
                text: AppStrings.groupMembers,
              )),
        ),
        //================================change Group Name=============================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();
                changeGroupName(context: context, chatId: chatId);
              },
              child: const CustomText(
                fontSize: 14,
                text: AppStrings.changeGroupName,
              )),
        ),

        //================================Delete Conversation============================

        PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: GestureDetector(
              onTap: () {
                navigator!.pop();
                groupPermissionPopUp(
                    context: context, ontapYes: () => groupChatPoopUpController.deleteAccountRepo(chatId), ontapNo: () {});
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

                groupPermissionPopUp(
                    context: context,
                    ontapYes: () =>
                        groupMemberController.leaveCommunityRepo(chatId),
                    ontapNo: () {},
                    title: AppStrings.doYouWantToLeaveThisGroup);
              },
              child: const CustomText(
                fontSize: 14,
                color: AppColors.red_400,
                text: AppStrings.leaveGroup,
              )),
        ),
      ],
    );
  }
}
