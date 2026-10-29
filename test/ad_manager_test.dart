import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_game/ad_manager.dart';

void main() {
  group('AdManager interstitial scheduling', () {
    test('shows interstitial on every 5th question', () {
      expect(AdManager.shouldShowInterstitialForQuestionIndex(4), isTrue);
      expect(AdManager.shouldShowInterstitialForQuestionIndex(9), isTrue);
      expect(AdManager.shouldShowInterstitialForQuestionIndex(0), isFalse);
      expect(AdManager.shouldShowInterstitialForQuestionIndex(3), isFalse);
    });

    test('uses test ad unit IDs in debug builds on both platforms', () {
      final testAdUnitIds = [
        AdManager.bannerAdUnitIdForPlatform(isIOS: false, isRelease: false),
        AdManager.interstitialAdUnitIdForPlatform(
            isIOS: false, isRelease: false),
        AdManager.rewardedAdUnitIdForPlatform(isIOS: false, isRelease: false),
        AdManager.appOpenAdUnitIdForPlatform(isIOS: false, isRelease: false),
        AdManager.nativeAdUnitIdForPlatform(isIOS: false, isRelease: false),
        AdManager.bannerAdUnitIdForPlatform(isIOS: true, isRelease: false),
        AdManager.interstitialAdUnitIdForPlatform(
            isIOS: true, isRelease: false),
        AdManager.rewardedAdUnitIdForPlatform(isIOS: true, isRelease: false),
        AdManager.appOpenAdUnitIdForPlatform(isIOS: true, isRelease: false),
        AdManager.nativeAdUnitIdForPlatform(isIOS: true, isRelease: false),
      ];

      expect(
        testAdUnitIds,
        everyElement(startsWith('ca-app-pub-3940256099942544/')),
      );
    });

    test('keeps test ad unit IDs for iOS release until production IDs exist',
        () {
      final iosReleaseAdUnitIds = [
        AdManager.bannerAdUnitIdForPlatform(isIOS: true, isRelease: true),
        AdManager.interstitialAdUnitIdForPlatform(isIOS: true, isRelease: true),
        AdManager.rewardedAdUnitIdForPlatform(isIOS: true, isRelease: true),
        AdManager.appOpenAdUnitIdForPlatform(isIOS: true, isRelease: true),
        AdManager.nativeAdUnitIdForPlatform(isIOS: true, isRelease: true),
      ];

      expect(
        iosReleaseAdUnitIds,
        everyElement(startsWith('ca-app-pub-3940256099942544/')),
      );
    });

    test('uses production ad unit IDs for Android release', () {
      expect(
        AdManager.bannerAdUnitIdForPlatform(isIOS: false, isRelease: true),
        startsWith('ca-app-pub-4756404048214956/'),
      );
    });
  });
}
