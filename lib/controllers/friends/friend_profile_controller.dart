import 'dart:convert';

import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/friend_profile_model.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../global/api_response_model.dart';
import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../services/socket_service.dart';
import '../../utils/app_utils.dart';

class FriendProfileController extends GetxController {
  Status status = Status.completed;
  bool sendIsLoading = false;

  FriendProfileModel? friendProfileModel;

  Future<void> friendProfileRepo(String userId) async {
    status = Status.loading;
    update();

    var response =
        await ApiService.getApi("${ApiConstant.friendProfile}/$userId");

    if (response.statusCode == 200) {
      print(response.responseJson);
      friendProfileModel =
          FriendProfileModel.fromJson(jsonDecode(response.responseJson));

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  Future<void> sendRequestRepo(String participantId) async {
    sendIsLoading = true;
    update();
    Map<String, String> body = {
      "participantId": participantId,
    };

    var response = await ApiService.postApi(
      ApiConstant.friends,
      body,
    );

    print("===========${jsonDecode(response.responseJson)}===========");

    if (response.statusCode == 201) {
      friendProfileModel!.data!.attributes!.friendRequestStatus = "pending";
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    sendIsLoading = false;
    update();
  }

  createChatRoom(String userId) async {
    var body = {
      "participants": [userId, PrefsHelper.clientId],
      "subscription": "premium-plus"
      //groupName = "xyz"
      //type = ""
      //groupAdmin = "user ID"
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("add-new-chat", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");

      Get.toNamed(AppRoutes.chatScreen,
          parameters: {"chatId": data['data']['chatId']});
    });
  }
}
