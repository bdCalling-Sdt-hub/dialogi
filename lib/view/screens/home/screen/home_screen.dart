import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/home/screen/inner_widgets/home_drawer.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/custom_card/custom_card.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Homecontroller homecontroller = Get.put(Homecontroller());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Homecontroller.getAccessStatus();
    homecontroller.categoryAccessRepo(1, 1);
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
              child: const Icon(Icons.menu, size: 36,)),
          const Spacer(),
          GestureDetector(
            onTap: (){
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
      body: GetBuilder<Homecontroller>(
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: Get.height * 0.25,
                  width: Get.width,
                  child: ListView.builder(
                    itemCount: 5,
                      itemBuilder: (BuildContext context, int index){
                      return Container();
                      },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.49,
                  width: Get.width,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250.h,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.categoryDetails,
                              parameters: {"title": "Friends"});
                        },
                        child: const CustomCard(
                            img:
                            "https://images.unsplash.com/photo-1522098635833-216c03d81fbe?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZnJpZW5kfGVufDB8fDB8fHww",
                            title: "Friends",
                            queNum: "40"),
                      );
                    },
                  ),
                )
              ],
            );
      }),
    );
  }
}
