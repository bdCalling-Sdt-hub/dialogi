import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_chat_list.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBarContent: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const CustomImage(
                imageSrc: AppIcons.chevronLeft,
                size: 24,
              )),
          const CustomText(
            text: AppStrings.chatList,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox(),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (BuildContext context,int index){
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        onPressed: (v) {},
                        backgroundColor: AppColors.red_500,
                        icon: Icons.delete),
                  ],
                ),
                child: CustomChatList(
                  onTap: (){
                    Get.toNamed(AppRoutes.chatScreen);
                  },
                    image:
                    'https://images.unsplash.com/photo-1704044843056-f58d8c147f88?q=80&w=1970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    text: 'Mr. Abel',
                    description: 'Lorem ipsum dolor sit amet...'),
              );
            }),
      ),
    );
  }
}
