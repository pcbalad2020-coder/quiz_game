import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();

  static final AdManager instance = AdManager._();

  // معرفات الإعلانات التجريبية الرسمية
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  static const String interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  InterstitialAd? _interstitialAd;

  /// تحميل الإعلان البيني
  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  /// عرض الإعلان البيني
  void showInterstitial({
    required VoidCallback onDismissed,
  }) {
    if (_interstitialAd == null) {
      onDismissed();
      loadInterstitial();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitial();
        onDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitial();
        onDismissed();
      },
    );

    _interstitialAd!.show();
  }

  /// إنشاء Banner
  BannerAd createBannerAd({
    VoidCallback? onLoaded,
    Function(LoadAdError)? onFailed,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onFailed?.call(error);
        },
      ),
    );
  }
}
