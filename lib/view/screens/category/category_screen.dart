import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/custom_card/custom_card.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            appBarContent: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blue_500,
              text: AppStrings.category,
            ),
          ],
        )),
        bottomNavigationBar: const NavBar(currentIndex: 1),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: 6,
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
        ));
  }
}
