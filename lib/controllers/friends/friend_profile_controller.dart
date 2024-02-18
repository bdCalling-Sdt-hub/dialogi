import 'dart:convert';

import 'package:dialogi_app/models/friend_profile_model.dart';
import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../../services/api_url.dart';
import '../../utils/app_utils.dart';

class FriendProfileController extends GetxController {
  bool isLoading = false;
  bool sendIsLoading = false;

  FriendProfileModel? friendProfileModel;

  Future<void> friendProfileRepo(String userId) async {
    isLoading = true;
    update();

    var response =
        await ApiService.getApi("${ApiConstant.friendProfile}/$userId");

    if (response.statusCode == 200) {
      print(response.responseJson);
      friendProfileModel =
          FriendProfileModel.fromJson(jsonDecode(response.responseJson));
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
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
      friendProfileModel!.data!.attributes!.friendRequestStatus = "pending" ;
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    sendIsLoading = false;
    update();
  }
}
