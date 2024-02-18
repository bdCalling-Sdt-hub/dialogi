import 'dart:convert';

import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/models/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class SubCategoryController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List subCategoryList = [];

  SubCategoryModel? subCategoryModel;

  CategoryController categoryController = Get.put(CategoryController());

  int page = 1;
  final ScrollController scrollController = ScrollController();

  // @override
  // void onInit() {
  //   page = 1;
  //   subCategoryRepo();
  //   scrollController.addListener(() {
  //     scrollControllerCall();
  //   });
  //
  //   print("=========================> ${categoryController.categoryId}");
  //   super.onInit();
  // }

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await subCategoryRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> subCategoryRepo() async {
    if (page == 1) {
      isLoading = true;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    var response = await ApiService.getApi(
        "${ApiConstant.subCategory}/${categoryController.categoryId}?page=$page&limit=15",
        header:header);

    if (response.statusCode == 200) {
      print(response.responseJson);
      subCategoryModel =
          SubCategoryModel.fromJson(jsonDecode(response.responseJson));

      for (var item in subCategoryModel!.data!.attributes!.subCategoryList!) {
        subCategoryList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }
}
