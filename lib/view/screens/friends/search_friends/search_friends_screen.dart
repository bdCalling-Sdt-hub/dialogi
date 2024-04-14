import 'package:dialogi_app/controllers/friends/search_friends_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/api_static_string.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/static_strings.dart';
import '../../../widgets/text/custom_text.dart';

class SearchFriendsScreen extends StatelessWidget {
  const SearchFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 64.h),
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: CustomText(
              text: AppStrings.searchFriends.tr,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
            ),
          ),
        ),
      ),
      // appBar: CustomAppBar(
      //     appBarContent: Center(
      //   child: CustomText(
      //     text: AppStrings.searchFriends.tr,
      //     fontSize: 18,
      //     fontWeight: FontWeight.w500,
      //     color: AppColors.blue_500,
      //   ),
      // )),
      body: GetBuilder<SearchFriendsController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: () {}),
            Status.completed => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        controller.getSearchedResult(value);
                      },
                      textEditingController: controller.searchController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      hintText: AppStrings.searchYourFriends.tr,
                      hintStyle: GoogleFonts.prompt(
                          fontSize: 14.h,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_300),
                      inputTextStyle: GoogleFonts.prompt(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.h,
                          color: AppColors.black_500),
                      fieldBorderColor: Colors.white,
                      fieldBorderRadius: 8,
                      isPrefixIcon: true,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 24.h,
                        color: AppColors.blue_500,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.searchResult.data?.attributes
                                ?.userList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          var searchFriend = controller
                              .searchResult.data?.attributes?.userList?[index];
                          return Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 8.h),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.friendsProfileScreen,
                                    parameters: {
                                      "userID": "${searchFriend?.sId}"
                                    });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${ApiConstant.baseUrl}${searchFriend?.image}")),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  CustomText(
                                      left: 16.w,
                                      fontSize: 18,
                                      color: AppColors.blue_800,
                                      text: "${searchFriend?.fullName}")
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
