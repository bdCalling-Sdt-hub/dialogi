
import 'dart:convert';

import 'package:dialogi_app/models/subcriptions_plan_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:get/get.dart';

import '../core/app_routes.dart';

class SubscriptionController extends GetxController{

  SubscriptionsPlanModel? subscriptionsPlanModel;
  bool isLoading = false;

  Future<void> subscriptionRepo() async{
    isLoading = true;
    update();

    // Get.toNamed(AppRoutes.subscriptionsScreen);

    ApiService.getApi(ApiConstant.subscriptions).then((apiResponseModel) {


      print("kjfksjdfhbsdfhdsjkfhsdkjhfdkj") ;

      print("jdfhdfhshf ${apiResponseModel.statusCode}") ;
      print("jdfhdfhshf ${apiResponseModel.message}") ;
      print("jdfhdfhshf ${apiResponseModel.responseJson}") ;

      if(apiResponseModel.statusCode == 200){

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        subscriptionsPlanModel = SubscriptionsPlanModel.fromJson(jsonData);
        print("=========>ergtgdfgvfdgf ${subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].name}<========");
      } else {
        Get.snackbar(apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }

      isLoading = false;
      update();
    });


  }
}