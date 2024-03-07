import 'package:dialogi_app/controllers/chat/chat_list_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/container/custom_chat_list.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../services/api_url.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  ChatListController chatListController = Get.put(ChatListController());

  @override
  void initState() {
    chatListController.listenMessage();
    chatListController.chatRepo();
    chatListController.scrollController.addListener(() {
      chatListController.scrollControllerCall();
    });
    super.initState();
  }

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
          CustomText(
            text: AppStrings.chatList,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blue_500,
          ),
          const SizedBox()
        ],
      )),
      body: GetBuilder<ChatListController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => ErrorScreen(onTap: () => controller.chatRepo()),
            Status.completed => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: ListView.builder(
                    controller: controller.scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.isMoreLoading
                        ? controller.chatList.length + 1
                        : controller.chatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = controller.chatList[index];

                      if (index < controller.chatList.length) {
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
                              onTap: () async {
                                var data = "";
                                var result = await Get.toNamed(
                                    AppRoutes.chatScreen,
                                    arguments: data,
                                    parameters: {
                                      "chatId": controller.chatList[index].sId,
                                      "type": item.type,
                                      "name": item.type == "single"
                                          ? item.participants[0].fullName
                                          : item.groupName
                                    });

                                print(
                                    "return data ====================================================>$result");
                                controller.chatList.clear();
                                controller.page = 1;
                                controller.chatRepo();
                              },
                              image:
                                  "${ApiConstant.baseUrl}/${item.type == "single" ? item.participants[0].image : item.image}",
                              text: item.type == "single"
                                  ? item.participants[0].fullName
                                  : item.groupName,
                              description: item.latestMessage != null
                                  ? item.latestMessage.message
                                  : ""),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
          };
        },
      ),
    );
  }
}
