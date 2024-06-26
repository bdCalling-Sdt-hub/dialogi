import 'dart:ui';

import 'package:dialogi_app/controllers/category/sub_category_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/no_data.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  SubCategoryController subCategoryController =
      Get.put(SubCategoryController());
  String titleGr = Get.parameters["titleGr"] ?? " ";
  String title = Get.parameters["title"] ?? " ";
  String categoryId = Get.parameters["categoryId"] ?? " ";
  bool accessStatus = Get.parameters["accessStatus"] == "true" ? true : false;

  @override
  void initState() {
    subCategoryController.page = 1;
    subCategoryController.subCategoryRepo(categoryId, accessStatus);
    subCategoryController.scrollController.addListener(() {
      subCategoryController.scrollControllerCall(categoryId, accessStatus);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("=====================================> categoryId $categoryId");
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
                  text: PrefsHelper.localizationLanguageCode == "en"? title : titleGr,
                ),
              ),
            )
          ],
        )),
        body: GetBuilder<SubCategoryController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Sub Category Title
              CustomText(
                text: AppStrings.subCategories.tr,
                right: 20.w,
                fontSize: 18,
                bottom: 16.h,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_500,
              ),

              //Contents

              Expanded(
                  child: switch (controller.status) {
                Status.loading =>
                  const Center(child: CircularProgressIndicator()),
                Status.error => ErrorScreen(onTap: () {
                    controller.page = 1;
                    controller.subCategoryRepo(categoryId, accessStatus);
                  }),
                Status.completed => controller.subCategoryList.isEmpty
                    ? const NoData()
                    : ListView.builder(
                        controller: controller.scrollController,
                        // itemCount: controller.subCategoryList.length,
                        itemCount: controller.isMoreLoading
                            ? controller.subCategoryList.length + 1
                            : controller.subCategoryList.length,
                        itemBuilder: (context, index) {
                          if (index < controller.subCategoryList.length) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.questionAns, parameters: {
                                  "titleGr" : "${controller.subCategoryList[index].subCategoryGr}",
                                  "title": "${controller.subCategoryList[index].subCategory}",
                                  "categoryId": categoryId,
                                  "accessStatus": accessStatus.toString(),
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.r),
                                margin: EdgeInsets.only(bottom: 16.h),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.black_50),
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.whiteColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Title

                                    CustomText(
                                      text: PrefsHelper.localizationLanguageCode == "en"
                                          ? controller.subCategoryList[index].subCategory
                                          : controller.subCategoryList[index].subCategoryGr,
                                    ),

                                    //Question Ammount

                                    CustomText(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blue_500,
                                      text:
                                          "${controller.subCategoryList[index].count ?? 0} ",
                                      // "${index} ",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
              })
            ]),
          );
        }));
  }
}
