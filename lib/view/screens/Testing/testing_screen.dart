import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAd extends StatefulWidget {
  @override
  _AdmobAdState createState() => _AdmobAdState();
}

class _AdmobAdState extends State<AdmobAd> {
  @override
  void initState() {
    super.initState();
    AdmobAdServices.loadBannerAd();
    AdmobAdServices.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Banner Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your app content goes here

            SizedBox(
              height: (Get.height * 0.4),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (AdmobAdServices.isInterstitialAdReady.value) {
                      AdmobAdServices.interstitialAd.show();

                    }
                    AdmobAdServices.loadInterstitialAd();

                  },
                  child: const Text("show Interstitial")),
            ),
            const Spacer(),
            Obx(() => AdmobAdServices.isBannerAdReady.value
                ? SizedBox(
                height: AdSize.banner.height.toDouble(),
                width: AdSize.banner.width.toDouble(),
                child: AdWidget(ad: AdmobAdServices.bannerAd))
                : const SizedBox(),)
          ],
        ),
      ),
    );
  }
}
