import 'dart:convert';

import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class FavouriteController extends GetxController {
  Status status = Status.completed;
  bool isMoreLoading = false;

  FavouriteModel? favouriteModel;
  List favouriteList = [];

  int page = 1;
  ScrollController scrollController = ScrollController();

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await getFavouriteRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> getFavouriteRepo() async {
    if (page == 1) {
      status = Status.loading;
      update();
    }

    var response =
        await ApiService.getApi("${ApiConstant.favourite}?page=$page");

    if (response.statusCode == 200) {
      print(response.responseJson);

      favouriteModel =
          FavouriteModel.fromJson(jsonDecode(response.responseJson));

      if (favouriteModel?.data?.attributes?.favouriteList != null ||
          favouriteModel!.data!.attributes!.favouriteList!.isNotEmpty) {
        favouriteList.addAll(favouriteModel!.data!.attributes!.favouriteList!);
      }

      page = page + 1;

      print(
          "========================================. ${favouriteList.length}");
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }
}
