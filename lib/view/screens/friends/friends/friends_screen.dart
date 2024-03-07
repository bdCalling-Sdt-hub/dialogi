import 'package:dialogi_app/controllers/friends/friend_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_all_friends.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:dialogi_app/view/widgets/no_data.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    // TODO: implement initState
    friendController.friendListRepo();
    friendController.scrollController.addListener(() {
      friendController.scrollControllerCall();
    });
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
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: () {}),
            Status.completed => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: controller.friendList.isNotEmpty
                    ? ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.isMoreLoading
                            ? controller.friendList.length + 1
                            : controller.friendList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = controller.friendList[index];

                          if (index < controller.friendList.length) {
                            return Column(
                              children: [
                                CustomAllFriends(
                                    imageSrc:
                                        "${ApiConstant.baseUrl}/${item.participants[0].image}",
                                    text: item.participants[0].fullName,
                                    icon: AppIcons.chat,
                                    onTap: () => controller.createChatRoom(
                                        item.participants[0].sId,
                                        item.participants[0].fullName)
                                    // onTap: () => controller.addNewChat(),
                                    ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })
                    : const NoData())
          };
        }));
  }
}
