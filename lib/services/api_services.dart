import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../../global/api_response_model.dart';
import '../core/app_routes.dart';
import '../helper/prefs_helper.dart';
import 'package:http_parser/http_parser.dart';



///<<<======================= Google Sign In Service ========================>>>

class GoogleSignInService {
  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Static instance of GoogleSignIn>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>///
  static final _googleSignIn = GoogleSignIn();
  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Login method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>///

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Logout method:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>///

  static Future logout() => _googleSignIn.signOut();
}


class ApiService {


  ///<<<======================== Main Header ==============================>>>

  static const int timeOut = 30;

  ///<<<======================== Post Api ==============================>>>

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);

      // if (isHeader) {
      //
      // } else {
      //   final response = await http
      //       .post(Uri.parse(url), body: body)
      //       .timeout(const Duration(seconds: timeOut));
      //   responseJson = handleResponse(response);
      //

      // }
    } on SocketException {
      // Utils.toastMessage("please, check your internet connection");

      Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      // Utils.toastMessage("please, check your internet connection");
      // Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(408, "Request Time Out", "");
    }

    return responseJson;
  }

  ///<<<======================== Get Api ==============================>>>

  static Future<ApiResponseModel> getApi(String url,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    try {
      final response = await http
          .get(Uri.parse(url), headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);

      //
      // if (isHeader) {
      // } else {
      //   // final response =
      //   //     await http.get(Uri.parse(url)).timeout(const Duration(seconds: timeOut));
      //   // responseJson = handleResponse(response);
      // }
    } on SocketException {
      // Utils.toastMessage("please, check your internet connection");
      Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      // Utils.toastMessage("please, check your internet connection");

      // Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(408, "Request Time Out", "");
    }

    return responseJson;
  }

  ///<<<======================== Put Api ==============================>>>

  static Future<ApiResponseModel> putApi(String url, Map<String, String> body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      // Utils.toastMessage("please, check your internet connection");
      Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      // Utils.toastMessage("please, check your internet connection");
      // Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(408, "Request Time Out", "");
    }

    return responseJson;
  }

  ///<<<======================== Patch Api ==============================>>>

  static Future<ApiResponseModel> patchApi(
      String url, Map<String, String> body, Map<String, String> header,
      {isBody = true}) async {
    dynamic responseJson;

    try {
      if (isBody) {
        final response = await http
            .patch(Uri.parse(url), body: body, headers: header)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .patch(Uri.parse(url), headers: header)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      // Utils.toastMessage("please, check your internet connection");
      Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      // Utils.toastMessage("please, check your internet connection");
      // Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(408, "Request Time Out", "");
    }

    return responseJson;
  }

  ///<<<======================== Delete Api ==============================>>>

  static Future<ApiResponseModel> deleteApi(String url, body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}"
    };

    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad response request", '');
    } on TimeoutException {
      // Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(408, "Request time out", "");
    }
    return responseJson;
  }

  ///<<<======================= Multipart Request ============================>>>

  static Future<ApiResponseModel> signUpMultipartRequest(
      {required String url,
        String? imagePath,
        required Map<String,String> body,
        required String otp}) async {

    try{
      var request = http.MultipartRequest('POST', Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if(imagePath != null){
        var mimeType = lookupMimeType(imagePath);
        var img = await http.MultipartFile.fromPath('image', imagePath, contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }

      request.headers["Otp"] = "OTP $otp" ;

      var response = await request.send();

      if(response.statusCode == 200){
        return ApiResponseModel(200, "Success", await response.stream.bytesToString());
      } else {
        return ApiResponseModel(response.statusCode, "Error", await response.stream.bytesToString());
      }
    } on SocketException{
      Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException{
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException{
      return ApiResponseModel(408, "Request Time Out", "");
    }
  }


  ///<<<================== Api Response Status Code Handle ====================>>>

  static dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponseModel(200, 'Success', response.body);
      case 201:
        return ApiResponseModel(201, 'Success', response.body);
      case 401:
        Get.offAllNamed(AppRoutes.signInScreen);
        return ApiResponseModel(401, "Unauthorized", response.body);
      case 400:
        // Get.offAllNamed(AppRoute.logIn);
        return ApiResponseModel(400, "Error", response.body);
      case 404:
        // Get.offAllNamed(AppRoute.logIn);
        return ApiResponseModel(404, "Error", response.body);
      case 409:
        // Get.offAllNamed(AppRoute.logIn);
        return ApiResponseModel(409, "User already exists", response.body);
      default:
        print(response.statusCode);
        return ApiResponseModel(500, "Internal Server Error", response.body);
    }
  }

  static Future<ApiResponseModel> multipartRequest(
      {required String url,
      String? imagePath,
      required Map<String, String> body,
      Map<String, String>? header}) async {
    dynamic responseJson;

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);

        var img = await http.MultipartFile.fromPath('image', imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }

      request.headers['Authorization'] = "Bearer ${PrefsHelper.token}";

      var response = await request.send();

      if (response.statusCode == 200) {
        return ApiResponseModel(
            200, "Success", await response.stream.bytesToString());
      } else {
        return ApiResponseModel(response.statusCode, "Error",
            await response.stream.bytesToString());
      }
    } on SocketException {
      // Utils.toastMessage("please, check your internet connection");

      Get.toNamed(AppRoutes.noInternet);
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      // Utils.toastMessage("please, check your internet connection");
      // Get.toNamed(AppRoutes.noInternet);

      return ApiResponseModel(408, "Request Time Out", "");
    }

    return responseJson;
  }
}
