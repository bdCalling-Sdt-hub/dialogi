class ApiConstant {
  ///<<<=================Base Url=========================>>>
  // static const baseUrl = "http://192.168.10.18:3000";
  static const baseUrl = "http://103.145.138.78:3000";


  static const signUp = "$baseUrl/api/users/sign-up";
  static const signIn = "$baseUrl/api/users/sign-in";
  static const googleSignIn = "$baseUrl/api/users/sign-in-with-provider";
  static const forgetPassword = "$baseUrl/api/users/forget-password";
  static const verifyOtp = "$baseUrl/api/users/verify-otp";
  static const resetPassword = "$baseUrl/api/users/reset-password";
  static const signInWithRefreshToken = "$baseUrl/api/users/sign-in-with-refresh-token";
  static const notifications = "$baseUrl/api/notifications";
  static const users = "$baseUrl/api/users";
  static const categories = "$baseUrl/api/categories";
  static const reply = "$baseUrl/api/discussions/reply";
  static const questions = "$baseUrl/api/questions";
  static const subCategory = "$baseUrl/api/questions/sub-category";
  static const discussions = "$baseUrl/api/discussions";
  static const discussionsSpecific = "$baseUrl/api/discussions/specific";
  static const subscriptions = "$baseUrl/api/subscriptions";
  static const payments = "$baseUrl/api/payments";
  static const friends = "$baseUrl/api/friends";
  static const getGroupFriends = "$baseUrl/api/friends/group";
  static const premiumPlus = "$baseUrl/api/users/premium-plus";
  static const privacyPolicy = "$baseUrl/api/privacy-policies";
  static const aboutUs = "$baseUrl/api/about-us";
  static const supports = "$baseUrl/api/supports";
  static const faqs = "$baseUrl/api/faqs";
  static const changePassword = "$baseUrl/api/users/change-password";
  static const friendProfile = "$baseUrl/api/users/profile-details";
  static const chats = "$baseUrl/api/chats";
  static const messages = "$baseUrl/api/messages";
  static const favourite = "$baseUrl/api/favourites";
  static const sameCommunity = "$baseUrl/api/chats/by-category";
  static const communityChat = "$baseUrl/api/chats/community-chat";
  static const leave = "$baseUrl/api/chats/leave-group";
  static const joinCommunity = "$baseUrl/api/chats/join-community";
}