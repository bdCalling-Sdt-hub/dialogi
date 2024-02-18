import 'dart:convert';

import 'package:dialogi_app/models/category_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';
import '../../services/api_url.dart';

class CategoryController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List categoryList = [];
  CategoryModel? categoryModel;
  int page = 1;
  final ScrollController scrollController = ScrollController();

  var categoryId = "";


  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await categoryRepo();
      isMoreLoading = false;
      update();
    } else {}
  }

  Future<void> categoryRepo() async {
    print("=====================================> page $page");

    if (page == 1) {
      isLoading = true;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };
    var response =
        await ApiService.getApi("${ApiConstant.categories}?page=$page",header: header);

    if (response.statusCode == 200) {
      categoryModel = CategoryModel.fromJson(jsonDecode(response.responseJson));

      for (var item in categoryModel!.data!.attributes!.categoryList!) {
        categoryList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }
}
