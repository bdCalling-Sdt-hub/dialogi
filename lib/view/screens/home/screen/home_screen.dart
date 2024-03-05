import 'package:dialogi_app/controllers/profile_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/home/screen/inner_widgets/home_drawer.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../../helper/prefs_helper.dart';
import '../../../../services/api_url.dart';
import '../../../widgets/error/error_screen.dart';
import '../../../widgets/text/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Homecontroller homecontroller = Get.put(Homecontroller());
  ProfileController profileController = Get.put(ProfileController()) ;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Homecontroller.getAccessStatus();
    profileController.profileRepo() ;

    homecontroller.categoryAccessRepo();
    homecontroller.categoryScrollController.addListener(() {
      homecontroller.scrollControllerCall();
    });
    homecontroller.earlyAccessScrollController.addListener(() {
      homecontroller.scrollControllerCall();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "===========================================> token ${PrefsHelper.token}");
    print(
        "===========================================> clientId ${PrefsHelper.clientId}");
    print(
        "===========================================> myName ${PrefsHelper.myName}");
    print(
        "===========================================> myImage ${PrefsHelper.myImage}");
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: const NavBar(currentIndex: 0),
      drawer: Drawer(
        backgroundColor: AppColors.background,
        elevation: 0,
        width: MediaQuery.of(context).size.width * .7,
        child: const HomeDrawer(),
      ),
      appBar: CustomAppBar(
          appBarContent: Row(
        children: [
          GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 36,
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {
              homecontroller.showPopUpPremiumPackage();
            },
            child: const CustomImage(
              imageSrc: AppIcons.crown,
              size: 32,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 24,
              )),
          SizedBox(
            width: 16.w,
          ),
          GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.chatListScreen);
              },
              child: const CustomImage(
                imageSrc: AppIcons.chat,
                size: 32,
              )),
        ],
      )),
      body: GetBuilder<Homecontroller>(builder: (controller) {
        return switch (controller.homeStatus) {
          Status.loading => Center(child: CircularProgressIndicator()),
          Status.error => ErrorScreen(
              onTap: () => controller.categoryAccessRepo(),
            ),
          Status.completed => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.earlyAccess.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          left: 4,
                          text: AppStrings.getEarlyAccess,
                          color: AppColors.black_500,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),

                        ///<<<======================== EarlyAccess List Items ===============>>>
                        SizedBox(
                          height: Get.height * 0.25,
                          width: Get.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: controller.earlyAccessScrollController,
                            itemCount: controller.earlyAccess.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < controller.earlyAccess.length) {
                                var item = controller.earlyAccess[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.categoryDetails,
                                        parameters: {
                                          "accessStatus": "true",
                                          "title": item.name!,
                                          "categoryId": item.sId!
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: Get.height * 0.25,
                                          width: Get.height * 0.2,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: AppColors.black_100,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2))
                                              ],
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0,
                                                    right: 8.0,
                                                    left: 8.0),
                                                child: Container(
                                                  height: Get.height * 0.15,
                                                  width: Get.height * 0.15,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "${ApiConstant.baseUrl}${item.image}",
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              CustomText(
                                                fontSize: 18,
                                                right: 8.w,
                                                text: "${item.name}",
                                                color: AppColors.blue_500,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            top: -10,
                                            left: -10,
                                            child: Transform.rotate(
                                              angle: math.pi / -6,
                                              child: const SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/earlyAccessBadge.png"),
                                                    fit: BoxFit.fill,
                                                  )),
                                            ))
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
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(),
                        ),
                      ],
                    ),

                  ///<<<======================== Category List Items ===============>>>
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomText(
                    left: 4,
                    text: AppStrings.categoryList,
                    color: AppColors.black_500,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                          controller: controller.categoryScrollController,
                          itemCount: controller.categoryList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 220,
                                  crossAxisSpacing: 8.w,
                                  mainAxisSpacing: 8.h),
                          itemBuilder: (context, index) {
                            var item = controller.categoryList[index];
                            if (index < controller.categoryList.length) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.categoryDetails,
                                        parameters: {
                                          "accessStatus": "false",
                                          "title": item
                                              .name!,
                                          "categoryId": item
                                              .sId!
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: AppColors.black_100,
                                              blurRadius: 3,
                                              offset: Offset(0, 2))
                                        ],
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, right: 8.0, left: 8.0),
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${ApiConstant.baseUrl}${item.image}",
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        CustomText(
                                          fontSize: 18,
                                          right: 8.w,
                                          text: "${item.name}",
                                          color: AppColors.blue_500,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              fontSize: 14,
                                              right: 8.w,
                                              text: "${AppStrings.ques}.",
                                              color: AppColors.black_500,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            CustomText(
                                              fontSize: 18,
                                              right: 8.w,
                                              text: "${item.questionCount}",
                                              color: AppColors.black_500,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
        };
      }),
    );
  }
}
