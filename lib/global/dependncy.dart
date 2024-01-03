import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/inner_widgets/photo_controller.dart';
import 'package:get/get.dart';

class DependancyInjection extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SignUpController());
  }


}