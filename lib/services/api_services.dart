import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../global/api_response_model.dart';
import '../core/app_routes.dart';
import '../helper/prefs_helper.dart';
import '../utils/app_utils.dart';

class ApiService {
  ///<<<======================== Main Header ==============================>>>
  static Map<String, String> mainHeader = {
    'Authorization': "Bearer ${PrefsHelper.token}"
  };

  static const int timeOut = 30;

  ///<<<======================== Post Api ==============================>>>

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

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
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
//
// import '../helper/prefs_helper.dart';
// import '../models/error_response.dart';
// import '../utils/app_constants.dart';
// import '../utils/snack_bar.dart';
// import 'api_url.dart';
//
//
// class ApiClient extends GetxService {
//   static var client = http.Client();
//   static int statusCode = 1;
//
//   static const String noInternetMessage = "Can't connect to the internet!";
//   static const int timeoutInSeconds = 30;
//
//   static String bearerToken = "";
//
//   static Future<Response> getData(String uri,
//       {Map<String, dynamic>? query, Map<String, String>? headers}) async {
//     bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//     var mainHeaders = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Authorization': 'Bearer $bearerToken'
//     };
//     try {
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//
//       http.Response response = await client
//           .get(
//         Uri.parse(ApiConstant.baseUrl + uri),
//         headers: headers ?? mainHeaders,
//       )
//           .timeout(const Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       debugPrint('------------${e.toString()}');
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   static Future<Response> postData(String uri, dynamic body,
//       {Map<String, String>? headers}) async {
//     bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//     var mainHeaders = {
//       // 'Content-Type': 'application/x-www-form-urlencoded',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $bearerToken'
//     };
//     try {
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//       debugPrint('====> API Body: $body');
//       http.Response response = await client
//           .post(
//           Uri.parse(ApiConstant.baseUrl + uri),
//           body: body,
//           headers: headers
//       )
//           .timeout(const Duration(seconds: timeoutInSeconds));
//       statusCode = response.statusCode;
//       print('-----------------------$statusCode-=----------------');
//       return handleResponse(response, uri);
//     } catch (e) {
//       Get.snackbar(
//           backgroundColor: Colors.red.shade300,
//           "Status Code: $statusCode", "Error Message: $e");
//       return const Response();
//       // return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   static Future<Response> postMultipartData(
//       String uri, Map<String, String> body,
//       {List<MultipartBody>? multipartBody,
//         List<MultipartListBody>? multipartListBody,
//         Map<String, String>? headers}) async {
//     try {
//       bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//       var mainHeaders = {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization': 'Bearer $bearerToken'
//       };
//
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//       debugPrint('====> API Body: $body with ${multipartBody?.length} picture');
//
//       //http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse("https://b936-114-130-157-130.ngrok-free.app/api/v1/user/profile/store/degree"));
//       //_request.headers.addAll(headers ?? mainHeaders);
//       // for(MultipartBody multipart in multipartBody!) {
//       //   if(multipart.file != null) {
//       //     Uint8List _list = await multipart.file.readAsBytes();
//       //     _request.files.add(http.MultipartFile(
//       //       multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
//       //       filename: '${DateTime.now().toString()}.png',
//       //     ));
//       //   }
//       // }
//
//       var request =
//       http.MultipartRequest('POST', Uri.parse(ApiConstant.baseUrl + uri));
//       request.fields.addAll(body);
//
//       if (multipartBody!.isNotEmpty) {
//         // ignore: avoid_function_literals_in_foreach_calls
//         multipartBody.forEach((element) async {
//           debugPrint("path : ${element.file.path}");
//
//           if (element.file.path.contains(".mp4")) {
//             debugPrint("media type mp4 ==== ${element.file.path}");
//             request.files.add(http.MultipartFile(
//               element.key,
//               element.file.readAsBytes().asStream(),
//               element.file.lengthSync(),
//               filename: 'video.mp4',
//               contentType: MediaType('video', 'mp4'),
//             ));
//           } else if (element.file.path.contains(".png")) {
//             debugPrint("media type png ==== ${element.file.path}");
//             request.files.add(http.MultipartFile(
//               element.key,
//               element.file.readAsBytes().asStream(),
//               element.file.lengthSync(),
//               filename: 'image.png',
//               contentType: MediaType('image', 'png'),
//             ));
//           }
//
//           //request.files.add(await http.MultipartFile.fromPath(element.key, element.file.path,contentType: MediaType('video', 'mp4')));
//         });
//       }
//
//       request.headers.addAll(mainHeaders);
//       http.StreamedResponse response = await request.send();
//       final content = await response.stream.bytesToString();
//       debugPrint(
//           '====> API Response: [${response.statusCode}}] $uri\n$content');
//
//       return Response(
//           statusCode: response.statusCode,
//           statusText: noInternetMessage,
//           body: content);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Future<Response> putData(String uri, dynamic body,
//       {Map<String, String>? headers}) async {
//     bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//     var mainHeaders = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Authorization': 'Bearer $bearerToken'
//     };
//     try {
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//       debugPrint('====> API Body: $body');
//
//       http.Response response = await http
//           .put(
//         Uri.parse(ApiConstant.baseUrl + uri),
//         body: jsonEncode(body),
//         headers: headers ?? mainHeaders,
//       )
//           .timeout(const Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   static Future<Response> putMultipartData(String uri, Map<String, String> body,
//       {List<MultipartBody>? multipartBody,
//         List<MultipartListBody>? multipartListBody,
//         Map<String, String>? headers}) async {
//     try {
//       bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//       var mainHeaders = {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization': 'Bearer $bearerToken'
//       };
//
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//       debugPrint('====> API Body: $body with ${multipartBody?.length} picture');
//
//       //http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse("https://b936-114-130-157-130.ngrok-free.app/api/v1/user/profile/store/degree"));
//       //_request.headers.addAll(headers ?? mainHeaders);
//       // for(MultipartBody multipart in multipartBody!) {
//       //   if(multipart.file != null) {
//       //     Uint8List _list = await multipart.file.readAsBytes();
//       //     _request.files.add(http.MultipartFile(
//       //       multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
//       //       filename: '${DateTime.now().toString()}.png',
//       //     ));
//       //   }
//       // }
//
//       var request =
//       http.MultipartRequest('PUT', Uri.parse(ApiConstant.baseUrl + uri));
//       request.fields.addAll(body);
//
//       if (multipartBody!.isNotEmpty) {
//         // ignore: avoid_function_literals_in_foreach_calls
//         multipartBody.forEach((element) async {
//           debugPrint("path : ${element.file.path}");
//
//           if (element.file.path.contains(".mp4")) {
//             debugPrint("media type mp4 ==== ${element.file.path}");
//             request.files.add(http.MultipartFile(
//               element.key,
//               element.file.readAsBytes().asStream(),
//               element.file.lengthSync(),
//               filename: 'video.mp4',
//               contentType: MediaType('video', 'mp4'),
//             ));
//           } else if (element.file.path.contains(".png")) {
//             debugPrint("media type png ==== ${element.file.path}");
//             request.files.add(http.MultipartFile(
//               element.key,
//               element.file.readAsBytes().asStream(),
//               element.file.lengthSync(),
//               filename: 'image.png',
//               contentType: MediaType('image', 'png'),
//             ));
//           }
//
//           //request.files.add(await http.MultipartFile.fromPath(element.key, element.file.path,contentType: MediaType('video', 'mp4')));
//         });
//       }
//
//       request.headers.addAll(mainHeaders);
//       http.StreamedResponse response = await request.send();
//       final content = await response.stream.bytesToString();
//       debugPrint(
//           '====> API Response: [${response.statusCode}}] $uri\n$content');
//
//       return Response(
//           statusCode: response.statusCode,
//           statusText: noInternetMessage,
//           body: content);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   static Future<Response> deleteData(String uri,
//       {Map<String, String>? headers, dynamic body}) async {
//     bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
//
//     var mainHeaders = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Authorization': 'Bearer $bearerToken'
//     };
//     try {
//       debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
//       debugPrint('====> API Call: $uri\n Body: $body');
//
//       http.Response response = await http
//           .delete(Uri.parse(ApiConstant.baseUrl + uri),
//           headers: headers ?? mainHeaders, body: body)
//           .timeout(const Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   static Response handleResponse(http.Response response, String uri) {
//     dynamic body;
//     try {
//       body = jsonDecode(response.body);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     Response response0 = Response(
//       body: body ?? response.body,
//       bodyString: response.body.toString(),
//       request: Request(
//           headers: response.request!.headers,
//           method: response.request!.method,
//           url: response.request!.url),
//       headers: response.headers,
//       statusCode: response.statusCode,
//       statusText: response.reasonPhrase,
//     );
//
//     if (response0.statusCode != 200 &&
//         response0.body != null &&
//         response0.body is! String) {
//       ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
//       response0 = Response(
//           statusCode: response0.statusCode,
//           body: response0.body,
//           statusText: errorResponse.message);
//
//       // if(_response.body.toString().startsWith('{errors: [{code:')) {
//       //   ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
//       //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
//       // }else if(_response.body.toString().startsWith('{message')) {
//       //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
//       // }
//       // response0 = Response(
//       //   statusCode: response0.statusCode,
//       //   body: response0.body,
//       // );
//     } else if (response0.statusCode != 200 && response0.body == null) {
//       response0 = const Response(statusCode: 0, statusText: noInternetMessage);
//     }
//
//     debugPrint(
//         '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
//     // log.e("Handle Response error} ");
//     return response0;
//   }
// }
//
// class MultipartBody {
//   String key;
//   File file;
//
//   MultipartBody(this.key, this.file);
// }
//
// class MultipartListBody {
//   String key;
//   String value;
//   MultipartListBody(this.key, this.value);
// }
