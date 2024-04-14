import 'dart:convert';

import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/access_status_model.dart';
import 'package:dialogi_app/models/category_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/utils/app_utils.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';

class CategoryController extends GetxController {
  Status status = Status.completed;

  Status statusMore = Status.completed;

  bool isMoreLoading = false;
  List categoryList = [];
  CategoryModel? categoryModel;
  int page = 1;
  final ScrollController scrollController = ScrollController();



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
      categoryList.clear() ;
      status = Status.loading;
      update();
    }

    Map<String, String> header = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };
    var response = await ApiService.getApi(
        "${ApiConstant.categories}?page=$page&accessStatus=false",
        header: header);

    if (response.statusCode == 200) {
      categoryModel = CategoryModel.fromJson(jsonDecode(response.responseJson));

      for (var item in categoryModel!.data!.attributes!.categoryList!) {
        categoryList.add(item);
      }
      page = page + 1;

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.completed;
      update();
    }
  }

  getContextStatus() async {
    Homecontroller.status = Status.loading;
    update();

    var body = {
      "userId": PrefsHelper.clientId,
      "type": "category",

    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("dialogi-content-access", body,
        ack: (data) {
      var check = data['status'];

      if (check == "Error") {
        Homecontroller.status = Status.error;
      } else {
        Homecontroller.accessStatusModel = AccessStatusModel.fromJson(data);
        Homecontroller.status = Status.completed;
      }

      print(
          "===============================================================> Received acknowledgment: $data");
    });
  }
}
