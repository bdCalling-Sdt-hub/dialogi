import 'package:dialogi_app/view/screens/auth/sign_in/forget_password/forget_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/otp/otp_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/reset_password/reset_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_in/sign_in/sign_in_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/otp/signup_otp_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_password/set_password_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/set_photo/set_photo_screen.dart';
import 'package:dialogi_app/view/screens/auth/sign_up/sign_up/sign_up_screen.dart';
import 'package:dialogi_app/view/screens/category/category_screen.dart';
import 'package:dialogi_app/view/screens/category_details/category_details.dart';
import 'package:dialogi_app/view/screens/chat/%20chat_premium/chat_premium_screen.dart';
import 'package:dialogi_app/view/screens/chat/chat/chat_screen.dart';
import 'package:dialogi_app/view/screens/chat/chat_list/chat_list_screen.dart';
import 'package:dialogi_app/view/screens/friends/friends/friends_screen.dart';
import 'package:dialogi_app/view/screens/friends/friends_profile/friends_profile_screen.dart';
import 'package:dialogi_app/view/screens/group_chat/group_chat/group_chat.dart';
import 'package:dialogi_app/view/screens/group_chat/group_members/group_members.dart';
import 'package:dialogi_app/view/screens/group_chat/select_friends/select_friends.dart';
import 'package:dialogi_app/view/screens/home/screen/home_screen.dart';
import 'package:dialogi_app/view/screens/no_internet/no_internet_screen.dart';
import 'package:dialogi_app/view/screens/notification/notification_screen.dart';
import 'package:dialogi_app/view/screens/pending_requests/pending_requests_screen.dart';
import 'package:dialogi_app/view/screens/premium/premium_screen.dart';
import 'package:dialogi_app/view/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:dialogi_app/view/screens/profile/profile/profile_screen.dart';
import 'package:dialogi_app/view/screens/purchase/purchase_screen.dart';
import 'package:dialogi_app/view/screens/question_ans/question_ans.dart';
import 'package:dialogi_app/view/screens/settings/about_us/about_us_screen.dart';
import 'package:dialogi_app/view/screens/settings/change_language/change_language_screen.dart';
import 'package:dialogi_app/view/screens/settings/faq/faq_screen.dart';
import 'package:dialogi_app/view/screens/settings/privacy_policy/privacy_policy_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings/settings_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_change_password/settings_change_password_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_forget_password/settings_forget_password_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_get_otp/settings_get_otp_screen.dart';
import 'package:dialogi_app/view/screens/settings/settings_reset_password/settings_reset_password_screen.dart';
import 'package:dialogi_app/view/screens/settings/subscriptions/subscriptions_screen.dart';
import 'package:dialogi_app/view/screens/settings/support/support_screen.dart';
import 'package:dialogi_app/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../view/screens/discussion_details/discussion_details_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String premiumScreen = "/premium_screen";
  static String signInScreen = "/sign_in_screen";
  static String forgetPasswordScreen = "/forget_password_screen";
  static String otpScreen = "/otp_screen";
  static String signupOtpScreen = "/signup_otp_screen";
  static String resetPasswordScreen = "/reset_password_screen";
  static String signUpScreen = "/sign_up_screen";
  static String setPasswordScreen = "/set_password_screen";
  static String setPhotoScreen = "/set_photo_screen";
  static String homeScreen = "/home_screen";
  static String categoryScreen = "/category_screen";
  static String friendsScreen = "/friends_screen";
  static String profileScreen = "/profile_screen";
  static String settingsScreen = "/settings_screen";
  static String settingsChangePasswordScreen =
      "/settings_change_password_screen";
  static String settingsForgetPasswordScreen =
      "/settings_forget_password_screen";
  static String settingsGetOtp = "/settings_get_otp_screen";
  static String settingsResetPasswordScreen = "/settings_reset_password_screen";
  static String changeLanguageScreen = "/change_language_screen";
  static String supportScreen = "/support_screen";
  static String aboutUsScreen = "/about_us_screen";
  static String privacyPolicyScreen = "/privacy_policy_screen";
  static String faqScreen = "/faq_screen";
  static String subscriptionsScreen = "/subscriptions";
  static String categoryDetails = "/category_details";
  static String questionAns = "/question_ans";
  static String editProfileScreen = "/edit_profile_screen";
  static String friendsProfileScreen = "/friends_profile_screen";
  static String chatPremiumScreen = "/chat_premium_screen";
  static String chatListScreen = "/chat_list_screen";
  static String chatScreen = "/chat_screen";
  static String notificationScreen = "/notification_screen";
  static String pendingRequestsScreen = "/pending_requests_screen";
  static String purchaseScreen = "/purchase_screen";
  static String selectFriends = "/select_friends";
  static String groupChat = "/group_chat";
  static String groupMembers = "/group_members";
  static String discussionDetails = "/discussion_details_screen.dart";
  static String noInternet = "/no_internet_screen.dart";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: premiumScreen, page: () => const PremiumScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(
        name: forgetPasswordScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: signupOtpScreen, page: () => SignUpOtpScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: setPasswordScreen, page: () => SetPasswordScreen()),
    GetPage(name: setPhotoScreen, page: () => const SetPhotoScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: categoryScreen, page: () => CategoryScreen()),
    GetPage(name: friendsScreen, page: () => const FriendsScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: settingsScreen, page: () => SettingsScreen()),
    GetPage(
        name: settingsChangePasswordScreen,
        page: () => SettingsChangePasswordScreen()),
    GetPage(
        name: settingsForgetPasswordScreen,
        page: () => const SettingsForgetPasswordScreen()),
    GetPage(name: settingsGetOtp, page: () => SettingsGetOtp()),
    GetPage(
        name: settingsResetPasswordScreen,
        page: () => SettingsResetPasswordScreen()),
    GetPage(
        name: changeLanguageScreen, page: () => const ChangeLanguageScreen()),
    GetPage(name: categoryDetails, page: () => const CategoryDetails()),
    GetPage(name: questionAns, page: () => const QuestionAns()),
    GetPage(name: supportScreen, page: () => SupportScreen()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: subscriptionsScreen, page: () => const SubscriptionsScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(
        name: friendsProfileScreen, page: () => const FriendsProfileScreen()),
    GetPage(name: chatPremiumScreen, page: () => const ChatPremiumScreen()),
    GetPage(name: chatListScreen, page: () => const ChatListScreen()),
    GetPage(name: chatScreen, page: () => const ChatScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(
        name: pendingRequestsScreen, page: () => const PendingRequestsScreen()),
    GetPage(name: purchaseScreen, page: () => const PurchaseScreen()),
    GetPage(name: selectFriends, page: () => const SelectFriendsGroupChat()),
    GetPage(name: groupChat, page: () => const GroupChat()),
    GetPage(name: groupMembers, page: () => const GroupMembers()),
    GetPage(name: discussionDetails, page: () => const DiscussionDetailsScreen()),
    GetPage(name: noInternet, page: () => const NoInternet()),
  ];
}
