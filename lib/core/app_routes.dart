import 'package:dialogi_app/view/screens/auth/sign_in/forget_password/forget_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/otp/otp_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/reset_password/reset_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/sign_in/sign_in_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_password/set_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/set_photo_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/sign_up/sign_up_screen.dart';
import 'package:dialogi_app/view/screens/premium/premium_screen.dart';
import 'package:dialogi_app/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String premiumScreen="/premium_screen";
  static String signInScreen="/sign_in_screen";
  static String forgetPasswordScreen="/forget_password_screen";
  static String otpScreen="/otp_screen";
  static String resetPasswordScreen="/reset_password_screen";
  static String signUpScreen="/sign_up_screen";
  static String setPasswordScreen="/set_password_screen";
  static String setPhotoScreen="/set_photo_screen";


  static List<GetPage> routes=[
    GetPage(name: splashScreen, page: ()=> const SplashScreen()),
    GetPage(name: premiumScreen, page: ()=> const PremiumScreen()),
    GetPage(name: signInScreen, page: ()=> const SignInScreen()),
    GetPage(name: forgetPasswordScreen, page: ()=> const ForgetPasswordScreen()),
    GetPage(name: otpScreen, page: ()=> const OtpScreen()),
    GetPage(name: resetPasswordScreen, page: ()=> const ResetPasswordScreen()),
    GetPage(name: signUpScreen, page: ()=> const SignUpScreen()),
    GetPage(name: setPasswordScreen, page: ()=> const SetPasswordScreen()),
    GetPage(name: setPhotoScreen, page: ()=> const SetPhotoScreen()),
  ];
}