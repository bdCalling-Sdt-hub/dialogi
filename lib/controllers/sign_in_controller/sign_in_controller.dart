
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  bool signInLoading = false;

  TextEditingController emailController = TextEditingController(text: kDebugMode? "siamjht@gmail.com" : "");
  TextEditingController passwordController = TextEditingController(text: kDebugMode? "hello123" : "");

  var headers = {'Content-Type' : 'application/json'};

  signInUser() async{
    signInLoading = true;
    update();
  }


}