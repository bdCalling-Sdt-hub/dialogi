
import 'dart:convert';

import 'package:dialogi_app/controllers/subscription_controllers/stripe_payment_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/subscription_controller.dart';
import 'package:dialogi_app/core/app_routes.dart';
import 'package:dialogi_app/models/payment_model.dart';
import 'package:dialogi_app/services/api_services.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../helper/prefs_helper.dart';

class PaymentController extends GetxController{
  SubscriptionController subscriptionController = Get.find<SubscriptionController>();

  PaymentModel? paymentModel;
  bool isLoading = false;

Future<void> paymentRepo({required String payerId,required String amount, required String currency, required String subscriptionName, required String paymentMethod}) async{
  isLoading = true;
  update();
  var body = {};


  // Map<String, dynamic> body = {
  //   "paymentData" : {
  //     "paymentId": StripePaymentController.payerId,
  //     "payment_method": "stripe",
  //     "amount": amount,
  //     "item": {
  //       "name": subscriptionName,
  //       "sku": "subscription",
  //       "price": amount,
  //       "currency": currency,
  //       "quantity": 1
  //     }
  //   },
  //
  //   "subscriptionId" : subscriptionName == "Premium" ? "65cde4e7294393c969cff435" : "65cde4e7294393c969cff436",
  // };
  if(paymentMethod == 'stripe'){
     body = {
      "amount" : amount,
      "paymentId" : StripePaymentController.payerId,
      "paymentMethod" : paymentMethod,
      "name" : subscriptionName,
      "sku" : "subscription",
      "price": amount,
      "currency": currency,
      "quantity": 1.toString(),
      "subscriptionId" : subscriptionName == "Premium" ? "65cde4e7294393c969cff435" : "65cde4e7294393c969cff436",
    };
  } else{
    body = {
      "amount" : amount,
      "paymentId" : payerId,
      "paymentMethod" : paymentMethod,
      "name" : subscriptionName,
      "sku" : "subscription",
      "price": amount,
      "currency": currency,
      "quantity": 1.toString(),
      "subscriptionId" : subscriptionName == "Premium" ? "65cde4e7294393c969cff435" : "65cde4e7294393c969cff436",
    };
  }

  print("Stripe Body Data: $body");


   Map<String, String> mainHeader = {
    'Authorization': "Bearer ${PrefsHelper.token}"
  };

  ApiService.postApi(ApiConstant.payments, body, header: mainHeader).then((apiResponseModel){

    print("============${apiResponseModel.message}, ${apiResponseModel.statusCode}============");

    if(apiResponseModel.statusCode == 200){

      var jsonData = jsonDecode(apiResponseModel.responseJson);
      paymentModel = PaymentModel.fromJson(jsonData);
      var token = paymentModel!.data!.accessToken;
      PrefsHelper.setString(AppConstants.bearerToken, token);
      print("Token: -----$token");
      Get.offAndToNamed(AppRoutes.homeScreen);
      Get.snackbar(AppConstants.paymentStatus, AppConstants.paymentSuccessful);

    } else {
      Get.snackbar(apiResponseModel.statusCode.toString(), apiResponseModel.message);
    }

    isLoading = false;
    update();
  });
}

}