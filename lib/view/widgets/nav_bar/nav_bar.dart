/*
import 'package:flutter/material.dart';
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
    AppIcons.home_2,
    AppIcons.noteText,
    AppIcons.emptyWallet,
    AppIcons.phCookingPotLight,
    AppIcons.profileCircle,
  ];

 */
/* List<String> selectedText = [
    AppStrings.home,
    AppStrings.search,
    "Settings",
  ];*//*


  List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.note,
    AppIcons.walletEm,
    AppIcons.phCooking,
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
      height: 90,
      width: MediaQuery.of(context).size.width,
      padding:
      const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),

      alignment: Alignment.center,
      color: AppColors.background,
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
                    ? SvgPicture.asset(selectedIcon[index],color: AppColors.primaryColor,
                    height: 24, width: 24)
                    : SvgPicture.asset(unselectedIcon[index],color: AppColors.primaryColor,
                    height: 24, width: 24),
               */
/* const SizedBox(height: 4,),
                CustomText(
                  color: index == bottomNavIndex
                      ? AppColors.black_400
                      : AppColors.white.withOpacity(.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  text: selectedText[index],
                ),*//*

                index == bottomNavIndex
                    ? Container(
                  width: 8,
                  height: 8,
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
        Get.offAll(() => const HomeScreen(),transition: Transition.noTransition);
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAll(() => const WorkSchedule(),transition: Transition.noTransition);
      }
    }  else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAll(() => const WalletScreen(),transition: Transition.noTransition);
      }
    }
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAll(() => const RecipeScreen(),transition: Transition.noTransition);
      }
    }
    else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.offAll(() => const ProfileScreen( ),transition: Transition.noTransition);
      }
    }
  }
}*/
