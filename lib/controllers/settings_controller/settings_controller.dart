import 'dart:convert';

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/models/faq_content_model.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:get/get.dart';

import '../../models/content_model.dart';
import '../../services/api_services.dart';

class SettingsController extends GetxController {
  ContentModel? contentModelInfo;
  FaqContentModel? faqContentModelData;

  RxBool isLoading = false.obs;
  RxBool isGetData = false.obs;

  ApiService apiService = ApiService();

  ///<<<======================= About Us Repo ================================>>>

  Future<void> aboutUsRepo() async {
    isLoading.value = true;

    Get.toNamed(AppRoutes.aboutUsScreen);

    Map<String, String> header = {};

    ApiService.getApi(ApiConstant.aboutUs, header:header)
        .then((apiResponseModel) {
      print(
          "=========> ${apiResponseModel.statusCode}<===> ${apiResponseModel.responseJson}<========");

      if (apiResponseModel.statusCode == 200) {

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        contentModelInfo = ContentModel.fromJson(jsonData);
        print("=========>${contentModelInfo!.data!.attributes!.content}<========");

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
      isLoading.value = false;
      update();
    });
  }

  ///<<<====================== Supports Repo =================================>>>

  Future<void> supportsRepo() async {

    isLoading.value = true;
    contentModelInfo= null;

    Get.toNamed(AppRoutes.supportScreen);

    Map<String, String> header = {};

    ApiService.getApi(ApiConstant.supports, header:header)
        .then((apiResponseModel) {
      print("=========> ${apiResponseModel.statusCode}<===> ${apiResponseModel.responseJson}<========");

      if (apiResponseModel.statusCode == 200) {

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        contentModelInfo = ContentModel.fromJson(jsonData);
        print("=========>${contentModelInfo!.data!.attributes!.content}<========");

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
      isLoading.value = false;
    });
  }

  ///<<<======================= FAQ Repo ====================================>>>

  Future<void> faqRepo() async {

    isLoading.value = true;
    contentModelInfo = null;

    Get.toNamed(AppRoutes.faqScreen);

    Map<String, String> header = {};

    ApiService.getApi(ApiConstant.faqs, header:header)
        .then((apiResponseModel) {

      print("=========> ${apiResponseModel.statusCode}<===> ${apiResponseModel.responseJson}<========");

      if (apiResponseModel.statusCode == 200) {

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        faqContentModelData = FaqContentModel.fromJson(jsonData);
        print("=========>${faqContentModelData!.data!.attributes![0].question}<========");
        print("=========>${faqContentModelData!.data!.attributes![0].answer}<========");
        isGetData.value = true;

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
        isGetData.value = false;
      }
      isLoading.value = false;
    });
  }

  ///<<<====================== Privacy Policy Repo ==========================>>>

  Future<void> privacyPolicyRepo() async {

    isLoading.value = true;
    contentModelInfo = null;

    Get.toNamed(AppRoutes.privacyPolicyScreen);

    Map<String, String> header = {};

    ApiService.getApi(ApiConstant.privacyPolicy, header:header)
        .then((apiResponseModel) {

      print("=========> ${apiResponseModel.statusCode}<===> ${apiResponseModel.responseJson}<========");

      if (apiResponseModel.statusCode == 200) {

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        contentModelInfo = ContentModel.fromJson(jsonData);
        print("=========>${contentModelInfo!.data!.attributes!.content}<========");

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
      isLoading.value = false;
    });
  }
}
