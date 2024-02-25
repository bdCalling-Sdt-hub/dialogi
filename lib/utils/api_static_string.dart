
class ApiStaticStrings {
  //Auth
  static const name = "Name";
  static const enterFullName = "Name is required";
  static const email = "Email";
  static const enterEmail = "Email is required";
  static const enterAddress = "Enter your address";
  static const wrongPassword = "Wrong password!!! Please enter your current password";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String enterValidEmail = "Enter valid email";
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String passwordLength =
      "Password should be atleast 8 characters";
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');
  static const String passMustContainBoth =
      "'Password must contain both alphabets and numerics'";
  static const String passDoesNotMatch = "Password does not match";
  static const signUp = "Sign Up";
  static const conTiNue= "Continue";
}