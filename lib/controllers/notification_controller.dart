import 'dart:convert';

import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/notifications_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class NotificationsController extends GetxController {
  Status status = Status.completed;

  bool isMoreLoading = false;

  int page = 1;
  List notificationsList = [];

  ScrollController scrollController = ScrollController();

  NotificationModel? notificationModel;

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await notificationsRepo();
      isMoreLoading = false;
      update();
    }
  }

  Future<void> notificationsRepo() async {
    if (page == 1) {
      notificationsList.clear();
      status = Status.loading;
      update();
    }

    var response = await ApiService.getApi(ApiConstant.notifications);

    if (response.statusCode == 200) {
      print(response.responseJson);
      notificationModel =
          NotificationModel.fromJson(jsonDecode(response.responseJson));

      if (notificationModel?.data?.attributes?.notificationList != null) {
        notificationsList
            .addAll(notificationModel!.data!.attributes!.notificationList!);
      }

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  String getFormattedDate(String dateString) {
    // String dateString = "2024-02-01T04:39:03.524Z";
    DateTime originalDateTime = DateTime.parse(dateString);
    DateTime currentDateTime = DateTime.now();

    Duration difference = currentDateTime.difference(originalDateTime);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return ("${difference.inMinutes} minutes ago");
      } else {
        return ("${difference.inHours} hours ago");
      }
    } else {
      var createdAtTime = dateString.split(".")[0];
      var date = createdAtTime.split("T")[0];
      var time = createdAtTime.split("T")[1];
      return "${date} at $time";
    }
  }
}
