
import 'package:dialogi_app/controllers/Auth/password_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_up_controller.dart';
import 'package:dialogi_app/controllers/about_us_controller.dart';
import 'package:dialogi_app/controllers/question_ans_controller.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_controller/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/Auth/delete_account_controller.dart';
import '../controllers/settings_controller/settings_controller.dart';

import '../controllers/category/category_controller.dart';
import '../controllers/category/sub_category_controller.dart';
import '../controllers/discussion_details_controller.dart';
import '../controllers/subscription_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => Homecontroller(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => SubCategoryController(), fenix: true);
    Get.lazyPut(() => AboutUsController(), fenix: true);
    Get.lazyPut(() => QuestionAnsController(), fenix: true);
    Get.lazyPut(() => DiscussionDetailsController(), fenix: true);
    Get.lazyPut(() => PasswordController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => DeleteAccountController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
  }
}
