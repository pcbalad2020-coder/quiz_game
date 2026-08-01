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
  });
}
