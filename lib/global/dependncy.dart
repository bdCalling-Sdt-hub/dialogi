import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/inner_widgets/photo_controller.dart';
import 'package:dialogi_app/view/screens/home/home_controller/home_controller.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_controller/profile_controller.dart';
import 'package:get/get.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => Homecontroller(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
