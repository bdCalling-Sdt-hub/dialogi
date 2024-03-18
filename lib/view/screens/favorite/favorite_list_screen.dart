import 'package:dialogi_app/controllers/favourite_controller.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/view/widgets/error/error_screen.dart';
import 'package:dialogi_app/view/widgets/no_data.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/static_strings.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  void initState() {
    favouriteController.getFavouriteRepo();
    favouriteController.scrollController.addListener(() {
      favouriteController.scrollControllerCall() ;
    }) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.favoriteList.tr),
        centerTitle: true,
      ),
      body: GetBuilder<FavouriteController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            Status.error => ErrorScreen(onTap: () {
                controller.page = 1;
                controller.getFavouriteRepo();
              }),
            Status.completed =>

            controller.favouriteList.isEmpty
            ? const NoData() :
                ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.isMoreLoading
                    ? controller.favouriteList.length + 1
                    : controller.favouriteList.length,
                itemBuilder: (context, index) {
                  var item = controller.favouriteList[index].question;

                  if (index < controller.favouriteList.length) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColors.black_500, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: Center(
                                child: CustomText(
                              text: "?",
                              fontSize: 20.sp,
                            )),
                          ),
                          title: Text(item.question),
                        ),
                        const Divider()
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          };
        },
      ),
    );
  }
}
