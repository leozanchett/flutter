import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hutcidade/services/database.dart';

class ADMobService extends GetxController {
  final String _AD_BANNER_ID = 'ca-app-pub-6039602622979945/8471904230';
  final String _INTERSTICIAL_ID = 'ca-app-pub-6039602622979945/6777309494';

  RxBool bannerAdIsReady = false.obs;
  RxBool interstitialAdIsReady = false.obs;
  late BannerAd bannerAd;
  late InterstitialAd _interstitialAd;

  @override
  void onInit() {
    loadBannerAd();
    loadInterstitialAd();
    super.onInit();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    _interstitialAd.dispose();
    super.onClose();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: _AD_BANNER_ID,
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

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _INTERSTICIAL_ID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: ((ad) => {
              interstitialAdIsReady.value = true,
              _interstitialAd = ad,
            }),
        onAdFailedToLoad: ((err) => {
              interstitialAdIsReady.value = false,
              if (kDebugMode)
                {
                  print('Interstitial Ad failed to load ${err.message}'),
                }
            }),
      ),
    );
  }

  void showInterstitialAd() {
    if (DatabaseService.requestCount == 3) {
      _interstitialAd.show();
      loadInterstitialAd();
      DatabaseService.requestCount = 0;
    }
  }
}
