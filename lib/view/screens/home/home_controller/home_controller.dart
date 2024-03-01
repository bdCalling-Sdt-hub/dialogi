import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/access_status_model.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../services/socket_service.dart';

class Homecontroller extends GetxController with GetxServiceMixin {
  static Status status = Status.loading;

  static AccessStatusModel? accessStatusModel;

  static getAccessStatus({bool isPopUp = false}) async {
    status = Status.loading;

    var body = {"userId": PrefsHelper.clientId};

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("dialogi-access-status", body,
        ack: (data) {
      var check = data['status'];

      if (check == "Error") {
        status = Status.error;
      } else {
        accessStatusModel = AccessStatusModel.fromJson(data);
        status = Status.completed;
      }

      print(
          "===============================================================> Received acknowledgment: $data");
    });
  }

  void showPopUpPremiumPackage() {
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          child: Container(
            height: 300.h,
            width: 300.w,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.r),
                  //     child: CustomImage(imageSrc: AppIcons.cancel),
                  //   ),
                  // ),
                  CustomImage(
                    imageSrc: AppIcons.crown,
                    size: 60.r,
                  ),

                  const CustomText(
                    maxLines: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    text: AppStrings.upgradetoPremiumfor,
                  ),

                  CustomElevatedButton(
                      buttonHeight: 40,
                      titleSize: 14,
                      onPressed: () {
                        Get.toNamed(AppRoutes.subscriptionsScreen);
                      },
                      titleText: AppStrings.gotoSubscriptions),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void onReady() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (status == Status.completed) {
          if (accessStatusModel!.data!.type == "default") {
            showPopUpPremiumPackage();
          }
        }
      },
    );

    super.onReady();
  }
}
