import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/custom_card/custom_card.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/no_data.dart';
import 'package:dialogi_app/view/widgets/subscription_popup/subcription_popup.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/api_url.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    categoryController.page = 1;
    categoryController.categoryRepo();
    categoryController.scrollController.addListener(() {
      categoryController.scrollControllerCall();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
            text: AppStrings.category.tr,
          ),
        ],
      )),
      //
      bottomNavigationBar: const NavBar(currentIndex: 1),
      body: GetBuilder<CategoryController>(builder: (controller) {
        return switch (controller.status) {
          Status.loading => const Center(child: CircularProgressIndicator()),
          Status.error => ErrorScreen(onTap: () {
              controller.page = 1;
              controller.categoryRepo();
            }),
          Status.completed =>

          controller.categoryList.isNotEmpty

             ? GridView.builder(
              controller: controller.scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.isMoreLoading
                  ? controller.categoryList.length + 1
                  : controller.categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250.h,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h),
              itemBuilder: (context, index) {
                print(
                    "=============================> controller ${controller.categoryList.length}");

                if (index < controller.categoryList.length) {
                  return GestureDetector(
                    onTap: () {
                      if (Homecontroller.status == Status.completed) {
                        controller.getContextStatus();
                        if (Homecontroller.accessStatusModel!.data!
                                .categoryAccessNumber !=
                            0) {
                          Get.toNamed(AppRoutes.categoryDetails, parameters: {
                            "titleGr" : controller.categoryList[index].nameGr,
                            "title": controller.categoryList[index].name,
                            "categoryId": controller.categoryList[index].sId
                          });
                        } else {
                          SubscriptionPopup.showPopUpPremiumPackage();
                        }
                      } else {
                        Homecontroller.getAccessStatus();
                      }
                    },
                    child: CustomCard(
                        img:
                            "${ApiConstant.baseUrl}${controller.categoryList[index].image}",
                        title: PrefsHelper.localizationLanguageCode == "en"
                            ? controller.categoryList[index].name.toString()
                            : controller.categoryList[index].nameGr.toString(),
                        queNum: controller.categoryList[index].questionCount
                            .toString()),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
              :const NoData()
        };
      }),
    );
  }
}
