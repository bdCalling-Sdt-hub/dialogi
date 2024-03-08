import 'package:dialogi_app/controllers/community/community_member_controller.dart';
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

class CommunityMembers extends StatefulWidget {
  const CommunityMembers({super.key});

  @override
  State<CommunityMembers> createState() => _CommunityMembersState();
}

class _CommunityMembersState extends State<CommunityMembers> {
  String chatId = Get.parameters["chatId"] ?? "";


  CommunityMemberController communityMemberController = Get.put(CommunityMemberController()) ;


  @override
  void initState() {
    communityMemberController.communityMemberRepo(chatId) ;
    communityMemberController.scrollController.addListener(() {
      communityMemberController.scrollControllerCall(chatId) ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("===========================>? Chat Id $chatId") ;

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
                  text: AppStrings.communityMembers,
                ),
              ),
            )
          ],
        )),
        body: GetBuilder<CommunityMemberController>(
          builder: (controller) {
            return switch (controller.status) {
              Status.loading =>
                const Center(child: CircularProgressIndicator()),
              Status.error => ErrorScreen(
                  onTap: () => controller.communityMemberRepo(chatId)),
              Status.completed => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: ListView.builder(
                    itemCount: controller.communityList.length,
                    itemBuilder: (context, index) {
                      var item = controller.communityList[index];

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
                                        image: NetworkImage("${ApiConstant.baseUrl}${item.image}"))),
                              ),
                              CustomText(
                                left: 16,
                                fontSize: 16.w,
                                fontWeight: FontWeight.w500,
                                text: item.fullName,
                              ),
                            ],
                          ),
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
                    },
                  ),
                ),
            };
          },
        ));
  }
}
