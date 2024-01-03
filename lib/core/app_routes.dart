import 'package:dialogi_app/view/screens/auth/sign_in/forget_password/forget_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/otp/otp_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/reset_password/reset_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/sign_in/sign_in_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_password/set_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/set_photo_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/sign_up/sign_up_screen.dart';
import 'package:dialogi_app/view/screens/category/category/category_screen.dart';
import 'package:dialogi_app/view/screens/friends/friends/friends_screen.dart';
import 'package:dialogi_app/view/screens/home/home/home_screen.dart';
import 'package:dialogi_app/view/screens/premium/premium_screen.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_screen.dart';
import 'package:dialogi_app/view/screens/settings/change_language/change_language_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings/settings_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_change_password/settings_change_password_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_forget_password/settings_forget_password_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_get_otp/settings_get_otp_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_reset_password/settings_reset_password_screen.dart';
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
  static String homeScreen="/home_screen";
  static String categoryScreen="/category_screen";
  static String friendsScreen="/friends_screen";
  static String profileScreen="/profile_screen";
  static String settingsScreen="/settings_screen";
  static String settingsChangePasswordScreen="/settings_change_password_screen";
  static String settingsForgetPasswordScreen="/settings_forget_password_screen";
  static String settingsGetOtp="/settings_get_otp_screen";
  static String settingsResetPasswordScreen="/settings_reset_password_screen";
  static String changeLanguageScreen="/change_language_screen";


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
    GetPage(name: homeScreen, page: ()=> const HomeScreen()),
    GetPage(name: categoryScreen, page: ()=> const CategoryScreen()),
    GetPage(name: friendsScreen, page: ()=> const FriendsScreen()),
    GetPage(name: profileScreen, page: ()=> const ProfileScreen()),
    GetPage(name: settingsScreen, page: ()=> const SettingsScreen()),
    GetPage(name: settingsChangePasswordScreen, page: ()=> const SettingsChangePasswordScreen()),
    GetPage(name: settingsForgetPasswordScreen, page: ()=> const SettingsForgetPasswordScreen()),
    GetPage(name: settingsGetOtp, page: ()=> const SettingsGetOtp()),
    GetPage(name: settingsResetPasswordScreen, page: ()=> const SettingsResetPasswordScreen()),
    GetPage(name: changeLanguageScreen, page: ()=> const ChangeLanguageScreen()),
  ];
}