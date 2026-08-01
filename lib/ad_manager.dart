import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ============================================================
// 📌 مدير الإعلانات المركزي (AdManager)
// ============================================================
class AdManager {
  AdManager._();
  static final AdManager instance = AdManager._();

  static bool shouldShowInterstitialForQuestionIndex(int questionIndex) {
    return questionIndex > 0 && (questionIndex + 1) % 5 == 0;
  }

  // معرفات الإعلانات الحقيقية (Production IDs)
  static const String _productionBannerAdUnitId =
      'ca-app-pub-4756404048214956/4530955680';
  static const String _productionInterstitialAdUnitId =
      'ca-app-pub-4756404048214956/8891324367';
  static const String _productionRewardedAdUnitId =
      'ca-app-pub-4756404048214956/1920535991';
  static const String _productionAppOpenAdUnitId =
      'ca-app-pub-4756404048214956/5631871670';
  static const String _productionNativeAdUnitId =
      'ca-app-pub-4756404048214956/3953772582';

  static const String _testBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testAppOpenAdUnitId =
      'ca-app-pub-3940256099942544/3419835294';
  static const String _testNativeAdUnitId =
      'ca-app-pub-3940256099942544/2247696110';

  static String bannerAdUnitIdForPlatform({required bool isIOS}) =>
      isIOS ? _testBannerAdUnitId : _productionBannerAdUnitId;

  static String interstitialAdUnitIdForPlatform({required bool isIOS}) =>
      isIOS ? _testInterstitialAdUnitId : _productionInterstitialAdUnitId;

  static String rewardedAdUnitIdForPlatform({required bool isIOS}) =>
      isIOS ? _testRewardedAdUnitId : _productionRewardedAdUnitId;

  static String appOpenAdUnitIdForPlatform({required bool isIOS}) =>
      isIOS ? _testAppOpenAdUnitId : _productionAppOpenAdUnitId;

  static String nativeAdUnitIdForPlatform({required bool isIOS}) =>
      isIOS ? _testNativeAdUnitId : _productionNativeAdUnitId;

  static String get bannerAdUnitId => bannerAdUnitIdForPlatform(isIOS: true);
  static String get interstitialAdUnitId =>
      interstitialAdUnitIdForPlatform(isIOS: true);
  static String get rewardedAdUnitId =>
      rewardedAdUnitIdForPlatform(isIOS: true);
  static String get appOpenAdUnitId => appOpenAdUnitIdForPlatform(isIOS: true);
  static String get nativeAdUnitId => nativeAdUnitIdForPlatform(isIOS: true);

  // ----------------------------------------------------------
  // 1️⃣ الإعلان البيني (Interstitial)
  // ----------------------------------------------------------
  InterstitialAd? _interstitialAd;

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('✅ تم تحميل الإعلان البيني');
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ فشل تحميل الإعلان البيني: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitial({required VoidCallback onDismissed}) {
    if (_interstitialAd == null) {
      loadInterstitial();
      onDismissed();
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

  // ----------------------------------------------------------
  // 2️⃣ إعلان البانر (Banner)
  // ----------------------------------------------------------
  BannerAd createBannerAd(
      {VoidCallback? onLoaded, Function(LoadAdError)? onFailed}) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('✅ تم تحميل البانر');
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('❌ فشل تحميل البانر: $error');
          ad.dispose();
          onFailed?.call(error);
        },
      ),
    )..load();
  }

  // ----------------------------------------------------------
  // 3️⃣ إعلان شاشة الفتح (App Open Ad)
  // ----------------------------------------------------------
  AppOpenAd? _appOpenAd;
  bool _isShowingAppOpenAd = false;

  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          debugPrint('✅ تم تحميل إعلان شاشة الفتح');
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ فشل تحميل إعلان شاشة الفتح: $error');
          _appOpenAd = null;
        },
      ),
    );
  }

  void showAppOpenAdIfAvailable({VoidCallback? onAdDismissed}) {
    if (_appOpenAd != null && !_isShowingAppOpenAd) {
      _isShowingAppOpenAd = true;
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _appOpenAd = null;
          _isShowingAppOpenAd = false;
          loadAppOpenAd();
          onAdDismissed?.call();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _appOpenAd = null;
          _isShowingAppOpenAd = false;
          loadAppOpenAd();
          onAdDismissed?.call();
        },
      );
      _appOpenAd!.show();
    } else {
      loadAppOpenAd();
      onAdDismissed?.call();
    }
  }

  // ----------------------------------------------------------
  // 4️⃣ الإعلان المدمج (Native Ad)
  // ----------------------------------------------------------
  NativeAd createNativeAd(
      {VoidCallback? onLoaded, Function(LoadAdError)? onFailed}) {
    return NativeAd(
      adUnitId: nativeAdUnitId,
      factoryId:
          'native_ad_factory', // يتطلب إعداد NativeAdFactory في Android/iOS للعمل بشكل مخصص
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('✅ تم تحميل الإعلان المدمج');
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('❌ فشل تحميل الإعلان المدمج: $error');
          ad.dispose();
          onFailed?.call(error);
        },
      ),
    )..load();
  }
}

// ============================================================
// 🎬 مساعد إعلان المكافأة (شاهد إعلان = احصل على عملات)
// ============================================================
class RewardedAdHelper {
  static RewardedAd? _ad;
  static bool _isLoading = false;

  static void load() {
    if (_isLoading || _ad != null) return;
    _isLoading = true;
    RewardedAd.load(
      adUnitId: AdManager.rewardedAdUnitId, // استخدام المعرف من AdManager
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (err) {
          _ad = null;
          _isLoading = false;
        },
      ),
    );
  }

  static bool get isReady => _ad != null;

  static void show({
    required VoidCallback onReward,
    VoidCallback? onDismissed,
    VoidCallback? onNotReady,
  }) {
    final ad = _ad;
    if (ad == null) {
      load();
      if (onNotReady != null) onNotReady();
      return;
    }
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _ad = null;
        load();
        if (onDismissed != null) onDismissed();
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        _ad = null;
        load();
        if (onDismissed != null) onDismissed();
      },
    );
    _ad = null; // يُستهلك فور العرض
    ad.show(onUserEarnedReward: (a, reward) => onReward());
  }
}
