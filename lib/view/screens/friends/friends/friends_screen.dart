import 'package:dialogi_app/controllers/friends/friend_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/services/socket_service.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/app_images.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_all_friends.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {

  FriendController friendController = Get.put(FriendController()) ;




  @override
  void initState() {
    // TODO: implement initState
    friendController.myFriendRepo();
    friendController.scrollController.addListener(() {
      friendController.scrollControllerCall();
    }) ;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 2),
        appBar: const CustomAppBar(
            appBarContent: Center(
          child: CustomText(
            text: AppStrings.allFriends,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
        )),
        body: GetBuilder<FriendController>(builder: (controller) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: ListView.builder(
                controller: controller.scrollController,
                  itemCount: controller.friendList.length,
                  itemBuilder: (BuildContext context, int index) {

                    var item = controller.friendList[index];
                    return Column(
                      children: [
                        CustomAllFriends(
                          imageSrc: "${ApiConstant.baseUrl}/${item.participants[0].image}",
                          text: item.participants[0].fullName,
                          icon: AppIcons.chat,
                          onTap: () => controller.addNewChat(),
                        ),
                      ],
                    );
                  }));
        }));
  }
}
