
import 'package:dialogi_app/controllers/Auth/password_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_out_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_up_controller.dart';
import 'package:dialogi_app/controllers/about_us_controller.dart';
import 'package:dialogi_app/controllers/chat/message_controller.dart';
import 'package:dialogi_app/controllers/friends/friend_controller.dart';
import 'package:dialogi_app/controllers/friends/pending_request_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/payment_controller.dart';
import 'package:dialogi_app/controllers/question/question_ans_controller.dart';
import 'package:dialogi_app/controllers/subscription_controllers/paypal_payment_controller.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';

import 'package:get/get.dart';


import '../controllers/Auth/delete_account_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/settings_controller/settings_controller.dart';

import '../controllers/category/category_controller.dart';
import '../controllers/category/sub_category_controller.dart';
import '../controllers/discussion_details_controller.dart';
import '../controllers/subscription_controllers/stripe_payment_controller.dart';
import '../controllers/subscription_controllers/subscription_controller.dart';

class DependencyInjection extends Bindings {

  // Initialization method
  // static Future<void> initializeApp() async {
  //   // Initialize services, configurations, etc.
  //   // For example:
  //   await configureTts();
  //   await PrefsHelper.getAllPrefData();
  //   await MobileAds.instance.initialize();
  //   NotificationService notificationService = NotificationService();
  //   notificationService.initLocalNotification();
  //   SocketServices.connectToSocket();
  //   AdmobAdServices.loadInterstitialAd();
  //   SocketServices.notifications();
  // }
  //
  // static Future<void> configureTts() async {
  //   FlutterTts flutterTts = FlutterTts();
  //   await flutterTts.setLanguage('en-US');
  //   await flutterTts.setSpeechRate(0.4);
  //   await flutterTts.setVolume(1.0);
  // }

  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => Homecontroller(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => SubCategoryController(), fenix: true);
    Get.lazyPut(() => AboutUsController(), fenix: true);
    Get.lazyPut(() => QuestionAnsController(), fenix: true);
    Get.lazyPut(() => DiscussionDetailsController(), fenix: true);
    Get.lazyPut(() => PasswordController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => DeleteAccountController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
    Get.lazyPut(() => PendingRequestController(), fenix: true);
    Get.lazyPut(() => FriendController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => StripePaymentController(), fenix: true);
    Get.lazyPut(() => PaypalPaymentController(), fenix: true);
    Get.lazyPut(() => SignOutController(), fenix: true);
  }
}
