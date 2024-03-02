
import 'dart:convert';

import 'package:dialogi_app/models/subcriptions_plan_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:get/get.dart';

import '../../global/api_response_model.dart';


class SubscriptionController extends GetxController{

  Status status = Status.completed;
  SubscriptionsPlanModel? subscriptionsPlanModel;


  Future<void> subscriptionRepo() async{
    status = Status.loading;
    update();

    // Get.toNamed(AppRoutes.subscriptionsScreen);

    ApiService.getApi(ApiConstant.subscriptions).then((apiResponseModel) {


      print("${apiResponseModel.statusCode}") ;
      print("${apiResponseModel.message}") ;
      print("${apiResponseModel.responseJson}") ;

      if(apiResponseModel.statusCode == 200){

        var jsonData = jsonDecode(apiResponseModel.responseJson);
        subscriptionsPlanModel = SubscriptionsPlanModel.fromJson(jsonData);

        print("=========> ${subscriptionsPlanModel!.data!.attributes!.subscriptionsList![0].name}<========");
        status = Status.completed;
        update();

      } else {
        Get.snackbar(apiResponseModel.statusCode.toString(), apiResponseModel.message);
        status = Status.error;
        update();
      }

    });

  }
}