import 'package:dialogi_app/helper/ad_helper.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAdServices {
  static RxBool isBannerAdReady = false.obs;
  static late BannerAd bannerAd;

  static RxBool isInterstitialAdReady = false.obs;
  static late InterstitialAd interstitialAd;

  static void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            isInterstitialAdReady = true.obs;
            print("Interstitial Ad Ready");
          },
          onAdFailedToLoad: (error) {
            print("==========================================================> Interstitial Ad Error $error");
            interstitialAd.dispose();

            isInterstitialAdReady = false.obs;
          },
        ));
  }

  static void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady = true.obs;
          print("Banner Ad Ready");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isBannerAdReady = false.obs;
          print("Banner Ad Error");
        },
      ),
    );

    bannerAd.load();
  }
}
