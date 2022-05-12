import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ADMobService extends GetxController {
  final String AD_BANNER_ID = 'ca-app-pub-6039602622979945/8471904230';
  RxBool bannerAdIsReady = false.obs;
  late BannerAd bannerAd;

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AD_BANNER_ID,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          bannerAdIsReady.value = true;
        },
        onAdFailedToLoad: (_, __) {
          if (kDebugMode) {
            print('Banner Ad failed to load ${__.message}');
          }
          bannerAdIsReady.value = false;
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }
}
