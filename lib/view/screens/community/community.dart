import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Community extends StatelessWidget {
  const Community({super.key});

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
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.groupChat);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 110.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.whiteColor),
              child: Row(children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(16.w),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29tbXVuaXR5fGVufDB8fDB8fHww"))),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Community",
                        fontSize: 18.w,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        text: "Lorem ipsum dolor sit amet",
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
    );
  }
}
