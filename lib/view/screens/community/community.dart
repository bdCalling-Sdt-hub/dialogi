import 'package:dialogi_app/controllers/community/community_list_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final CommunityListController communityListController =
      Get.put(CommunityListController());

  @override
  void initState() {
    communityListController.communityRepo();
    communityListController.scrollController.addListener(() {
      communityListController.scrollControllerCall();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
      appBar: const CustomAppBar(
          appBarContent: Center(
        child: CustomText(
          text: AppStrings.community,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.blue_500,
        ),
      )),
      body: GetBuilder<CommunityListController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error =>
              ErrorScreen(onTap: () => controller.communityRepo()),
            Status.completed => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.communityList.length,
                itemBuilder: (context, index) {
                  var item = controller.communityList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.chatScreen, parameters: {
                        "chatId": item.sId,
                        "type": AppStrings.community,
                        "name": item.groupName
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      height: 110.h,
                      width: double.infinity,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.whiteColor),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${ApiConstant.baseUrl}${item.image}"))),
                        )),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: item.groupName,
                                fontSize: 18.w,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomText(
                                text: item.latestMessage != null
                                    ? item.latestMessage.message
                                    : "",
                                fontSize: 14.w,
                                fontWeight: FontWeight.w200,
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                },
              ),
          };
        },
      ),
    );
  }
}
