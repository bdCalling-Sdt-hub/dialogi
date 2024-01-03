import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    String? title = Get.parameters["title"];
    return Scaffold(
        //App Bar

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
                  text: title!,
                ),
              ),
            )
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Sub Category Title
              CustomText(
                text: AppStrings.subCategories,
                right: 20.w,
                fontSize: 18,
                bottom: 16.h,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
              ),

              //Contents

              Expanded(
                  child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.questionAns,
                          parameters: {"title": "Close Friend"});
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black_50),
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.whiteColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Title

                          CustomText(
                            text: "Close Friend",
                          ),

                          //Question Ammount

                          CustomText(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue_500,
                            text: "21",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ));
  }
}
