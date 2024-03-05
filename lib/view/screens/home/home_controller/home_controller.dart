import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/global/api_response_model.dart';
import 'package:dialogi_app/models/access_status_model.dart';
import 'package:dialogi_app/models/home_categories_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/utils/static_strings.dart';
import 'package:dialogi_app/view/widgets/buttons/custom_elevated_button.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../helper/prefs_helper.dart';
import '../../../../services/socket_service.dart';
import '../../../../utils/app_constants.dart';

class Homecontroller extends GetxController with GetxServiceMixin {
  static Status status = Status.loading;
  Status homeStatus = Status.loading;

  static AccessStatusModel? accessStatusModel;
  HomeCategoriesModel? homeCategoriesModel;
  final ScrollController categoryScrollController = ScrollController();
  final ScrollController earlyAccessScrollController = ScrollController();
  int pageErCount = 1;
  int pageCount = 1;
  int limitCount = 10;


  ///<<<==================== Page Scroll Method ==================================>>>
  Future<void> scrollControllerCall() async {
    if(categoryScrollController.position.pixels == categoryScrollController.position.maxScrollExtent){
      await categoryAccessRepo();
    }
    if(earlyAccessScrollController.position.pixels == earlyAccessScrollController.position.maxScrollExtent){
      await categoryAccessRepo();
    }
  }


  ///<<<=================== Category Access Repo ==============================>>>

  Future<void> categoryAccessRepo() async{

    homeStatus = Status.loading;
    update();
    
    try{
      var response = await ApiService.getApi("${ApiConstant.categoryType}?pageEr=$pageErCount&limitEr=$limitCount&page=$pageCount&limit=$limitCount").timeout(const Duration(seconds: 30));
      print("Response json : ${response.responseJson}");
      if (response.statusCode == 200){
        homeCategoriesModel = HomeCategoriesModel.fromJson(jsonDecode(response.responseJson));
        print("${response.message}");

        homeStatus = Status.completed;
        update();
        pageCount++;
        pageErCount++;
      } else{
        homeStatus = Status.error;
      }
    } catch (exception){
      Fluttertoast.showToast(msg: AppConstants.connectionTimedOUt);
      log(exception.toString());
    }
  }


  static getAccessStatus({bool isPopUp = false}) async {
    status = Status.loading;

    var body = {"userId": PrefsHelper.clientId};

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("dialogi-access-status", body,
        ack: (data) {
      var check = data['status'];

      if (check == "Error") {
        status = Status.error;
      } else {
        accessStatusModel = AccessStatusModel.fromJson(data);
        status = Status.completed;
      }

      print(
          "===============================================================> Received acknowledgment: $data");
    });
  }

  void showPopUpPremiumPackage() {
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          child: Container(
            height: 300.h,
            width: 300.w,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.r),
                  //     child: CustomImage(imageSrc: AppIcons.cancel),
                  //   ),
                  // ),
                  CustomImage(
                    imageSrc: AppIcons.crown,
                    size: 60.r,
                  ),

                  const CustomText(
                    maxLines: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    text: AppStrings.upgradetoPremiumfor,
                  ),

                  CustomElevatedButton(
                      buttonHeight: 40,
                      titleSize: 14,
                      onPressed: () {
                        Get.toNamed(AppRoutes.premiumScreen);
                      },
                      titleText: AppStrings.gotoSubscriptions),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void onReady() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (status == Status.completed) {
          if (accessStatusModel!.data!.type == "default") {
            showPopUpPremiumPackage();
          }
        }
      },
    );

    super.onReady();
  }
}






void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScrollableScreen(),
    );
  }
}

class MyScrollableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Screen with Pagination'),
      ),
      body: MyApiDataList(),
    );
  }
}

class MyApiDataList extends StatelessWidget {
  final MyApiController controller = Get.put(MyApiController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyApiController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.apiData.length + 1, // +1 for loading indicator at the end
          itemBuilder: (context, index) {
            if (index < controller.apiData.length) {
              return ListTile(
                title: Text(controller.apiData[index]),
                // Add more widgets or customize based on your API data
              );
            } else {
              // Loading indicator
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: controller.isLoading
                      ? CircularProgressIndicator()
                      : SizedBox.shrink(),
                ),
              );
            }
          },
          controller: ScrollController()..addListener(() => _scrollListener(controller)),
        );
      },
    );
  }

  void _scrollListener(MyApiController controller) {
    if (controller.isLoading) return;

    if (controller.apiData.isNotEmpty &&
        controller.apiData.length % 10 == 0 && // Adjust based on your desired condition
        controller.apiData.length == controller.currentPage * 10) {
      controller.fetchData();
    }
  }
}

class MyApiController extends GetxController {
  List<String> apiData = [];
  int currentPage = 1;
  bool isLoading = false;

  Future<void> fetchData() async {
    try {
      isLoading = true;
      update();

      List<String> newData = await fetchApiData(currentPage);

      apiData.addAll(newData);
      currentPage++;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<List<String>> fetchApiData(int page) async {
    final String apiUrl = 'YOUR_API_ENDPOINT_HERE?page=$page&limit=10'; // Replace with your actual API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Assuming your API returns a list of strings
        List<String> data = List<String>.from(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}