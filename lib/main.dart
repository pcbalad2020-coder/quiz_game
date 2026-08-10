import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// استيراد ملفاتك الأخرى
import 'quiz_data.dart';
import 'ad_manager.dart'; // ✅ استيراد ملف الإعلانات المنفصل

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [Locale('ar'), Locale('en')];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return localizations ?? AppLocalizations(const Locale('ar'));
  }

  String get languageCode => locale.languageCode;

  static String tr(BuildContext context,
      {required String ar, required String en}) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? ar : en;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// ============================================================
// 🚀 نقطة الدخول الرئيسية
// ============================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await AdConsentManager.instance.requestConsentAndInitialize();
  runApp(const QuizApp());
}

// ============================================================
// 🎨 ألوان التطبيق المركزية
// ============================================================
class AppColors {
  static const Color primaryDark = Color(0xFF6C63FF);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color backgroundDark = Color(0xFF0D0D1A);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF16213E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecDark = Color(0xFFB0B0D0);

  static const Color primaryLight = Color(0xFF5B52D9);
  static const Color backgroundLight = Color(0xFFF5F5FF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFEEEEFF);
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecLight = Color(0xFF5A5A7A);

  static const Color correctColor = Color(0xFF4CAF50);
  static const Color wrongColor = Color(0xFFE53935);
  static const Color goldColor = Color(0xFFFFD700);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9C27B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFF8F00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ============================================================
// 💾 طبقة التخزين المحلي (SharedPreferences)
// ============================================================
class GameStorage {
  static const String _kScore = 'total_score';
  static const String _kLevel = 'current_level';
  static const String _kUnlocked = 'unlocked_levels';
  static const String _kDarkMode = 'is_dark_mode';
  static const String _kCompletedLvl = 'completed_levels';
  static const String _kProgLevel = 'inprogress_level';
  static const String _kProgQIdx = 'inprogress_qidx';
  static const String _kProgScore = 'inprogress_score';
  static const String _kLevelAnsweredMap = 'level_answered_map';
  static const String _kCoins = 'coins';

  static Future<void> saveCoins(int v) async =>
      (await SharedPreferences.getInstance()).setInt(_kCoins, v);
  static Future<int> getCoins() async =>
      (await SharedPreferences.getInstance()).getInt(_kCoins) ?? 20;
  static Future<void> saveScore(int v) async =>
      (await SharedPreferences.getInstance()).setInt(_kScore, v);
  static Future<int> getScore() async =>
      (await SharedPreferences.getInstance()).getInt(_kScore) ?? 0;
  static Future<void> saveCurrentLevel(int v) async =>
      (await SharedPreferences.getInstance()).setInt(_kLevel, v);
  static Future<int> getCurrentLevel() async =>
      (await SharedPreferences.getInstance()).getInt(_kLevel) ?? 1;
  static Future<void> saveDarkMode(bool v) async =>
      (await SharedPreferences.getInstance()).setBool(_kDarkMode, v);
  static Future<bool> getDarkMode() async =>
      (await SharedPreferences.getInstance()).getBool(_kDarkMode) ?? true;

  static const String _kLanguage = 'language_code';
  static Future<void> saveLanguageCode(String code) async =>
      (await SharedPreferences.getInstance()).setString(_kLanguage, code);
  static Future<String> getLanguageCode() async =>
      (await SharedPreferences.getInstance()).getString(_kLanguage) ?? 'ar';

  static Future<void> saveUnlockedLevels(List<int> levels) async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_kUnlocked, levels.map((e) => '$e').toList());
  }

  static Future<List<int>> getUnlockedLevels() async {
    final p = await SharedPreferences.getInstance();
    return (p.getStringList(_kUnlocked) ?? ['1']).map(int.parse).toList();
  }

  static Future<void> saveCompletedLevels(List<int> levels) async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_kCompletedLvl, levels.map((e) => '$e').toList());
  }

  static Future<List<int>> getCompletedLevels() async {
    final p = await SharedPreferences.getInstance();
    return (p.getStringList(_kCompletedLvl) ?? []).map(int.parse).toList();
  }

  static Future<void> saveLevelProgress(
      int levelId, int qIdx, int levelScore) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('$_kProgLevel:$levelId', levelId);
    await p.setInt('$_kProgQIdx:$levelId', qIdx);
    await p.setInt('$_kProgScore:$levelId', levelScore);
  }

  static Future<Map<String, int>?> getLevelProgress(int levelId) async {
    final p = await SharedPreferences.getInstance();
    final hasProgress = p.containsKey('$_kProgLevel:$levelId');
    if (!hasProgress) return null;
    return {
      'levelId': p.getInt('$_kProgLevel:$levelId') ?? -1,
      'qIdx': p.getInt('$_kProgQIdx:$levelId') ?? 0,
      'levelScore': p.getInt('$_kProgScore:$levelId') ?? 0,
    };
  }

  static Future<void> clearLevelProgress(int levelId) async {
    final p = await SharedPreferences.getInstance();
    await p.remove('$_kProgLevel:$levelId');
    await p.remove('$_kProgQIdx:$levelId');
    await p.remove('$_kProgScore:$levelId');
  }

  static Future<void> saveLevelAnsweredCount(int levelId, int count) async {
    final p = await SharedPreferences.getInstance();
    final map = await getLevelAnsweredMap();
    final current = map[levelId] ?? 0;
    if (count > current) {
      map[levelId] = count;
      final encoded = map.entries.map((e) => '${e.key}:${e.value}').toList();
      await p.setStringList(_kLevelAnsweredMap, encoded);
    }
  }

  static Future<Map<int, int>> getLevelAnsweredMap() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getStringList(_kLevelAnsweredMap) ?? [];
    final map = <int, int>{};
    for (final e in raw) {
      final parts = e.split(':');
      if (parts.length == 2) {
        final id = int.tryParse(parts[0]);
        final cnt = int.tryParse(parts[1]);
        if (id != null && cnt != null) map[id] = cnt;
      }
    }
    return map;
  }

  static Future<void> resetGame() async {
    final p = await SharedPreferences.getInstance();
    await Future.wait([
      p.remove(_kScore),
      p.remove(_kLevel),
      p.remove(_kUnlocked),
      p.remove(_kCompletedLvl),
      p.remove(_kProgLevel),
      p.remove(_kProgQIdx),
      p.remove(_kProgScore),
      p.remove(_kLevelAnsweredMap),
      p.remove(_kCoins),
    ]);
  }
}

// ============================================================
// 🎮 حالة اللعبة العامة (ChangeNotifier)
// ============================================================
class GameState extends ChangeNotifier {
  int _totalScore = 0;
  int _currentLevel = 1;
  List<int> _unlockedLevels = [1];
  List<int> _completedLevels = [];
  bool _isDarkMode = true;
  bool _isLoading = true;
  String _languageCode = 'ar';
  Map<int, int> _levelAnsweredCounts = {};
  int _coins = 20;

  int get totalScore => _totalScore;
  String get languageCode => _languageCode;
  int get currentLevel => _currentLevel;
  List<int> get unlockedLevels => _unlockedLevels;
  List<int> get completedLevels => _completedLevels;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;
  int get coins => _coins;

  int get totalAnsweredQuestions {
    int sum = 0;
    for (final lvl in QuizData.levels) {
      final answered = _levelAnsweredCounts[lvl.id] ?? 0;
      sum += answered > lvl.questions.length ? lvl.questions.length : answered;
    }
    return sum;
  }

  Future<void> loadData() async {
    _totalScore = await GameStorage.getScore();
    _unlockedLevels = await GameStorage.getUnlockedLevels();
    _completedLevels = await GameStorage.getCompletedLevels();
    _isDarkMode = await GameStorage.getDarkMode();
    _languageCode = await GameStorage.getLanguageCode();
    _levelAnsweredCounts = await GameStorage.getLevelAnsweredMap();
    _coins = await GameStorage.getCoins();
    if (!_unlockedLevels.contains(1)) _unlockedLevels.add(1);
    _syncUnlockedLevels();
    _currentLevel = _computeResumeLevel();
    await GameStorage.saveCurrentLevel(_currentLevel);
    _isLoading = false;
    notifyListeners();
  }

  void _syncUnlockedLevels() {
    if (!_unlockedLevels.contains(1)) {
      _unlockedLevels.add(1);
    }

    for (int i = 2; i <= QuizData.levels.length; i++) {
      final shouldUnlockByScore = _totalScore >= (i - 1) * 120;
      final shouldUnlockByPrevious = _completedLevels.contains(i - 1);
      if ((shouldUnlockByScore || shouldUnlockByPrevious) &&
          !_unlockedLevels.contains(i)) {
        _unlockedLevels.add(i);
      }
    }
    GameStorage.saveUnlockedLevels(_unlockedLevels);
  }

  int _computeResumeLevel() {
    for (final lvl in QuizData.levels) {
      if (_unlockedLevels.contains(lvl.id) &&
          !_completedLevels.contains(lvl.id)) {
        return lvl.id;
      }
    }
    return QuizData.levels.isEmpty ? 1 : QuizData.levels.last.id;
  }

  void addScore(int pts) {
    _totalScore += pts;
    GameStorage.saveScore(_totalScore);
    _syncUnlockedLevels();
    notifyListeners();
  }

  void completeQuestion() {
    _coins += 2;
    GameStorage.saveCoins(_coins);
    notifyListeners();
  }

  void addCoins(int amount) {
    _coins += amount;
    GameStorage.saveCoins(_coins);
    notifyListeners();
  }

  bool spendCoins(int amount) {
    if (_coins < amount) return false;
    _coins -= amount;
    GameStorage.saveCoins(_coins);
    notifyListeners();
    return true;
  }

  void recordAnsweredProgress(int levelId, int answeredCount) {
    final current = _levelAnsweredCounts[levelId] ?? 0;
    if (answeredCount > current) {
      _levelAnsweredCounts[levelId] = answeredCount;
      GameStorage.saveLevelAnsweredCount(levelId, answeredCount);
      notifyListeners();
    }
  }

  void markLevelCompleted(int levelId) {
    if (!_completedLevels.contains(levelId)) {
      _completedLevels.add(levelId);
      GameStorage.saveCompletedLevels(_completedLevels);
    }
    _syncUnlockedLevels();
    final lvl = QuizData.levels.firstWhere((l) => l.id == levelId,
        orElse: () => QuizData.levels.first);
    recordAnsweredProgress(levelId, lvl.questions.length);
    final nextId = levelId + 1;
    if (nextId <= QuizData.levels.length && !_unlockedLevels.contains(nextId)) {
      _unlockedLevels.add(nextId);
      GameStorage.saveUnlockedLevels(_unlockedLevels);
    }
    final int computed = _computeResumeLevel();
    if (computed != _currentLevel) {
      _currentLevel = computed;
      GameStorage.saveCurrentLevel(_currentLevel);
    }
    notifyListeners();
  }

  void setCurrentLevel(int lvl) {
    _currentLevel = lvl;
    GameStorage.saveCurrentLevel(lvl);
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    GameStorage.saveDarkMode(_isDarkMode);
    notifyListeners();
  }

  void toggleLanguage() {
    _languageCode = _languageCode == 'ar' ? 'en' : 'ar';
    GameStorage.saveLanguageCode(_languageCode);
    notifyListeners();
  }

  int answeredCountForLevel(int levelId) => _levelAnsweredCounts[levelId] ?? 0;
  bool isLevelUnlocked(int id) => _unlockedLevels.contains(id);
  bool isLevelCompleted(int id) => _completedLevels.contains(id);

  Future<void> resetGame() async {
    await GameStorage.resetGame();
    _totalScore = 0;
    _currentLevel = 1;
    _unlockedLevels = [1];
    _completedLevels = [];
    _levelAnsweredCounts = {};
    _coins = 20;
    notifyListeners();
  }
}

// ============================================================
// 🌟 جذر التطبيق
// ============================================================
class QuizApp extends StatefulWidget {
  const QuizApp({super.key});
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final GameState _gs = GameState();
  late Locale _locale = Locale(_gs.languageCode);

  @override
  void initState() {
    super.initState();
    _gs.addListener(_syncLocale);
    _gs.loadData();
  }

  void _syncLocale() {
    setState(() {
      _locale = Locale(_gs.languageCode);
    });
  }

  @override
  void dispose() {
    _gs.removeListener(_syncLocale);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = _locale;
    return AnimatedBuilder(
      animation: _gs,
      builder: (_, __) => MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supported) {
          if (locale == null) return supported.first;
          for (var supportedLocale in supported) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return supported.first;
        },
        title: _gs.languageCode == 'ar' ? 'لعبة الأسئلة' : 'Quiz Game',
        debugShowCheckedModeBanner: false,
        themeMode: _gs.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: _lightTheme(),
        darkTheme: _darkTheme(),
        home: SplashScreen(gameState: _gs),
      ),
    );
  }

  ThemeData _lightTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryLight, brightness: Brightness.light),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: _textTheme(false),
      );
  ThemeData _darkTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryDark, brightness: Brightness.dark),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: _textTheme(true),
      );
  TextTheme _textTheme(bool dark) {
    final c = dark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    return TextTheme(
      displayLarge:
          TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 32),
      headlineLarge:
          TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 24),
      headlineMedium:
          TextStyle(color: c, fontWeight: FontWeight.w600, fontSize: 20),
      bodyLarge: TextStyle(color: c, fontSize: 16),
      bodyMedium: TextStyle(color: c, fontSize: 14),
    );
  }
}

// ============================================================
// 💫 شاشة الـ Splash
// ============================================================
class SplashScreen extends StatefulWidget {
  final GameState gameState;
  const SplashScreen({super.key, required this.gameState});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _scaleCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900));
  late final AnimationController _fadeCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));
  late final AnimationController _rotCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100));
  late final AnimationController _dotsCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat();

  late final Animation<double> _scaleAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.elasticOut));
  late final Animation<double> _fadeAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));
  late final Animation<double> _rotAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _rotCtrl, curve: Curves.easeOutBack));

  @override
  void initState() {
    super.initState();

    // ✅ تهيئة الإعلانات مسبقاً
    AdManager.instance.loadInterstitial();
    RewardedAdHelper.load();
    AdManager.instance.loadAppOpenAd(); // ✅ تحميل إعلان شاشة الفتح

    _scaleCtrl.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _fadeCtrl.forward();
      _rotCtrl.forward();
    });

    // ✅ عرض إعلان شاشة الفتح بعد انتهاء الأنيميشن، ثم الانتقال للرئيسية
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (!mounted) return;
      AdManager.instance.showAppOpenAdIfAvailable(
        onAdDismissed: _goHome,
      );
    });
  }

  void _goHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) => HomeScreen(gameState: widget.gameState),
      transitionsBuilder: (_, a, __, child) =>
          FadeTransition(opacity: a, child: child),
      transitionDuration: const Duration(milliseconds: 500),
    ));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _fadeCtrl.dispose();
    _rotCtrl.dispose();
    _dotsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Center(
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: RotationTransition(
                    turns: _rotAnim,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(color: Colors.white30, width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 24,
                              spreadRadius: 4)
                        ],
                      ),
                      child: const Center(
                          child: Text('🧠', style: TextStyle(fontSize: 68))),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(children: [
                  Text(
                      AppLocalizations.tr(context,
                          ar: 'لعبة الأسئلة', en: 'Quiz Game'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 6),
                  Text(
                      AppLocalizations.tr(context,
                          ar:
                              'اختبر معلوماتك في ${QuizData.levels.length} مراحل',
                          en:
                              'Test your knowledge in ${QuizData.levels.length} levels'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(
                      AppLocalizations.tr(context,
                          ar:
                              '${QuizData.levels.fold(0, (s, l) => s + l.questions.length)} سؤالاً متنوعاً',
                          en:
                              '${QuizData.levels.fold(0, (s, l) => s + l.questions.length)} diverse questions'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.65), fontSize: 13)),
                ]),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: AnimatedBuilder(
                  animation: _dotsCtrl,
                  builder: (_, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _dotsCtrl.value,
                      minHeight: 5,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                  AppLocalizations.tr(context,
                      ar: 'جارٍ التحميل...', en: 'Loading...'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 🏠 الشاشة الرئيسية
// ============================================================
class HomeScreen extends StatefulWidget {
  final GameState gameState;
  const HomeScreen({super.key, required this.gameState});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _headerCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 700));
  late final AnimationController _cardsCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 700));
  late final Animation<Offset> _headerSlide =
      Tween<Offset>(begin: const Offset(0, -0.6), end: Offset.zero).animate(
          CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));
  late final Animation<double> _cardsFade = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _cardsCtrl, curve: Curves.easeIn));

  BannerAd? _bannerAd;
  bool _bannerReady = false;

  @override
  void initState() {
    super.initState();
    _headerCtrl.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _cardsCtrl.forward();
    });
    _loadBanner();
  }

  Future<void> _loadBanner() async {
    final width = MediaQuery.of(context).size.width.truncate();
    final ad = await AdManager.instance.createAdaptiveBannerAd(
      width: width,
      onLoaded: () {
        if (mounted) setState(() => _bannerReady = true);
      },
    );
    if (mounted) {
      _bannerAd = ad;
    } else {
      ad?.dispose();
    }
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _cardsCtrl.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  bool get _isDark => widget.gameState.isDarkMode;
  Color get _bg =>
      _isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
  Color get _card => _isDark ? AppColors.cardDark : AppColors.cardLight;
  Color get _txt =>
      _isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  Color get _sub => _isDark ? AppColors.textSecDark : AppColors.textSecLight;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.gameState,
      builder: (_, __) => Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopBar(),
                const SizedBox(height: 20),
                SlideTransition(
                    position: _headerSlide, child: _buildScoreCard()),
                const SizedBox(height: 22),
                SlideTransition(
                    position: _headerSlide, child: _buildQuickStats()),
                const SizedBox(height: 26),
                FadeTransition(
                  opacity: _cardsFade,
                  child: Column(children: [
                    _actionBtn(
                        icon: Icons.play_arrow_rounded,
                        title: AppLocalizations.tr(context,
                            ar: 'ابدأ اللعبة', en: 'Start Game'),
                        subtitle: AppLocalizations.tr(context,
                            ar: 'اختر المرحلة التي تريد اللعب منها',
                            en: 'Choose the level to play'),
                        gradient: AppColors.primaryGradient,
                        onTap: _startGame),
                    const SizedBox(height: 14),
                    _actionBtn(
                        icon: Icons.grid_view_rounded,
                        title: AppLocalizations.tr(context,
                            ar: 'اختيار المرحلة', en: 'Select Level'),
                        subtitle: AppLocalizations.tr(context,
                            ar:
                                '${widget.gameState.unlockedLevels.length} مراحل مفتوحة من ${QuizData.levels.length}',
                            en:
                                '${widget.gameState.unlockedLevels.length} open levels of ${QuizData.levels.length}'),
                        gradient: LinearGradient(colors: [
                          AppColors.secondaryDark,
                          AppColors.secondaryDark.withOpacity(0.7)
                        ]),
                        onTap: _openLevels),
                    const SizedBox(height: 14),
                    _actionBtn(
                        icon: Icons.leaderboard_rounded,
                        title: AppLocalizations.tr(context,
                            ar: 'لوحة التقدم', en: 'Progress Board'),
                        subtitle: AppLocalizations.tr(context,
                            ar: 'شاهد تقدمك في المراحل',
                            en: 'See your progress through levels'),
                        gradient: const LinearGradient(
                            colors: [Color(0xFFFF6D00), Color(0xFFFF9800)]),
                        onTap: _openProgress),
                    const SizedBox(height: 14),
                    _actionBtn(
                        icon: Icons.privacy_tip_rounded,
                        title: AppLocalizations.tr(context,
                            ar: 'سياسة الخصوصية', en: 'Privacy Policy'),
                        subtitle: AppLocalizations.tr(context,
                            ar: 'اقرأ سياسة حماية بياناتك',
                            en: 'Read how your data is protected'),
                        gradient: LinearGradient(colors: [
                          Colors.grey.shade700,
                          Colors.grey.shade900
                        ]),
                        onTap: _openPrivacy),
                    const SizedBox(height: 18),
                    Row(children: [
                      Expanded(
                          child: _smallBtn(
                              Icons.refresh_rounded,
                              AppLocalizations.tr(context,
                                  ar: 'إعادة ضبط', en: 'Reset'),
                              AppColors.wrongColor,
                              _confirmReset)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _smallBtn(
                              Icons.info_outline_rounded,
                              AppLocalizations.tr(context,
                                  ar: 'عن اللعبة', en: 'About'),
                              AppColors.primaryDark,
                              _showAbout)),
                    ]),
                  ]),
                ),

                // ✅ عرض إعلان البانر
                if (_bannerReady && _bannerAd != null) ...[
                  const SizedBox(height: 18),
                  Container(
                    alignment: Alignment.center,
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              AppLocalizations.tr(context,
                  ar: '🧠 لعبة الأسئلة', en: '🧠 Quiz Game'),
              style: TextStyle(
                  color: _txt, fontSize: 20, fontWeight: FontWeight.bold)),
          Row(children: [
            GestureDetector(
              onTap: widget.gameState.toggleLanguage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _card, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  widget.gameState.languageCode == 'ar' ? 'EN' : 'عربي',
                  style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: widget.gameState.toggleDarkMode,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _card, borderRadius: BorderRadius.circular(12)),
                child: Icon(
                    _isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: AppColors.primaryDark,
                    size: 20),
              ),
            ),
          ]),
        ],
      );

  Widget _buildScoreCard() => Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryDark.withOpacity(0.45),
                blurRadius: 22,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('🏆', style: TextStyle(fontSize: 26)),
            const SizedBox(width: 8),
            Text(
                AppLocalizations.tr(context,
                    ar: 'إجمالي نقاطك', en: 'Total Score'),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9), fontSize: 15)),
          ]),
          const SizedBox(height: 8),
          Text('${widget.gameState.totalScore}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 58,
                  fontWeight: FontWeight.bold,
                  height: 1.1)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text('🪙', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 5),
              Text(
                  AppLocalizations.tr(context,
                      ar: '${widget.gameState.coins} عملة',
                      en: '${widget.gameState.coins} coins'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ]),
          ),
          Divider(color: Colors.white.withOpacity(0.25), height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _scoreStat(
                '📊',
                AppLocalizations.tr(context,
                    ar: 'المرحلة الحالية', en: 'Current level'),
                '${widget.gameState.currentLevel}'),
            _scoreStat(
                '🔓',
                AppLocalizations.tr(context,
                    ar: 'مراحل مفتوحة', en: 'Unlocked levels'),
                '${widget.gameState.unlockedLevels.length}/${QuizData.levels.length}'),
            _scoreStat(
                '✅',
                AppLocalizations.tr(context,
                    ar: 'مراحل مكتملة', en: 'Completed levels'),
                '${widget.gameState.completedLevels.length}/${QuizData.levels.length}'),
          ]),
        ]),
      );

  Widget _scoreStat(String e, String label, String val) => Column(children: [
        Text(e, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 2),
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10)),
      ]);

  Widget _buildQuickStats() {
    final total = QuizData.levels.fold(0, (s, l) => s + l.questions.length);
    final answered = widget.gameState.totalAnsweredQuestions;
    final pct = total == 0 ? 0.0 : answered / total;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
              AppLocalizations.tr(context,
                  ar: 'التقدم الكلي', en: 'Overall progress'),
              style: TextStyle(
                  color: _txt, fontWeight: FontWeight.w600, fontSize: 13)),
          Text(
              AppLocalizations.tr(context,
                  ar: '$answered / $total سؤال',
                  en: '$answered / $total questions'),
              style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 8,
            backgroundColor: AppColors.primaryDark.withOpacity(0.15),
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryDark),
          ),
        ),
        const SizedBox(height: 6),
        Text(
            AppLocalizations.tr(context,
                ar: '${(pct * 100).toStringAsFixed(0)}% مكتمل',
                en: '${(pct * 100).toStringAsFixed(0)}% completed'),
            style: TextStyle(color: _sub, fontSize: 11)),
      ]),
    );
  }

  Widget _actionBtn(
          {required IconData icon,
          required String title,
          required String subtitle,
          required LinearGradient gradient,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: gradient.colors.first.withOpacity(0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Row(children: [
            Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: Colors.white, size: 24)),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12)),
                ])),
            Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.7), size: 16),
          ]),
        ),
      );

  Widget _smallBtn(
          IconData ic, String label, Color color, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.3))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(ic, color: color, size: 17),
            const SizedBox(width: 7),
            Text(label,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w600, fontSize: 13)),
          ]),
        ),
      );

  void _startGame() => Navigator.push(
      context, _route(LevelSelectorScreen(gameState: widget.gameState)));
  void _openLevels() => Navigator.push(
      context, _route(LevelSelectorScreen(gameState: widget.gameState)));
  void _openProgress() => Navigator.push(
      context, _route(ProgressScreen(gameState: widget.gameState)));
  void _openPrivacy() =>
      Navigator.push(context, _route(const PrivacyPolicyScreen()));

  PageRoute _route(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, a, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 350),
      );

  void _confirmReset() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.tr(context,
              ar: 'إعادة ضبط اللعبة ⚠️', en: 'Reset Game ⚠️')),
          content: Text(AppLocalizations.tr(context,
              ar: 'سيتم حذف جميع نقاطك ومراحلك المفتوحة. هل أنت متأكد؟',
              en: 'Your score and unlocked levels will be deleted. Are you sure?')),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                    AppLocalizations.tr(context, ar: 'إلغاء', en: 'Cancel'))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.wrongColor),
              onPressed: () {
                widget.gameState.resetGame();
                Navigator.pop(context);
              },
              child: Text(
                  AppLocalizations.tr(context,
                      ar: 'نعم، إعادة ضبط', en: 'Yes, reset'),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

  void _showAbout() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('🧠', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 10),
            Text(
                AppLocalizations.tr(context,
                    ar: 'لعبة الأسئلة', en: 'Quiz Game'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
                AppLocalizations.tr(context,
                    ar: 'الإصدار 1.1.0', en: 'Version 1.1.0'),
                style: const TextStyle(fontSize: 13)),
            Text(
                AppLocalizations.tr(context,
                    ar: 'طور بواسطة قاسم البلداوي',
                    en: 'Developed by Qasim Al-Baldawi'),
                style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                  AppLocalizations.tr(context,
                      ar: '${QuizData.levels.length} مراحل • ${QuizData.levels.fold(0, (s, l) => s + l.questions.length)} سؤالاً متنوعاً\nعلوم • جغرافيا • تاريخ • تقنية\nرياضة • طبيعة • فضاء • فن • طب • دين • ألغاز • أعلام',
                      en: '${QuizData.levels.length} levels • ${QuizData.levels.fold(0, (s, l) => s + l.questions.length)} diverse questions\nScience • Geography • History • Tech\nSports • Nature • Space • Art • Health • Religion • Puzzles • Flags'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, height: 1.6)),
            ),
          ]),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text(AppLocalizations.tr(context, ar: 'حسناً', en: 'OK')))
          ],
        ),
      );
}

// ============================================================
// 🗂️ شاشة اختيار المرحلة
// ============================================================
class LevelSelectorScreen extends StatelessWidget {
  final GameState gameState;
  const LevelSelectorScreen({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    final isDark = gameState.isDarkMode;
    final bg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(
          AppLocalizations.tr(context,
              ar: 'اختر مرحلتك', en: 'Choose your level'),
          isDark),
      body: AnimatedBuilder(
        animation: gameState,
        builder: (_, __) {
          QuizLevel? resumeLevel;
          for (final lvl in QuizData.levels) {
            if (gameState.isLevelUnlocked(lvl.id) &&
                !gameState.isLevelCompleted(lvl.id)) {
              resumeLevel = lvl;
              break;
            }
          }
          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (resumeLevel != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primaryDark.withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: Row(children: [
                      Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                              child: Text(resumeLevel.icon,
                                  style: const TextStyle(fontSize: 26)))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                AppLocalizations.tr(context,
                                    ar: 'وصلت إلى المرحلة ${resumeLevel.id}',
                                    en: 'You reached level ${resumeLevel.id}'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                            Text(resumeLevel.title,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ])),
                      GestureDetector(
                        onTap: () {
                          gameState.setCurrentLevel(resumeLevel!.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => QuizScreen(
                                      level: resumeLevel!,
                                      gameState: gameState)));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                              AppLocalizations.tr(context,
                                  ar: 'تابع', en: 'Continue'),
                              style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                    ]),
                  )
                else
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      const Text('👑', style: TextStyle(fontSize: 30)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(
                              AppLocalizations.tr(context,
                                  ar:
                                      'أكملت جميع المراحل! يمكنك إعادة أي مرحلة.',
                                  en:
                                      'You have completed all levels! You can replay any level.'),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13))),
                    ]),
                  ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.82),
                    itemCount: QuizData.levels.length,
                    itemBuilder: (ctx, i) {
                      final lvl = QuizData.levels[i];
                      final unlocked = gameState.isLevelUnlocked(lvl.id);
                      final completed = gameState.isLevelCompleted(lvl.id);
                      final isCurrent = gameState.currentLevel == lvl.id;
                      return GestureDetector(
                        onTap: unlocked
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QuizScreen(
                                            level: lvl, gameState: gameState)));
                              }
                            : () => _lockedSnack(context, lvl),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            gradient: unlocked
                                ? LinearGradient(
                                    colors: [
                                        lvl.color,
                                        lvl.color.withOpacity(0.65)
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)
                                : const LinearGradient(
                                    colors: [Colors.grey, Colors.grey]),
                            borderRadius: BorderRadius.circular(22),
                            border: isCurrent
                                ? Border.all(
                                    color: AppColors.goldColor, width: 2.5)
                                : null,
                            boxShadow: [
                              BoxShadow(
                                  color: (unlocked ? lvl.color : Colors.black)
                                      .withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Text(lvl.icon,
                                    style: const TextStyle(fontSize: 38)),
                                if (!unlocked)
                                  Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.black.withOpacity(0.45),
                                      child: const Icon(Icons.lock_rounded,
                                          color: Colors.white70, size: 26)),
                                if (completed)
                                  Positioned(
                                      top: -2,
                                      left: -2,
                                      child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              color: AppColors.correctColor,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.check,
                                              color: Colors.white, size: 12))),
                              ]),
                              const SizedBox(height: 8),
                              Text(
                                  AppLocalizations.tr(context,
                                      ar: 'المرحلة ${lvl.id}',
                                      en: 'Level ${lvl.id}'),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75),
                                      fontSize: 11)),
                              Text(lvl.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isCurrent)
                                      _chip(
                                          AppLocalizations.tr(context,
                                              ar: '▶ حالية', en: '▶ Current'),
                                          AppColors.goldColor,
                                          Colors.black),
                                    if (completed)
                                      _chip(
                                          AppLocalizations.tr(context,
                                              ar: '✓ مكتملة',
                                              en: '✓ Completed'),
                                          AppColors.correctColor,
                                          Colors.white),
                                    if (!unlocked)
                                      _chip(
                                          AppLocalizations.tr(context,
                                              ar: 'مقفلة', en: 'Locked'),
                                          Colors.white24,
                                          Colors.white70),
                                  ]),
                              const SizedBox(height: 4),
                              Text(
                                  AppLocalizations.tr(context,
                                      ar: '${lvl.questions.length} سؤال',
                                      en: '${lvl.questions.length} questions'),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 10)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chip(String label, Color bg, Color fg) => Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text(label,
            style:
                TextStyle(color: fg, fontSize: 9, fontWeight: FontWeight.bold)),
      );

  void _lockedSnack(BuildContext ctx, QuizLevel lvl) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(AppLocalizations.tr(ctx,
          ar: 'أكمل المرحلة السابقة لفتح هذه المرحلة',
          en: 'Complete the previous level to unlock this one')),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }
}

// ============================================================
// 📈 شاشة لوحة التقدم
// ============================================================
class ProgressScreen extends StatelessWidget {
  final GameState gameState;
  const ProgressScreen({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    final isDark = gameState.isDarkMode;
    final bg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final card = isDark ? AppColors.cardDark : AppColors.cardLight;
    final txt = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final sub = isDark ? AppColors.textSecDark : AppColors.textSecLight;
    final totalQuestions =
        QuizData.levels.fold(0, (s, l) => s + l.questions.length);

    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(
          AppLocalizations.tr(context, ar: 'لوحة التقدم', en: 'Progress Board'),
          isDark),
      body: AnimatedBuilder(
        animation: gameState,
        builder: (_, __) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(22)),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _summaryItem(
                          '🏆',
                          '${gameState.totalScore}',
                          AppLocalizations.tr(context,
                              ar: 'إجمالي النقاط', en: 'Total points')),
                      _summaryItem(
                          '✅',
                          '${gameState.completedLevels.length}',
                          AppLocalizations.tr(context,
                              ar: 'مراحل مكتملة', en: 'Completed levels')),
                      _summaryItem(
                          '🔓',
                          '${gameState.unlockedLevels.length}',
                          AppLocalizations.tr(context,
                              ar: 'مراحل مفتوحة', en: 'Unlocked levels')),
                    ]),
                const SizedBox(height: 14),
                Divider(color: Colors.white.withOpacity(0.25), height: 1),
                const SizedBox(height: 14),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.tr(context,
                              ar: 'إجمالي الأسئلة المُجابة',
                              en: 'Total answered questions'),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      Text(
                          '${gameState.totalAnsweredQuestions} / $totalQuestions',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ]),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: totalQuestions == 0
                        ? 0
                        : gameState.totalAnsweredQuestions / totalQuestions,
                    minHeight: 7,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            Text(
                AppLocalizations.tr(context,
                    ar: 'تفاصيل المراحل', en: 'Level details'),
                style: TextStyle(
                    color: txt, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...QuizData.levels.map((lvl) {
              final unlocked = gameState.isLevelUnlocked(lvl.id);
              final completed = gameState.isLevelCompleted(lvl.id);
              final answeredInLevel = gameState.answeredCountForLevel(lvl.id);
              final progress = completed
                  ? 1.0
                  : (lvl.questions.isEmpty
                      ? 0.0
                      : (answeredInLevel / lvl.questions.length)
                          .clamp(0.0, 1.0));
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: completed
                          ? AppColors.correctColor.withOpacity(0.5)
                          : unlocked
                              ? lvl.color.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.2)),
                ),
                child: Row(children: [
                  Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: (unlocked ? lvl.color : Colors.grey)
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(unlocked ? lvl.icon : '🔒',
                              style: const TextStyle(fontSize: 22)))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(children: [
                          Text(lvl.title,
                              style: TextStyle(
                                  color: txt,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          const Spacer(),
                          if (completed)
                            const Icon(Icons.check_circle,
                                color: AppColors.correctColor, size: 18)
                          else if (!unlocked)
                            Text(
                                AppLocalizations.tr(context,
                                    ar: 'مقفلة', en: 'Locked'),
                                style: TextStyle(color: sub, fontSize: 10))
                          else if (answeredInLevel > 0)
                            Text(
                                AppLocalizations.tr(context,
                                    ar: 'جارية', en: 'In progress'),
                                style: TextStyle(
                                    color: AppColors.secondaryDark,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                        ]),
                        const SizedBox(height: 4),
                        Text(
                            AppLocalizations.tr(context,
                                ar: completed
                                    ? '${lvl.questions.length} سؤال'
                                    : '$answeredInLevel / ${lvl.questions.length} سؤال',
                                en: completed
                                    ? '${lvl.questions.length} questions'
                                    : '$answeredInLevel / ${lvl.questions.length} questions'),
                            style: TextStyle(color: sub, fontSize: 11)),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 4,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation(
                                completed ? AppColors.correctColor : lvl.color),
                          ),
                        ),
                      ])),
                ]),
              );
            }),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: AppColors.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: AppColors.goldColor.withOpacity(0.3))),
              child: Row(children: [
                const Text('💡', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                        AppLocalizations.tr(context,
                            ar:
                                'أكمل المراحل بالتسلسل لفتح مراحل جديدة.\nكل إجابة صحيحة = 10 نقاط',
                            en:
                                'Complete levels in order to unlock new ones.\nEach correct answer = 10 points'),
                        style: const TextStyle(
                            color: AppColors.textSecDark,
                            fontSize: 12,
                            height: 1.5))),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String emoji, String val, String label) =>
      Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 2),
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10)),
      ]);
}

class QuizProgressTracker {
  final Set<int> wrongAnswers = <int>{};
  final Set<int> passedQuestions = <int>{};

  void recordAnswer(int questionIndex, bool isCorrect) {
    if (isCorrect) {
      passedQuestions.add(questionIndex);
      wrongAnswers.remove(questionIndex);
    } else {
      wrongAnswers.add(questionIndex);
    }
  }

  bool isWrong(int questionIndex) =>
      wrongAnswers.contains(questionIndex) &&
      !passedQuestions.contains(questionIndex);

  bool isPassed(int questionIndex) => passedQuestions.contains(questionIndex);

  void reset() {
    wrongAnswers.clear();
    passedQuestions.clear();
  }
}

// ============================================================
// ❓ شاشة الأسئلة
// ============================================================
class QuizScreen extends StatefulWidget {
  final QuizLevel level;
  final GameState gameState;
  const QuizScreen({super.key, required this.level, required this.gameState});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _qIdx = 0;
  int _levelScore = 0;
  int? _selected;
  bool _answered = false;
  bool _isDisposed = false;
  Set<int> _eliminated = {};
  final QuizProgressTracker _progressTracker = QuizProgressTracker();
  bool _watchingAd = false;
  int _interstitialTriggerCount = 0;
  BannerAd? _bannerAd;
  bool _bannerReady = false;

  late final AnimationController _qCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 450));
  late final AnimationController _resCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 350));
  late final AnimationController _timerCtrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 25))
        ..addStatusListener(_onTimerDone);
  late Animation<double> _qFade = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _qCtrl, curve: Curves.easeIn));
  late Animation<Offset> _qSlide =
      Tween<Offset>(begin: const Offset(0.4, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: _qCtrl, curve: Curves.easeOutCubic));
  late Animation<double> _resScale = Tween<double>(begin: 0.6, end: 1.0)
      .animate(CurvedAnimation(parent: _resCtrl, curve: Curves.elasticOut));

  @override
  void initState() {
    super.initState();
    _loadBanner();
    _restoreProgressThenStart();
  }

  Future<void> _loadBanner() async {
    final width = MediaQuery.of(context).size.width.truncate();
    final ad = await AdManager.instance.createAdaptiveBannerAd(
      width: width,
      onLoaded: () {
        if (mounted) setState(() => _bannerReady = true);
      },
    );
    if (mounted) {
      _bannerAd = ad;
    } else {
      ad?.dispose();
    }
  }

  Future<void> _restoreProgressThenStart() async {
    final prog = await GameStorage.getLevelProgress(widget.level.id);
    if (prog != null && prog['levelId'] == widget.level.id && !_isDisposed) {
      final savedIdx = prog['qIdx'] ?? 0;
      final savedScore = prog['levelScore'] ?? 0;
      if (savedIdx >= 0 && savedIdx < _total) {
        setState(() {
          _qIdx = savedIdx;
          _levelScore = savedScore;
        });
      }
    }
    if (!mounted) return;
    if (widget.gameState.isLevelCompleted(widget.level.id) &&
        (_qIdx >= _total - 1 || _qIdx == 0 && _levelScore >= _total * 10)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _openCompleteDialog();
      });
      return;
    }
    _startQuestion();
  }

  void _persistProgress() {
    GameStorage.saveLevelProgress(widget.level.id, _qIdx, _levelScore);
  }

  void _startQuestion() {
    _qCtrl.forward(from: 0);
    _timerCtrl.forward(from: 0);
  }

  void _onTimerDone(AnimationStatus s) {
    if (s == AnimationStatus.completed && !_answered && mounted) {
      _selectAnswer(-1);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _qCtrl.dispose();
    _resCtrl.dispose();
    _timerCtrl.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  QuizQuestion get _q => widget.level.questions[_qIdx];
  int get _total => widget.level.questions.length;

  void _selectAnswer(int idx) {
    if (_answered || _isDisposed) return;
    _timerCtrl.stop();
    setState(() {
      _selected = idx;
      _answered = true;
      _progressTracker.recordAnswer(_qIdx, idx == _q.correctIndex);
    });
    _resCtrl.forward(from: 0);
    if (idx == _q.correctIndex) {
      widget.gameState.addScore(10);
      _levelScore += 10;
    }
    widget.gameState.completeQuestion();
    widget.gameState.recordAnsweredProgress(widget.level.id, _qIdx + 1);
    _persistProgress();
    Future.delayed(const Duration(milliseconds: 1900), () {
      if (!mounted) return;
      if (_qIdx < _total - 1) {
        _handleQuestionTransition();
      } else {
        _showComplete();
      }
    });
  }

  void _handleQuestionTransition() {
    _interstitialTriggerCount += 1;
    final shouldShow = AdManager.shouldShowInterstitialForQuestionIndex(
      _interstitialTriggerCount,
    );
    if (shouldShow) {
      AdManager.instance.showInterstitial(onDismissed: () {
        if (!mounted) return;
        _nextQuestion();
      });
      return;
    }
    _nextQuestion();
  }

  void _use5050() {
    if (_answered || _eliminated.isNotEmpty) return;
    if (!widget.gameState.spendCoins(10)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.tr(context,
              ar: 'لا تملك عملات كافية 🪙 (تحتاج 10)',
              en: 'Not enough coins 🪙 (need 10)')),
          behavior: SnackBarBehavior.floating));
      return;
    }
    final wrongIndices = List.generate(_q.options.length, (i) => i)
        .where((i) => i != _q.correctIndex)
        .toList()
      ..shuffle();
    setState(() {
      _eliminated = wrongIndices.take(2).toSet();
    });
  }

  void _watchAdForCoins() {
    if (_watchingAd) return;
    if (!RewardedAdHelper.isReady) {
      RewardedAdHelper.load();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.tr(context,
              ar: 'الإعلان غير جاهز بعد، حاول خلال ثوانٍ 🎬',
              en: 'Ad is not ready yet, please try again in a few seconds 🎬')),
          behavior: SnackBarBehavior.floating));
      return;
    }
    setState(() => _watchingAd = true);
    RewardedAdHelper.show(
      onReward: () {
        widget.gameState.addCoins(10);
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.tr(context,
                  ar: '+10 عملات 🪙 شكراً لمشاهدتك!',
                  en: '+10 coins 🪙 thanks for watching!')),
              behavior: SnackBarBehavior.floating));
      },
      onDismissed: () {
        if (mounted) setState(() => _watchingAd = false);
      },
      onNotReady: () {
        if (mounted) setState(() => _watchingAd = false);
      },
    );
  }

  void _nextQuestion() {
    _qCtrl.reset();
    _resCtrl.reset();
    _timerCtrl.reset();
    setState(() {
      _qIdx++;
      _selected = null;
      _answered = false;
      _eliminated = {};
    });
    _persistProgress();
    _startQuestion();
  }

  void _showComplete() {
    widget.gameState.markLevelCompleted(widget.level.id);
    GameStorage.saveLevelProgress(widget.level.id, _total - 1, _levelScore);
    AdManager.instance.showInterstitial(onDismissed: () {
      if (!mounted) return;
      _openCompleteDialog();
    });
  }

  void _openCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LevelCompleteDialog(
        levelScore: _levelScore,
        levelTitle: widget.level.title,
        totalScore: widget.gameState.totalScore,
        levelId: widget.level.id,
        gameState: widget.gameState,
        onRetry: () {
          Navigator.pop(context);
          _restart();
        },
        onHome: () => Navigator.of(context).popUntil((r) => r.isFirst),
        onNext: _goNext,
      ),
    );
  }

  void _retryCurrentQuestion() {
    _qCtrl.reset();
    _resCtrl.reset();
    _timerCtrl.reset();
    setState(() {
      _selected = null;
      _answered = false;
      _eliminated = {};
    });
    _startQuestion();
  }

  void _restart() {
    GameStorage.saveLevelProgress(widget.level.id, 0, 0);
    setState(() {
      _qIdx = 0;
      _levelScore = 0;
      _selected = null;
      _answered = false;
      _eliminated = {};
      _progressTracker.reset();
      _startQuestion();
    });
  }

  void _goNext() {
    final nextId = widget.level.id + 1;
    Navigator.pop(context);
    if (nextId > QuizData.levels.length) {
      Navigator.pop(context);
      return;
    }
    final next = QuizData.levels.firstWhere((l) => l.id == nextId);
    if (!widget.gameState.isLevelUnlocked(next.id)) {
      Navigator.pop(context);
      return;
    }
    widget.gameState.setCurrentLevel(nextId);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                QuizScreen(level: next, gameState: widget.gameState)));
  }

  bool get _isDark => widget.gameState.isDarkMode;
  Color get _bg =>
      _isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
  Color get _card => _isDark ? AppColors.cardDark : AppColors.cardLight;
  Color get _txt =>
      _isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  Color get _sub => _isDark ? AppColors.textSecDark : AppColors.textSecLight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Column(children: [
                    _buildHeader(),
                    const SizedBox(height: 10),
                    _buildProgressAndTimer(),
                    const SizedBox(height: 16),
                    Container(
                      constraints: const BoxConstraints(minHeight: 190),
                      child: SlideTransition(
                        position: _qSlide,
                        child: FadeTransition(
                          opacity: _qFade,
                          child: _buildQuestionCard(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildQuestionProgressDots(),
                    const SizedBox(height: 10),
                    _buildHintsRow(),
                    const SizedBox(height: 10),
                    ..._buildOptions(),
                    const SizedBox(height: 8),
                    if (_bannerReady && _bannerAd != null) ...[
                      Container(
                        alignment: Alignment.center,
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ],
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionProgressDots() {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _total,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final isCurrent = index == _qIdx;
          final isPassed = index < _qIdx || _progressTracker.isPassed(index);
          final isCompleted =
              widget.gameState.isLevelCompleted(widget.level.id) &&
                  index == _total - 1;
          final isWrong = _progressTracker.isWrong(index);
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isWrong
                  ? AppColors.wrongColor
                  : isCompleted || isPassed
                      ? AppColors.correctColor
                      : isCurrent
                          ? widget.level.color
                          : Colors.grey.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isWrong || isCompleted || isPassed || isCurrent
                      ? Colors.white
                      : _sub,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHintsRow() {
    final canUse5050 = !_answered && _eliminated.isEmpty;
    return Row(children: [
      Expanded(
          child: _hintChip(
              icon: Icons.remove_red_eye_outlined,
              label: '50/50',
              costLabel: '10 🪙',
              enabled: canUse5050,
              onTap: _use5050)),
      const SizedBox(width: 10),
      Expanded(
          child: _hintChip(
              icon: Icons.play_circle_outline_rounded,
              label: _watchingAd
                  ? AppLocalizations.tr(context,
                      ar: 'جارٍ التحميل...', en: 'Loading...')
                  : AppLocalizations.tr(context,
                      ar: 'مشاهدة إعلان', en: 'Watch ad'),
              costLabel: '+10 🪙',
              enabled: !_answered && !_watchingAd,
              onTap: _watchAdForCoins,
              isReward: true)),
    ]);
  }

  Widget _hintChip(
      {required IconData icon,
      required String label,
      required String costLabel,
      required bool enabled,
      required VoidCallback onTap,
      bool isReward = false}) {
    final color = isReward ? AppColors.secondaryDark : widget.level.color;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: (enabled ? color : Colors.grey).withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: (enabled ? color : Colors.grey).withOpacity(0.35))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 16, color: enabled ? color : Colors.grey),
          const SizedBox(width: 6),
          Flexible(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: enabled ? _txt : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600))),
          const SizedBox(width: 5),
          Text(costLabel,
              style: TextStyle(
                  color: enabled ? color : Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildHeader() => Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: widget.level.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.arrow_back_ios_rounded,
                  color: widget.level.color, size: 18)),
        ),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.level.title,
              style: TextStyle(
                  color: _txt, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
              AppLocalizations.tr(context,
                  ar: 'السؤال ${_qIdx + 1} من $_total',
                  en: 'Question ${_qIdx + 1} of $_total'),
              style: TextStyle(color: widget.level.color, fontSize: 12)),
        ])),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              const Text('🏆', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text('${widget.gameState.totalScore}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ])),
        const SizedBox(width: 8),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: AppColors.secondaryDark.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.secondaryDark.withOpacity(0.4))),
            child: Row(children: [
              const Text('🪙', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text('${widget.gameState.coins}',
                  style: TextStyle(
                      color: _txt, fontWeight: FontWeight.bold, fontSize: 13)),
            ])),
      ]);

  Widget _buildProgressAndTimer() => Column(children: [
        Row(children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                      value: (_qIdx + 1) / _total,
                      minHeight: 6,
                      backgroundColor: widget.level.color.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(widget.level.color)))),
          const SizedBox(width: 10),
          Text('${((_qIdx + 1) / _total * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                  color: widget.level.color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),
        AnimatedBuilder(
          animation: _timerCtrl,
          builder: (_, __) {
            final remaining = ((1 - _timerCtrl.value) * 25).ceil();
            final isWarning = remaining <= 8;
            return Row(children: [
              Icon(Icons.timer_rounded,
                  size: 14, color: isWarning ? AppColors.wrongColor : _sub),
              const SizedBox(width: 4),
              Text(
                  AppLocalizations.tr(context,
                      ar: '$remaining ثانية', en: '$remaining sec'),
                  style: TextStyle(
                      color: isWarning ? AppColors.wrongColor : _sub,
                      fontSize: 11,
                      fontWeight:
                          isWarning ? FontWeight.bold : FontWeight.normal)),
              const SizedBox(width: 8),
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                          value: 1 - _timerCtrl.value,
                          minHeight: 4,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation(isWarning
                              ? AppColors.wrongColor
                              : AppColors.secondaryDark)))),
            ]);
          },
        ),
      ]);

  Widget _buildQuestionCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: widget.level.color.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                  color: widget.level.color.withOpacity(0.08),
                  blurRadius: 18,
                  spreadRadius: 2)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.level.icon, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 14),
          Text(_q.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _txt,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.5)),
          if (_answered) ...[
            const SizedBox(height: 14),
            ScaleTransition(
              scale: _resScale,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: (_selected == _q.correctIndex
                            ? AppColors.correctColor
                            : AppColors.wrongColor)
                        .withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: _selected == _q.correctIndex
                            ? AppColors.correctColor
                            : AppColors.wrongColor)),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(_selected == _q.correctIndex ? '✅' : '❌',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                        _selected == -1
                            ? AppLocalizations.tr(context,
                                ar: 'انتهى الوقت! ⏰', en: 'Time is up! ⏰')
                            : _selected == _q.correctIndex
                                ? AppLocalizations.tr(context,
                                    ar: 'إجابة صحيحة! +10 نقاط',
                                    en: 'Correct answer! +10 points')
                                : AppLocalizations.tr(context,
                                    ar: 'إجابة خاطئة!', en: 'Wrong answer!'),
                        style: TextStyle(
                            color: _selected == _q.correctIndex
                                ? AppColors.correctColor
                                : AppColors.wrongColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ]),
                  const SizedBox(height: 6),
                  Text(_q.explanation,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _sub, fontSize: 12, height: 1.4)),
                  if (_answered && _selected != _q.correctIndex) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _retryCurrentQuestion,
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: Text(AppLocalizations.tr(context,
                            ar: 'إعادة حل السؤال', en: 'Retry question')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ]),
              ),
            ),
          ],
        ]),
      );

  List<Widget> _buildOptions() {
    return List.generate(_q.options.length, (i) {
      final isSelected = _selected == i;
      final isCorrect = i == _q.correctIndex;
      final isWrong = isSelected && !isCorrect;
      final isEliminated = _eliminated.contains(i);
      Color borderColor;
      Color bgColor;
      if (isEliminated) {
        borderColor = Colors.grey.withOpacity(0.15);
        bgColor = Colors.grey.withOpacity(0.06);
      } else if (!_answered) {
        borderColor = AppColors.primaryDark.withOpacity(0.35);
        bgColor = AppColors.primaryDark.withOpacity(0.08);
      } else if (isCorrect) {
        borderColor = AppColors.correctColor;
        bgColor = AppColors.correctColor.withOpacity(0.12);
      } else if (isWrong) {
        borderColor = AppColors.wrongColor;
        bgColor = AppColors.wrongColor.withOpacity(0.12);
      } else {
        borderColor = Colors.grey.withOpacity(0.25);
        bgColor = Colors.transparent;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: GestureDetector(
          onTap: isEliminated ? null : () => _selectAnswer(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: borderColor, width: isSelected ? 2 : 1.5),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: borderColor.withOpacity(0.25), blurRadius: 8)
                      ]
                    : null),
            child: Row(children: [
              Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: (_answered && isCorrect)
                          ? AppColors.correctColor
                          : (_answered && isWrong)
                              ? AppColors.wrongColor
                              : AppColors.primaryDark
                                  .withOpacity(isEliminated ? 0.06 : 0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(String.fromCharCode(0x0041 + i),
                          style: TextStyle(
                              color: (_answered && (isCorrect || isWrong))
                                  ? Colors.white
                                  : (isEliminated
                                      ? Colors.grey
                                      : AppColors.primaryDark),
                              fontWeight: FontWeight.bold,
                              fontSize: 13)))),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(
                      isEliminated
                          ? AppLocalizations.tr(context,
                              ar: 'تم استبعادها', en: 'Eliminated')
                          : _q.options[i],
                      style: TextStyle(
                          color: isEliminated ? Colors.grey : _txt,
                          fontSize: 14,
                          decoration:
                              isEliminated ? TextDecoration.lineThrough : null,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal))),
              if (_answered && isCorrect)
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.correctColor, size: 20),
              if (_answered && isWrong)
                const Icon(Icons.cancel_rounded,
                    color: AppColors.wrongColor, size: 20),
              if (isEliminated)
                const Icon(Icons.block_rounded, color: Colors.grey, size: 18),
            ]),
          ),
        ),
      );
    });
  }
}

// ============================================================
// 🎉 حوار اكتمال المرحلة
// ============================================================
class LevelCompleteDialog extends StatelessWidget {
  final int levelScore;
  final String levelTitle;
  final int totalScore;
  final int levelId;
  final GameState gameState;
  final VoidCallback onRetry, onHome, onNext;
  const LevelCompleteDialog(
      {super.key,
      required this.levelScore,
      required this.levelTitle,
      required this.totalScore,
      required this.levelId,
      required this.gameState,
      required this.onRetry,
      required this.onHome,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final maxScore =
        QuizData.levels.firstWhere((l) => l.id == levelId).questions.length *
            10;
    final isPerfect = levelScore >= maxScore;
    final pct = maxScore == 0 ? 0.0 : levelScore / maxScore;
    final gradient =
        isPerfect ? AppColors.goldGradient : AppColors.primaryGradient;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(26)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(isPerfect ? '👑' : '🎉', style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 8),
          Text(
              AppLocalizations.tr(context,
                  ar: isPerfect ? 'أداء مثالي!' : 'أحسنت!',
                  en: isPerfect ? 'Perfect performance!' : 'Well done!'),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
              AppLocalizations.tr(context,
                  ar: 'انتهيت من $levelTitle', en: 'You finished $levelTitle'),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9), fontSize: 13)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _stat(
                    AppLocalizations.tr(context,
                        ar: 'نقاط المرحلة', en: 'Level points'),
                    '$levelScore'),
                _stat(AppLocalizations.tr(context, ar: 'الإجمالي', en: 'Total'),
                    '$totalScore'),
                _stat(AppLocalizations.tr(context, ar: 'الدقة', en: 'Accuracy'),
                    '${(pct * 100).toStringAsFixed(0)}%')
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 7,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Colors.white))),
            ]),
          ),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(
                child: _btn(Icons.replay_rounded,
                    AppLocalizations.tr(context, ar: 'إعادة', en: 'Retry'),
                    outlined: true, onTap: onRetry)),
            const SizedBox(width: 8),
            Expanded(
                child: _btn(Icons.home_rounded,
                    AppLocalizations.tr(context, ar: 'الرئيسية', en: 'Home'),
                    outlined: true, onTap: onHome)),
            const SizedBox(width: 8),
            Expanded(
                child: _btn(Icons.arrow_forward_rounded,
                    AppLocalizations.tr(context, ar: 'التالية', en: 'Next'),
                    outlined: false, onTap: onNext)),
          ]),
        ]),
      ),
    );
  }

  Widget _stat(String label, String val) => Column(children: [
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10)),
      ]);

  Widget _btn(IconData ic, String label,
          {required bool outlined, required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
              color: outlined ? Colors.white.withOpacity(0.2) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: outlined ? Border.all(color: Colors.white54) : null),
          child: Column(children: [
            Icon(ic,
                color: outlined ? Colors.white : AppColors.primaryDark,
                size: 20),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    color: outlined ? Colors.white : AppColors.primaryDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      );
}

// ============================================================
// 🔒 شاشة سياسة الخصوصية
// ============================================================
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
          AppLocalizations.tr(context,
              ar: 'سياسة الخصوصية', en: 'Privacy Policy'),
          Theme.of(context).brightness == Brightness.dark),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(22)),
              child: Column(children: [
                const Text('🔒', style: TextStyle(fontSize: 44)),
                const SizedBox(height: 8),
                Text(
                    AppLocalizations.tr(context,
                        ar: 'سياسة الخصوصية', en: 'Privacy Policy'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                    AppLocalizations.tr(context,
                        ar: 'آخر تحديث: يوليو 2026',
                        en: 'Last updated: July 2026'),
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
              ])),
          const SizedBox(height: 22),
          _section(
              AppLocalizations.tr(context,
                  ar: '1. المقدمة', en: '1. Introduction'),
              AppLocalizations.tr(context,
                  ar: 'مرحباً بكم في تطبيق "لعبة الأسئلة". نحن ملتزمون بحماية خصوصيتكم. توضح هذه السياسة كيفية جمعنا للمعلومات واستخدامها وحمايتها.',
                  en: 'Welcome to the Quiz Game app. We are committed to protecting your privacy. This policy explains how we collect, use, and protect information.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '2. البيانات التي نحفظها', en: '2. Data we keep'),
              AppLocalizations.tr(context,
                  ar: 'التطبيق يحفظ البيانات التالية محلياً على جهازك فقط:\n• إجمالي النقاط المكتسبة\n• رقم المرحلة الحالية\n• قائمة المراحل المفتوحة والمكتملة\n• تفضيل الوضع الداكن أو الفاتح\nلا نجمع أي بيانات شخصية كالاسم أو البريد الإلكتروني أو الموقع الجغرافي.',
                  en: 'The app stores the following data locally on your device only:\n• Total points earned\n• Current level number\n• List of unlocked and completed levels\n• Dark/light theme preference\nWe do not collect personal data like name, email, or location.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '3. استخدام البيانات', en: '3. Data use'),
              AppLocalizations.tr(context,
                  ar: 'البيانات المحفوظة تُستخدم حصرياً لـ:\n• حفظ تقدمك في اللعبة وعدم فقده\n• عرض النقاط والمراحل المفتوحة\n• تذكّر تفضيلات العرض\nلا تُشارك هذه البيانات مع أي طرف ثالث إطلاقاً.',
                  en: 'Saved data is used only to:\n• keep your game progress\n• display points and unlocked levels\n• remember display preferences\nThis data is never shared with third parties.')),
          _section(
              AppLocalizations.tr(context, ar: '4. الإعلانات', en: '4. Ads'),
              AppLocalizations.tr(context,
                  ar: 'يستخدم التطبيق خدمة إعلانات Google AdMob لعرض إعلانات (بانر، إعلانات بينية، إعلانات مكافأة، وإعلانات شاشة فتح) داخل التطبيق لدعم استمراريته مجاناً. قد تقوم Google بجمع معرّف الجهاز الإعلاني ومعلومات تقنية أخرى وفق سياسة خصوصية Google الخاصة بالإعلانات.',
                  en: 'The app uses Google AdMob to show ads (banner, interstitial, rewarded, and app open ads) to support the free experience. Google may collect advertising device identifiers and technical data according to its ads privacy policy.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '5. أمان البيانات', en: '5. Data security'),
              AppLocalizations.tr(context,
                  ar: 'بيانات تقدمك محفوظة على جهازك فقط باستخدام SharedPreferences ولا يُرسَل أي شيء منها إلى خوادمنا. يمكنك حذف جميع بياناتك في أي وقت عبر "إعادة ضبط" في الشاشة الرئيسية.',
                  en: 'Your progress data is stored only on your device using SharedPreferences and is not sent to our servers. You can delete all data at any time using the Reset option on the home screen.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '6. حقوقك', en: '6. Your rights'),
              AppLocalizations.tr(context,
                  ar: 'لديك الحق الكامل في:\n• الاطلاع على بياناتك المحفوظة\n• حذفها في أي وقت تشاء\n• إيقاف استخدام التطبيق',
                  en: 'You have the right to:\n• view your stored data\n• delete it at any time\n• stop using the app')),
          _section(
              AppLocalizations.tr(context, ar: '7. الأطفال', en: '7. Children'),
              AppLocalizations.tr(context,
                  ar: 'تطبيقنا مناسب لجميع الأعمار. لا نجمع أي بيانات خاصة بالأطفال دون موافقة ولي الأمر.',
                  en: 'Our app is suitable for all ages. We do not collect any data about children without parental consent.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '8. التعديلات', en: '8. Changes'),
              AppLocalizations.tr(context,
                  ar: 'قد نحدّث هذه السياسة من وقت لآخر. سيتم إخطارك بأي تغييرات جوهرية عند تحديث التطبيق.',
                  en: 'We may update this policy from time to time. You will be notified of any material changes when the app updates.')),
          _section(
              AppLocalizations.tr(context,
                  ar: '9. تواصل معنا', en: '9. Contact us'),
              AppLocalizations.tr(context,
                  ar: 'لأي استفسار حول سياسة الخصوصية:\n📧 support@quizgame.app\n🌐 www.quizgame.app',
                  en: 'For any privacy questions:\n📧 support@quizgame.app\n🌐 www.quizgame.app')),
          const SizedBox(height: 16),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: AppColors.primaryDark.withOpacity(0.50))),
              child: Text(
                  AppLocalizations.tr(context,
                      ar: 'باستخدامك للتطبيق فأنت توافق على هذه السياسة. إن لم تكن موافقاً يرجى التوقف عن الاستخدام.',
                      en: 'By using the app, you agree to this policy. If you do not agree, please stop using the app.'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, height: 1.6))),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  Widget _section(String title, String body) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark)),
          const SizedBox(height: 7),
          Text(body, style: const TextStyle(fontSize: 13, height: 1.7)),
          const Divider(height: 22),
        ]),
      );
}

// ============================================================
// 🔧 مساعد AppBar مشترك
// ============================================================
PreferredSizeWidget _appBar(String title, bool isDark) => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight)),
      iconTheme: IconThemeData(
          color:
              isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
    );
