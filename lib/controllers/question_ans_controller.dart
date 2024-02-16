import 'dart:convert';

import 'package:dialogi_app/controllers/category/category_controller.dart';
import 'package:dialogi_app/controllers/category/sub_category_controller.dart';
import 'package:dialogi_app/models/question_ans_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/prefs_helper.dart';
import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class QuestionAnsController extends GetxController {
  bool isLoading = false;

  QuestionAnsModel? questionAnsModel;
  List questionsList = [];

  int page = 1;

  CategoryController categoryController = Get.put(CategoryController());

  SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  Future<void> questionsRepo(String subCategory) async {
    isLoading = true;
    update();

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    var response = await ApiService.getApi(
        "${ApiConstant.questions}/$subCategory/${categoryController.categoryId}?limit=1",
        header);

    if (response.statusCode == 200) {
      print(response.responseJson);
      questionAnsModel =
          QuestionAnsModel.fromJson(jsonDecode(response.responseJson));

      for (var item in questionAnsModel!.data!.attributes!.questions!) {
        questionsList.add(item);
      }

      page = page + 1;

      print(
          "========================================. ${response.responseJson}");
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);

    }

    isLoading = false;
    update();
  }
}
