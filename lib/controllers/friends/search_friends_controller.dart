

import 'dart:convert';

import 'package:dialogi_app/models/search_friends_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class SearchFriendsController extends GetxController{

  TextEditingController searchController = TextEditingController();
  Status status = Status.completed;
  SearchFriendsModel searchResult = SearchFriendsModel();
  List searchFriendsList = [];

  Future<void> getSearchedResult(String searchedName) async {
      status = Status.loading;
      update();

    var response = await ApiService.getApi(
        "${ApiConstant.users}?search=$searchedName");

    if (response.statusCode == 200) {
      print(response.responseJson);
      searchResult = SearchFriendsModel.fromJson(jsonDecode(response.responseJson));

      print("=======>>> ${searchResult.data?.attributes?.userList?[0].fullName} <<<=========");
      if(searchResult.data?.attributes?.userList != null && searchResult.data!.attributes!.userList!.isNotEmpty){
        searchFriendsList.addAll(searchResult.data!.attributes!.userList!);
      }

      // page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }
}