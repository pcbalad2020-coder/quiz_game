import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_game/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('unlocks the next level after reaching 120 points', () async {
    final gameState = GameState();
    await gameState.loadData();

    gameState.addScore(120);

    expect(gameState.unlockedLevels.contains(2), isTrue);
  });

  test('awards 2 coins for each completed question', () async {
    final gameState = GameState();
    await gameState.loadData();

    gameState.completeQuestion();

    expect(gameState.coins, 22);
  });

  test('persists progress separately for each level', () async {
    await GameStorage.saveLevelProgress(1, 5, 50);
    await GameStorage.saveLevelProgress(2, 3, 30);

    final levelOneProgress = await GameStorage.getLevelProgress(1);
    final levelTwoProgress = await GameStorage.getLevelProgress(2);

    expect(levelOneProgress?['qIdx'], 5);
    expect(levelTwoProgress?['qIdx'], 3);
  });

  test('tracks wrong answers separately from passed questions', () {
    final tracker = QuizProgressTracker();

    tracker.recordAnswer(0, false);
    expect(tracker.isWrong(0), isTrue);

    tracker.recordAnswer(0, true);
    expect(tracker.isWrong(0), isFalse);
    expect(tracker.isPassed(0), isTrue);
  });
}
