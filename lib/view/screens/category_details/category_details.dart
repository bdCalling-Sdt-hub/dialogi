import 'package:dialogi_app/controllers/category/sub_category_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
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

  @override
  void initState() {
    subCategoryController.page = 1;
    subCategoryController.subCategoryRepo();
    subCategoryController.scrollController.addListener(() {
      subCategoryController.scrollControllerCall();
    });
    // TODO: implement initState
    super.initState();
  }

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
        body: GetBuilder<SubCategoryController>(builder: (controller) {
          return Padding(
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
                    child: controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
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
                                    Get.toNamed(AppRoutes.questionAns,
                                        parameters: {"title": "Close Friend"});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.r),
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.black_50),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.whiteColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Title

                                        CustomText(
                                          text: controller
                                              .subCategoryList[index]
                                              .subCategory,
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
                          ))
              ],
            ),
          );
        }));
  }
}
