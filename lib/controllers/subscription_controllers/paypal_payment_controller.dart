
import 'package:dialogi_app/controllers/subscription_controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';

class PaypalPaymentController extends GetxController{

  PaymentController paymentController = Get.find<PaymentController>();

  PaypalCheckout buildPaypalCheckout(BuildContext context) {
    return PaypalCheckout(
      sandboxMode: true,
      clientId: "AX7OSyIbLHC48oMBuFctYsIwoFEK9XUeuSQqgE3Tk38QDf3X0JFgMXbLvofhf1TyYNoXNO_pwe25wVY0",
      secretKey: "EMd9zW3gl-pV6Eit9b7NhkcK2c5roTQnzAeofpjpQte1Srj9SlttJvPqCsQjOlRbgt9rDgpcvcbBvTrK",
      returnURL: 'return.example.com',
      cancelURL: 'cancel.example.com',
      transactions: const [
        {
          "amount": {
            "total": '1.5',
            "currency": "USD",
            "details": {
              "subtotal": '1.5',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {
                "name": "subscription",
                "quantity": 1,
                "price": '1.5',
                "currency": "USD"
              },
            ],

            // shipping address is not required though
            //   "shipping_address": {
            //     "recipient_name": "Raman Singh",
            //     "line1": "Delhi",
            //     "line2": "",
            //     "city": "Delhi",
            //     "country_code": "IN",
            //     "postal_code": "11001",
            //     "phone": "+00000000",
            //     "state": "Texas"
            //  },
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        paymentController.paymentRepo(payerId: 'PAYID-MXOWHUY7XW63222N5003464J', amount: '1.50', currency: 'USD', subscriptionName: 'Premium', paymentMethod: 'paypal');
        print("onSuccess: $params");
      },
      onError: (error) {
        print("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('cancelled:');
      },
    );
  }
}