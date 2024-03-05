import 'dart:convert';

import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/models/sub_category_model.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../helper/prefs_helper.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';

class SubCategoryController extends GetxController {
  Status status = Status.completed;

  bool isMoreLoading = false;
  List subCategoryList = [];

  SubCategoryModel? subCategoryModel;
  CategoryController categoryController = Get.put(CategoryController());

  int page = 1;
  final ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall(String categoryId,bool accessStatus) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await subCategoryRepo(categoryId, accessStatus);
      isMoreLoading = false;
      update();
    }
  }

  Future<void> subCategoryRepo(String categoryId, bool accessStatus) async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    var response = await ApiService.getApi(
        "${ApiConstant.subCategory}/$categoryId?page=$page&limit=15&accessStatus=$accessStatus",
        header: header);

    if (response.statusCode == 200) {
      print(response.responseJson);
      subCategoryModel =
          SubCategoryModel.fromJson(jsonDecode(response.responseJson));

      for (var item in subCategoryModel!.data!.attributes!.subCategoryList!) {
        subCategoryList.add(item);
      }
      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }
}
