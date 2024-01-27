import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/screens/category/category_screen.dart';
import 'package:dialogi_app/view/screens/community/community.dart';
import 'package:dialogi_app/view/screens/friends/friends/friends_screen.dart';
import 'package:dialogi_app/view/screens/home/screen/home_screen.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_screen.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> selectedIcon = [
    AppIcons.homeOutline,
    AppIcons.categoryOutline,
    AppIcons.friendselected,
    AppIcons.communitSelected,
    AppIcons.profileOutline,
  ];

  List<String> selectedText = [
    'Home',
    'Category',
    'Friends',
    'Community',
    'Profile'
  ];

  List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.category,
    AppIcons.friendunSelected,
    AppIcons.communityunSelected,
    AppIcons.profile,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
      alignment: Alignment.center,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                index != bottomNavIndex
                    ? SvgPicture.asset(selectedIcon[index],
                        // ignore: deprecated_member_use
                        color: AppColors.blue_500,
                        height: 24.h,
                        width: 24.w)
                    : SvgPicture.asset(unselectedIcon[index],
                        // ignore: deprecated_member_use
                        color: AppColors.blue_500,
                        height: 24.h,
                        width: 24.w),
                const SizedBox(
                  height: 4,
                ),
                CustomText(
                  color: index == bottomNavIndex
                      ? AppColors.black_500
                      : AppColors.black_500,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  text: selectedText[index],
                ),
                index == bottomNavIndex
                    ? Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    // HomeController homeController = Get.find<HomeController>();
    // homeController.scrollController.dispose();
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAll(() => const HomeScreen(),
            transition: Transition.noTransition);
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAll(() => const CategoryScreen(),
            transition: Transition.noTransition);
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAll(() => const FriendsScreen(),
            transition: Transition.noTransition);
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAll(() => const Community(),
            transition: Transition.noTransition);
      }
    } else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.offAll(() => const ProfileScreen(),
            transition: Transition.noTransition);
      }
    }
  }
}
