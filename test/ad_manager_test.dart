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

    test('uses test ad unit IDs on iOS and production IDs on Android', () {
      expect(
        AdManager.bannerAdUnitIdForPlatform(isIOS: true),
        contains('ca-app-pub-3940256099942544'),
      );
      expect(
        AdManager.interstitialAdUnitIdForPlatform(isIOS: true),
        contains('ca-app-pub-3940256099942544'),
      );
      expect(
        AdManager.rewardedAdUnitIdForPlatform(isIOS: false),
        contains('ca-app-pub-4756404048214956'),
      );
    });
  });
}
