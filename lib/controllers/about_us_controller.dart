import 'dart:convert';

import 'package:dialogi_app/models/flutter_html_content.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import '../services/api_url.dart';
import '../utils/app_utils.dart';

class AboutUsController extends GetxController {
  bool isLoading = false;

  String content = "";

  FlutterHTMLContent? htmlContent;

  Future<void> aboutUsRepo() async {
    content = '';
    isLoading = true;
    update();

    Map<String, String> header = {
      // 'Authorization': "Bearer ${PrefsHelper.token}"
    };
    var response =
        await ApiService.getApi(ApiConstant.aboutUs, header, isHeader: false);

    if (response.statusCode == 200) {
      htmlContent =
          FlutterHTMLContent.fromJson(jsonDecode(response.responseJson));

      content = htmlContent!.data!.attributes!.content!;
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
