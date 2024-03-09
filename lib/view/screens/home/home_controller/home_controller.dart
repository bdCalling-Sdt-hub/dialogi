import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/access_status_model.dart';
import 'package:dialogi_app/models/home_categories_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../services/socket_service.dart';
import '../../../../utils/app_constants.dart';

class Homecontroller extends GetxController with GetxServiceMixin {
  static Status status = Status.loading;
  Status homeStatus = Status.loading;

  List earlyAccess = [];

  List categoryList = [];

  static AccessStatusModel? accessStatusModel;
  HomeCategoriesModel? homeCategoriesModel;
  final ScrollController categoryScrollController = ScrollController();
  final ScrollController earlyAccessScrollController = ScrollController();

  int pageEr = 1;
  int page = 1;

  ///<<<==================== Page Scroll Method ==================================>>>
  Future<void> scrollControllerCall() async {
    if (categoryScrollController.position.pixels ==
        categoryScrollController.position.maxScrollExtent) {
      await categoryAccessRepo();
    }
    if (earlyAccessScrollController.position.pixels ==
        earlyAccessScrollController.position.maxScrollExtent) {
      await categoryAccessRepo();
    }
  }

  ///<<<=================== Category Access Repo ==============================>>>

  Future<void> categoryAccessRepo() async {
    if (pageEr == 1 && page == 1) {
      categoryList.clear();
      earlyAccess.clear() ;
      homeStatus = Status.loading;
      update();
    }

    try {
      var response = await ApiService.getApi(
              "${ApiConstant.categoryType}?pageEr=$pageEr&page=$page")
          .timeout(const Duration(seconds: 30));

      print("Response json : ${response.responseJson}");
      if (response.statusCode == 200) {
        homeCategoriesModel =
            HomeCategoriesModel.fromJson(jsonDecode(response.responseJson));

        if (homeCategoriesModel?.data?.attributes?.categoryList != null) {
          categoryList
              .addAll(homeCategoriesModel!.data!.attributes!.categoryList!);
        }

        if (homeCategoriesModel?.data?.attributes?.earlyAccessList != null) {
          earlyAccess
              .addAll(homeCategoriesModel!.data!.attributes!.earlyAccessList!);
        }

        page = page + 1;
        pageEr = pageEr + 1;
        homeStatus = Status.completed;
        update();
      } else {
        homeStatus = Status.error;
      }
    } catch (exception) {
      Fluttertoast.showToast(msg: AppConstants.connectionTimedOUt);
      log(exception.toString());
    }
  }

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

                  CustomText(
                    maxLines: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    text: AppStrings.upgradetoPremiumfor.tr,
                  ),

                  CustomElevatedButton(
                      buttonHeight: 40,
                      titleSize: 14,
                      onPressed: () {
                        Get.toNamed(AppRoutes.premiumScreen);
                      },
                      titleText: AppStrings.gotoSubscriptions.tr),
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

