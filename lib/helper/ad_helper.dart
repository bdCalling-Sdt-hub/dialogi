import 'dart:io';

class AdHelper {
  static String interstitialAdUnitId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      return "ca-app-pub-3940256099942544/5135589807";
    }
  }

  static String bannerAdUnitId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      return "";
    }
  }
}
