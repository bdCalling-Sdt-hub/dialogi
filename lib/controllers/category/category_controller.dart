import 'dart:convert';

import 'package:dialogi_app/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../../services/api_url.dart';

class CategoryController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  List categoryList = [];
  CategoryModel? categoryModel;
  int page = 1;
  final ScrollController scrollController = ScrollController();

  var categoryId = "";

  @override
  void onInit() {
    page = 1;
    categoryRepo();
    scrollController.addListener(() {
      scrollControllerCall();
    });
    super.onInit();
  }

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

    var response =
        await ApiClient.getData("${ApiConstant.categories}?page=$page");

    if (response.statusCode == 200) {
      categoryModel = CategoryModel.fromJson(response.body);

      for (var item in categoryModel!.data!.attributes!.categoryList!) {
        categoryList.add(item);
      }
      page = page + 1;
    }

    isLoading = false;
    update();
  }
}
