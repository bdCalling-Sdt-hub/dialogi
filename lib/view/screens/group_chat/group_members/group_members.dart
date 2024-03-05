import 'package:dialogi_app/controllers/group_chat/group_member_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupMembers extends StatefulWidget {
  GroupMembers({super.key});

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  String chatId = Get.parameters["chatId"] ?? "";

  final GroupMemberController groupMemberController =
      Get.put(GroupMemberController());

  @override
  void initState() {
    groupMemberController.groupMemberRepo(chatId);
    groupMemberController.scrollController.addListener(() {
      groupMemberController.scrollControllerCall(chatId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("=====================chatId $chatId");

    return Scaffold(
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
                  text: AppStrings.groupMembers,
                ),
              ),
            )
          ],
        )),
        body: GetBuilder<GroupMemberController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading =>
                const Center(child: CircularProgressIndicator()),
              Status.error =>
                ErrorScreen(onTap: () => controller.groupMemberRepo(chatId)),
              Status.completed => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: ListView.builder(
                    itemCount: controller.isMoreLoading
                        ? controller.memberList.length + 1
                        : controller.memberList.length,
                    itemBuilder: (context, index) {
                      var item = controller.memberList[index];

                      if (index < controller.memberList.length) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${ApiConstant.baseUrl}${item.image}"))),
                                ),
                                CustomText(
                                  left: 16,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  text: item.fullName,
                                ),
                              ],
                            ),
                            const Divider()
                            // if (index != lastIndex)
                            //   Container(
                            //     height: 2.h,
                            //     width: double.maxFinite,
                            //     margin: EdgeInsets.symmetric(
                            //       vertical: 14.h,
                            //     ),
                            //     color: AppColors.gray_600,
                            //   )
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
            };
          },
        ));
  }
}
