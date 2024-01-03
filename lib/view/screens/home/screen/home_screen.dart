import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/home/screen/inner_widgets/home_drawer.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/custom_card/custom_card.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
                child: CustomImage(
                  imageSrc: AppIcons.drawer,
                  size: 32.r,
                )),
            const Spacer(),
            const CustomImage(
              imageSrc: AppIcons.crown,
              size: 32,
            ),
            SizedBox(
              width: 16.w,
            ),
            GestureDetector(
                onTap: () {},
                child: const CustomImage(
                  imageSrc: AppIcons.chat,
                  size: 32,
                )),
          ],
        )),
        body: GetBuilder<Homecontroller>(builder: (controller) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 240.h,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: const CustomCard(
                    img:
                        "https://images.unsplash.com/photo-1522098635833-216c03d81fbe?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZnJpZW5kfGVufDB8fDB8fHww",
                    title: "Friends",
                    queNum: "40"),
              );
            },
          );
        }),
      ),
    );
  }
}
