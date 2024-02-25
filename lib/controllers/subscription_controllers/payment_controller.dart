
import 'dart:convert';

import 'package:dialogi_app/controllers/subscription_controllers/subscription_controller.dart';
import 'package:dialogi_app/models/payment_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';

class PaymentController extends GetxController{
  SubscriptionController subscriptionController = Get.find<SubscriptionController>();

  PaymentModel? paymentModel;
  bool isLoading = false;

Future<void> makePaymentRepo() async{
  isLoading = true;
  update();

  print(subscriptionController.subscriptionsPlanModel?.data?.attributes?.subscriptionsList?[0].sId );

  Map<String, String> body = {
    "subscriptionId" : subscriptionController.subscriptionsPlanModel?.data?.attributes?.subscriptionsList?[0].sId ?? ""
  };


   Map<String, String> mainHeader = {
    'Authorization': "Bearer ${PrefsHelper.token}"
  };

  ApiService.postApi(ApiConstant.payment, body, header: mainHeader).then((apiResponseModel){

    print("============${apiResponseModel.message} ${apiResponseModel.statusCode}============");

    if(apiResponseModel.statusCode == 200){

      var jsonData = jsonDecode(apiResponseModel.responseJson);
      paymentModel = PaymentModel.fromJson(jsonData);

      print("=========> ${paymentModel!.data!.attributes!}<========");

    } else {
      Get.snackbar(apiResponseModel.statusCode.toString(), apiResponseModel.message);
    }

    isLoading = false;
    update();
  });
}

}