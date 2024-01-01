import 'package:dialogi_app/view/screens/auth/sign_in/sign_in/sign_in_screen.dart';
import 'package:dialogi_app/view/screens/premium/premium_screen.dart';
import 'package:dialogi_app/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String premiumScreen="/premium_screen";
  static String signInScreen="/sign_in_screen";


  static List<GetPage> routes=[
    GetPage(name: splashScreen, page: ()=> const SplashScreen()),
    GetPage(name: premiumScreen, page: ()=> const PremiumScreen()),
    GetPage(name: signInScreen, page: ()=> const SignInScreen()),
  ];
}