
import 'package:get/get.dart';

class ApiStaticStrings {
  //Auth
  static const name = "Name";
  static const enterFullName = "Name is required";
  static const email = "Email";
  static const enterEmail = "Email is required";
  static const enterAddress = "Enter your address";
  static const wrongPassword = "Wrong password!!! Please enter your \ncurrent password";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String enterValidEmail = "Enter valid email";
  static const String fieldCantBeEmpty = "Field can't be empty";
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');
  static const String passMustContainBoth =
      "Password must be 8 characters long & contain both \nalphabets and numerics";
  static const String passDoesNotMatch = "Password does not match";
  static const signUp = "Sign Up";
  static const conTiNue= "Continue";
}