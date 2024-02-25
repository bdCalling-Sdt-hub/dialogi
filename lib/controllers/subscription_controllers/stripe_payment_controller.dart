import 'dart:convert';

import 'package:dialogi_app/controllers/subscription_controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripePaymentController{

  PaymentController paymentController = Get.find<PaymentController>();


  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment({required String amount, required String currency}) async{
    try{
      paymentIntentData = await createPaymentIntent(amount, currency);
      if(paymentIntentData != null){
        // Access the response data as needed
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: const BillingDetails(
                  name: 'Siam Prodhan',
                  email: 'siamjht@gmail.com',
              ),
              // googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
              merchantDisplayName: 'Prospects',
              // paymentIntentClientSecret: paymentController.paymentModel!.data!.attributes!.clientSecret,
              paymentIntentClientSecret: paymentIntentData!["client_secret"],
              style: ThemeMode.light,
            )).then((value) {print('Is completed payment properly??????');});
        displayPaymentSheet();
      }
    } catch(e, s){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try{
      Map<String, dynamic> body = {
        'amount' : calculateAmount(amount),
        'currency' : currency,
        "payment_method_types[]": "card"
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          // headers: {
          //   'Authorization' : 'Bearer sk_test_51NsL1qAGQlA3WKiItI5TaZRQlYgxUxxJatB27Dqp9MeBJQo1AH7LrQ1VK2FSYLfgLPXFKOpp3no9ii8XEgSbfgPV008CBSw9Z8',
          //   'Content-Type' : 'application/x-www-form-urlencoded'
          // }
          headers: {
            'Authorization' : 'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type' : 'application/x-www-form-urlencoded'
          }
      );
      print("----------------${response.statusCode}------------------");
      print("=============>>>${response.body}<<<==============");
      return jsonDecode(response.body);
    } catch (e){
      print("Error Occurred:=========> ${e.toString()}");
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<void> displayPaymentSheet() async {
    try{
      await Stripe.instance.presentPaymentSheet();
      print('------------------Payment Successful------------------------');
    } on Exception catch(e){
      if(e is StripeException){
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch(e){
      print("exception: $e");
    }
  }
}