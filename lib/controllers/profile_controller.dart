import 'dart:convert';
import 'dart:io';

import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/models/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/app_routes.dart';
import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class ProfileController extends GetxController {
  Status status = Status.completed;

  String? image;

  ProfileModel profileModel = ProfileModel();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  Future<void> profileRepo() async {
    status = Status.loading;
    update();

    var response =
        await ApiService.getApi("${ApiConstant.users}/${PrefsHelper.clientId}");

    if (response.statusCode == 200) {
      print(response.responseJson);
      profileModel = ProfileModel.fromJson(jsonDecode(response.responseJson));

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  //Pick Image from Gallary
  selectImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages != null) {
      image = getImages.path;
      update();
    }
  }

  //Pick Image from Camera

  selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      image = getImages.path;
      update();
    }
  }

  Future<void> updateProfileRepo() async {
    Map<String, String> body = {
      "fullName": nameController.text,
      "dateOfBirth": dateController.text,
      "address": addressController.text,
    };

    print("============================================> body $body");
    var response = await ApiService.multipartRequest(
        url: ApiConstant.users, imagePath: image, body: body);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.homeScreen);

      print("=============================================> Update Successful");
    } else {
      print("=============================================> Update Successful");
    }
  }
}
