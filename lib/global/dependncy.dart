
import 'package:dialogi_app/controllers/Auth/sign_in_controller.dart';
import 'package:dialogi_app/controllers/Auth/sign_up_controller.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_controller/profile_controller.dart';
import 'package:get/get.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => Homecontroller(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => SubCategoryController(), fenix: true);
  }
}
