// ============================================================
// 🎯 لعبة الأسئلة والأجوبة - Quiz Game
// الملف: main.dart  — منطق التطبيق وواجهاته فقط
// بيانات الأسئلة محفوظة في: quiz_data.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// استيراد ملف الأسئلة والنماذج
import 'quiz_data.dart';

// ============================================================
// 🚀 نقطة الدخول الرئيسية
// ============================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // إجبار الوضع العمودي
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // شريط الحالة شفاف
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const QuizApp());
}

// ============================================================
// 🎨 ألوان التطبيق المركزية
// ============================================================
class AppColors {
  // وضع داكن
  static const Color primaryDark = Color(0xFF6C63FF);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color backgroundDark = Color(0xFF0D0D1A);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF16213E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecDark = Color(0xFFB0B0D0);

  // وضع فاتح
  static const Color primaryLight = Color(0xFF5B52D9);
  static const Color backgroundLight = Color(0xFFF5F5FF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFEEEEFF);
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecLight = Color(0xFF5A5A7A);

  // حالات الإجابة
  static const Color correctColor = Color(0xFF4CAF50);
  static const Color wrongColor = Color(0xFFE53935);
  static const Color goldColor = Color(0xFFFFD700);

  // تدرجات
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

  static Future<void> resetGame() async {
    final p = await SharedPreferences.getInstance();
    await Future.wait([
      p.remove(_kScore),
      p.remove(_kLevel),
      p.remove(_kUnlocked),
      p.remove(_kCompletedLvl),
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

  int get totalScore => _totalScore;
  int get currentLevel => _currentLevel;
  List<int> get unlockedLevels => _unlockedLevels;
  List<int> get completedLevels => _completedLevels;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;

  /// تحميل جميع البيانات المحفوظة
  Future<void> loadData() async {
    _totalScore = await GameStorage.getScore();
    _currentLevel = await GameStorage.getCurrentLevel();
    _unlockedLevels = await GameStorage.getUnlockedLevels();
    _completedLevels = await GameStorage.getCompletedLevels();
    _isDarkMode = await GameStorage.getDarkMode();
    _isLoading = false;
    _syncUnlockedLevels();
    notifyListeners();
  }

  /// فتح المراحل التي استوفى المستخدم شرطها
  void _syncUnlockedLevels() {
    for (final lvl in QuizData.levels) {
      if (_totalScore >= lvl.requiredScore &&
          !_unlockedLevels.contains(lvl.id)) {
        _unlockedLevels.add(lvl.id);
      }
    }
    GameStorage.saveUnlockedLevels(_unlockedLevels);
  }

  void addScore(int pts) {
    _totalScore += pts;
    GameStorage.saveScore(_totalScore);
    _syncUnlockedLevels();
    notifyListeners();
  }

  void markLevelCompleted(int levelId) {
    if (!_completedLevels.contains(levelId)) {
      _completedLevels.add(levelId);
      GameStorage.saveCompletedLevels(_completedLevels);
    }
    // اجعل المرحلة التالية هي الحالية إن وُجدت
    final nextId = levelId + 1;
    if (nextId <= QuizData.levels.length) {
      setCurrentLevel(nextId);
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

  bool isLevelUnlocked(int id) => _unlockedLevels.contains(id);
  bool isLevelCompleted(int id) => _completedLevels.contains(id);

  Future<void> resetGame() async {
    await GameStorage.resetGame();
    _totalScore = 0;
    _currentLevel = 1;
    _unlockedLevels = [1];
    _completedLevels = [];
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

  @override
  void initState() {
    super.initState();
    _gs.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gs,
      builder: (_, __) => Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'لعبة الأسئلة',
          debugShowCheckedModeBanner: false,
          themeMode: _gs.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: _lightTheme(),
          darkTheme: _darkTheme(),
          home: SplashScreen(gameState: _gs),
        ),
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
    _scaleCtrl.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeCtrl.forward();
      _rotCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 3200), _goHome);
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

              // ── أيقونة متحركة ──
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

              // ── اسم اللعبة ──
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(children: [
                  const Text('لعبة الأسئلة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 6),
                  Text('اختبر معلوماتك في 10 مراحل',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 15)),
                  const SizedBox(height: 6),
                  Text('150 سؤالاً متنوعاً',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.65), fontSize: 13)),
                ]),
              ),

              const Spacer(flex: 2),

              // ── شريط تحميل متحرك ──
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
              Text('جارٍ التحميل...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 12)),
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

  @override
  void initState() {
    super.initState();
    _headerCtrl.forward();
    Future.delayed(const Duration(milliseconds: 300), _cardsCtrl.forward);
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _cardsCtrl.dispose();
    super.dispose();
  }

  // ── helpers ──
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
                // ─── شريط علوي ───
                _buildTopBar(),
                const SizedBox(height: 20),

                // ─── بطاقة النقاط ───
                SlideTransition(
                  position: _headerSlide,
                  child: _buildScoreCard(),
                ),
                const SizedBox(height: 22),

                // ─── إحصاء سريع ───
                SlideTransition(
                  position: _headerSlide,
                  child: _buildQuickStats(),
                ),
                const SizedBox(height: 26),

                // ─── أزرار الإجراءات ───
                FadeTransition(
                  opacity: _cardsFade,
                  child: Column(children: [
                    _actionBtn(
                      icon: Icons.play_arrow_rounded,
                      title: 'ابدأ اللعبة',
                      subtitle:
                          'استكمل من المرحلة ${widget.gameState.currentLevel}',
                      gradient: AppColors.primaryGradient,
                      onTap: _startGame,
                    ),
                    const SizedBox(height: 14),
                    _actionBtn(
                      icon: Icons.grid_view_rounded,
                      title: 'اختيار المرحلة',
                      subtitle:
                          '${widget.gameState.unlockedLevels.length} مراحل مفتوحة من 10',
                      gradient: LinearGradient(colors: [
                        AppColors.secondaryDark,
                        AppColors.secondaryDark.withOpacity(0.7)
                      ]),
                      onTap: _openLevels,
                    ),
                    const SizedBox(height: 14),
                    _actionBtn(
                      icon: Icons.leaderboard_rounded,
                      title: 'لوحة التقدم',
                      subtitle: 'شاهد تقدمك في المراحل',
                      gradient: LinearGradient(colors: [
                        const Color(0xFFFF6D00),
                        const Color(0xFFFF9800)
                      ]),
                      onTap: _openProgress,
                    ),
                    const SizedBox(height: 14),
                    _actionBtn(
                      icon: Icons.privacy_tip_rounded,
                      title: 'سياسة الخصوصية',
                      subtitle: 'اقرأ سياسة حماية بياناتك',
                      gradient: LinearGradient(
                          colors: [Colors.grey.shade700, Colors.grey.shade900]),
                      onTap: _openPrivacy,
                    ),
                    const SizedBox(height: 18),

                    // أزرار صغيرة
                    Row(children: [
                      Expanded(
                          child: _smallBtn(Icons.refresh_rounded, 'إعادة ضبط',
                              AppColors.wrongColor, _confirmReset)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _smallBtn(Icons.info_outline_rounded,
                              'عن اللعبة', AppColors.primaryDark, _showAbout)),
                    ]),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── شريط علوي ──
  Widget _buildTopBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('🧠 لعبة الأسئلة',
              style: TextStyle(
                  color: _txt, fontSize: 20, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: widget.gameState.toggleDarkMode,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: _card, borderRadius: BorderRadius.circular(12)),
              child: Icon(
                  _isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: AppColors.primaryDark,
                  size: 20),
            ),
          ),
        ],
      );

  // ── بطاقة النقاط ──
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
            Text('إجمالي نقاطك',
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
          Divider(color: Colors.white.withOpacity(0.25), height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _scoreStat(
                '📊', 'المرحلة الحالية', '${widget.gameState.currentLevel}'),
            _scoreStat('🔓', 'مراحل مفتوحة',
                '${widget.gameState.unlockedLevels.length}/10'),
            _scoreStat('✅', 'مراحل مكتملة',
                '${widget.gameState.completedLevels.length}/10'),
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

  // ── إحصاء سريع ──
  Widget _buildQuickStats() {
    final total = QuizData.levels.fold(0, (s, l) => s + l.questions.length);
    final answered = widget.gameState.completedLevels.fold(0, (s, id) {
      final lvl = QuizData.levels
          .firstWhere((l) => l.id == id, orElse: () => QuizData.levels.first);
      return s + lvl.questions.length;
    });
    final pct = total == 0 ? 0.0 : answered / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('التقدم الكلي',
              style: TextStyle(
                  color: _txt, fontWeight: FontWeight.w600, fontSize: 13)),
          Text('$answered / $total سؤال',
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
        Text('${(pct * 100).toStringAsFixed(0)}% مكتمل',
            style: TextStyle(color: _sub, fontSize: 11)),
      ]),
    );
  }

  // ── زر إجراء رئيسي ──
  Widget _actionBtn({
    required IconData icon,
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) =>
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
              child: Icon(icon, color: Colors.white, size: 24),
            ),
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

  // ── زر صغير ──
  Widget _smallBtn(
          IconData ic, String label, Color color, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(ic, color: color, size: 17),
            const SizedBox(width: 7),
            Text(label,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w600, fontSize: 13)),
          ]),
        ),
      );

  // ── تنقل ──
  void _startGame() {
    final lvl = QuizData.levels.firstWhere(
        (l) => l.id == widget.gameState.currentLevel,
        orElse: () => QuizData.levels.first);
    Navigator.push(
        context, _route(QuizScreen(level: lvl, gameState: widget.gameState)));
  }

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
                .animate(
                    CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
            child: child),
        transitionDuration: const Duration(milliseconds: 350),
      );

  void _confirmReset() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('إعادة ضبط اللعبة ⚠️'),
          content:
              const Text('سيتم حذف جميع نقاطك ومراحلك المفتوحة. هل أنت متأكد؟'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.wrongColor),
              onPressed: () {
                widget.gameState.resetGame();
                Navigator.pop(context);
              },
              child: const Text('نعم، إعادة ضبط',
                  style: TextStyle(color: Colors.white)),
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
            const Text('لعبة الأسئلة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('الإصدار 2.0.0', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: const Text(
                  '10 مراحل • 150 سؤالاً متنوعاً\nعلوم • جغرافيا • تاريخ • تقنية\nرياضة • طبيعة • فضاء • فن • طب • تحدي',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, height: 1.6)),
            ),
          ]),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('حسناً'))
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
      appBar: _appBar('اختر مرحلتك', isDark),
      body: AnimatedBuilder(
        animation: gameState,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.all(14),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: QuizData.levels.length,
            itemBuilder: (ctx, i) {
              final lvl = QuizData.levels[i];
              final unlocked = gameState.isLevelUnlocked(lvl.id);
              final completed = gameState.isLevelCompleted(lvl.id);
              final isCurrent = gameState.currentLevel == lvl.id;

              return GestureDetector(
                onTap: unlocked
                    ? () {
                        gameState.setCurrentLevel(lvl.id);
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
                            colors: [lvl.color, lvl.color.withOpacity(0.65)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)
                        : LinearGradient(colors: [
                            Colors.grey.shade800,
                            Colors.grey.shade700
                          ]),
                    borderRadius: BorderRadius.circular(22),
                    border: isCurrent
                        ? Border.all(color: AppColors.goldColor, width: 2.5)
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
                      // ── أيقونة + تراكب ──
                      Stack(alignment: Alignment.center, children: [
                        Text(lvl.icon, style: const TextStyle(fontSize: 38)),
                        if (!unlocked)
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.black.withOpacity(0.45),
                            child: const Icon(Icons.lock_rounded,
                                color: Colors.white70, size: 26),
                          ),
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
                                    color: Colors.white, size: 12),
                              )),
                      ]),
                      const SizedBox(height: 8),
                      Text('المرحلة ${lvl.id}',
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
                      // ── شارات ──
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isCurrent)
                              _chip(
                                  '▶ حالية', AppColors.goldColor, Colors.black),
                            if (completed)
                              _chip('✓ مكتملة', AppColors.correctColor,
                                  Colors.white),
                            if (!unlocked)
                              _chip('${lvl.requiredScore} نقطة', Colors.white24,
                                  Colors.white70),
                          ]),
                      const SizedBox(height: 4),
                      Text('${lvl.questions.length} سؤال',
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
      content: Text('تحتاج ${lvl.requiredScore} نقطة لفتح هذه المرحلة 🔒'),
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

    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar('لوحة التقدم', isDark),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── ملخص عام ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem(
                      '🏆', '${gameState.totalScore}', 'إجمالي النقاط'),
                  _summaryItem('✅', '${gameState.completedLevels.length}',
                      'مراحل مكتملة'),
                  _summaryItem('🔓', '${gameState.unlockedLevels.length}',
                      'مراحل مفتوحة'),
                ]),
          ),
          const SizedBox(height: 20),

          Text('تفاصيل المراحل',
              style: TextStyle(
                  color: txt, fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // ── قائمة المراحل ──
          ...QuizData.levels.map((lvl) {
            final unlocked = gameState.isLevelUnlocked(lvl.id);
            final completed = gameState.isLevelCompleted(lvl.id);
            final progress = completed ? 1.0 : (unlocked ? 0.0 : 0.0);

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
                          : Colors.grey.withOpacity(0.2),
                ),
              ),
              child: Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        (unlocked ? lvl.color : Colors.grey).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(unlocked ? lvl.icon : '🔒',
                          style: const TextStyle(fontSize: 22))),
                ),
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
                        Text('${lvl.requiredScore} نقطة',
                            style: TextStyle(color: sub, fontSize: 10)),
                    ]),
                    const SizedBox(height: 4),
                    Text('${lvl.questions.length} سؤال',
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
                  ],
                )),
              ]),
            );
          }),

          const SizedBox(height: 8),
          // ── نصيحة ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.goldColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.goldColor.withOpacity(0.3)),
            ),
            child: Row(children: [
              const Text('💡', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                      'اجمع النقاط لفتح مراحل جديدة.\nكل إجابة صحيحة = 10 نقاط',
                      style: TextStyle(color: sub, fontSize: 12, height: 1.5))),
            ]),
          ),
        ],
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
    _startQuestion();
  }

  void _startQuestion() {
    _qCtrl.forward(from: 0);
    _timerCtrl.forward(from: 0);
  }

  void _onTimerDone(AnimationStatus s) {
    if (s == AnimationStatus.completed && !_answered) {
      _selectAnswer(-1); // انتهى الوقت
    }
  }

  @override
  void dispose() {
    _qCtrl.dispose();
    _resCtrl.dispose();
    _timerCtrl.dispose();
    super.dispose();
  }

  QuizQuestion get _q => widget.level.questions[_qIdx];
  int get _total => widget.level.questions.length;

  void _selectAnswer(int idx) {
    if (_answered) return;
    _timerCtrl.stop();
    setState(() {
      _selected = idx;
      _answered = true;
    });
    _resCtrl.forward(from: 0);

    if (idx == _q.correctIndex) {
      widget.gameState.addScore(10);
      _levelScore += 10;
    }

    Future.delayed(const Duration(milliseconds: 1900), () {
      if (!mounted) return;
      if (_qIdx < _total - 1) {
        _nextQuestion();
      } else {
        _showComplete();
      }
    });
  }

  void _nextQuestion() {
    _qCtrl.reset();
    _resCtrl.reset();
    _timerCtrl.reset();
    setState(() {
      _qIdx++;
      _selected = null;
      _answered = false;
    });
    _startQuestion();
  }

  void _showComplete() {
    widget.gameState.markLevelCompleted(widget.level.id);
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

  void _restart() => setState(() {
        _qIdx = 0;
        _levelScore = 0;
        _selected = null;
        _answered = false;
        _startQuestion();
      });

  void _goNext() {
    final nextId = widget.level.id + 1;
    Navigator.pop(context); // أغلق الحوار
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

  // ── helpers ──
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Column(children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildProgressAndTimer(),
            const SizedBox(height: 16),
            Expanded(
              child: SlideTransition(
                position: _qSlide,
                child: FadeTransition(
                    opacity: _qFade, child: _buildQuestionCard()),
              ),
            ),
            const SizedBox(height: 12),
            ..._buildOptions(),
          ]),
        ),
      ),
    );
  }

  // ── هيدر ──
  Widget _buildHeader() => Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: widget.level.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.arrow_back_ios_rounded,
                color: widget.level.color, size: 18),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.level.title,
              style: TextStyle(
                  color: _txt, fontSize: 16, fontWeight: FontWeight.bold)),
          Text('السؤال ${_qIdx + 1} من $_total',
              style: TextStyle(color: widget.level.color, fontSize: 12)),
        ])),
        // نقاط المرحلة الحالية
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
          ]),
        ),
      ]);

  // ── شريط التقدم + عداد الوقت ──
  Widget _buildProgressAndTimer() => Column(children: [
        // تقدم الأسئلة
        Row(children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (_qIdx + 1) / _total,
                minHeight: 6,
                backgroundColor: widget.level.color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation(widget.level.color),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text('${((_qIdx + 1) / _total * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                  color: widget.level.color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),
        // عداد الوقت (25 ثانية)
        AnimatedBuilder(
          animation: _timerCtrl,
          builder: (_, __) {
            final remaining = ((1 - _timerCtrl.value) * 25).ceil();
            final isWarning = remaining <= 8;
            return Row(children: [
              Icon(Icons.timer_rounded,
                  size: 14, color: isWarning ? AppColors.wrongColor : _sub),
              const SizedBox(width: 4),
              Text('$remaining ثانية',
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
                      : AppColors.secondaryDark),
                ),
              )),
            ]);
          },
        ),
      ]);

  // ── بطاقة السؤال ──
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
          ],
        ),
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

          // ── شرح الإجابة ──
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
                          : AppColors.wrongColor),
                ),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(_selected == _q.correctIndex ? '✅' : '❌',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                      _selected == -1
                          ? 'انتهى الوقت! ⏰'
                          : _selected == _q.correctIndex
                              ? 'إجابة صحيحة! +10 نقاط'
                              : 'إجابة خاطئة!',
                      style: TextStyle(
                          color: _selected == _q.correctIndex
                              ? AppColors.correctColor
                              : AppColors.wrongColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Text(_q.explanation,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _sub, fontSize: 12, height: 1.4)),
                ]),
              ),
            ),
          ],
        ]),
      );

  // ── أزرار الخيارات ──
  List<Widget> _buildOptions() {
    return List.generate(_q.options.length, (i) {
      final isSelected = _selected == i;
      final isCorrect = i == _q.correctIndex;
      final isWrong = isSelected && !isCorrect;

      Color borderColor;
      Color bgColor;
      if (!_answered) {
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
          onTap: () => _selectAnswer(i),
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
                  : null,
            ),
            child: Row(children: [
              // حرف الخيار A/B/C/D
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: (_answered && isCorrect)
                      ? AppColors.correctColor
                      : (_answered && isWrong)
                          ? AppColors.wrongColor
                          : AppColors.primaryDark.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Text(
                  String.fromCharCode(0x0041 + i),
                  style: TextStyle(
                      color: (_answered && (isCorrect || isWrong))
                          ? Colors.white
                          : AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                )),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(_q.options[i],
                      style: TextStyle(
                          color: _txt,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal))),
              if (_answered && isCorrect)
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.correctColor, size: 20),
              if (_answered && isWrong)
                const Icon(Icons.cancel_rounded,
                    color: AppColors.wrongColor, size: 20),
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

  const LevelCompleteDialog({
    super.key,
    required this.levelScore,
    required this.levelTitle,
    required this.totalScore,
    required this.levelId,
    required this.gameState,
    required this.onRetry,
    required this.onHome,
    required this.onNext,
  });

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
          Text(isPerfect ? 'أداء مثالي!' : 'أحسنت!',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('انتهيت من $levelTitle',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9), fontSize: 13)),
          const SizedBox(height: 18),

          // ── نقاط + شريط ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _stat('نقاط المرحلة', '$levelScore'),
                _stat('الإجمالي', '$totalScore'),
                _stat('الدقة', '${(pct * 100).toStringAsFixed(0)}%'),
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 7,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 18),

          // ── أزرار ──
          Row(children: [
            Expanded(
                child: _btn(Icons.replay_rounded, 'إعادة',
                    outlined: true, onTap: onRetry)),
            const SizedBox(width: 8),
            Expanded(
                child: _btn(Icons.home_rounded, 'الرئيسية',
                    outlined: true, onTap: onHome)),
            const SizedBox(width: 8),
            Expanded(
                child: _btn(Icons.arrow_forward_rounded, 'التالية',
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
            border: outlined ? Border.all(color: Colors.white54) : null,
          ),
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
          'سياسة الخصوصية', Theme.of(context).brightness == Brightness.dark),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── رأس ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(22)),
            child: const Column(children: [
              Text('🔒', style: TextStyle(fontSize: 44)),
              SizedBox(height: 8),
              Text('سياسة الخصوصية',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('آخر تحديث: يناير 2026',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 22),

          _section('1. المقدمة',
              'مرحباً بكم في تطبيق "لعبة الأسئلة". نحن ملتزمون بحماية خصوصيتكم. توضح هذه السياسة كيفية جمعنا للمعلومات واستخدامها وحمايتها.'),

          _section(
              '2. البيانات التي نحفظها',
              'التطبيق يحفظ البيانات التالية محلياً على جهازك فقط:\n\n'
                  '• إجمالي النقاط المكتسبة\n'
                  '• رقم المرحلة الحالية\n'
                  '• قائمة المراحل المفتوحة والمكتملة\n'
                  '• تفضيل الوضع الداكن أو الفاتح\n\n'
                  'لا نجمع أي بيانات شخصية كالاسم أو البريد الإلكتروني أو الموقع الجغرافي.'),

          _section(
              '3. استخدام البيانات',
              'البيانات المحفوظة تُستخدم حصرياً لـ:\n\n'
                  '• حفظ تقدمك في اللعبة وعدم فقده\n'
                  '• عرض النقاط والمراحل المفتوحة\n'
                  '• تذكّر تفضيلات العرض\n\n'
                  'لا تُشارك هذه البيانات مع أي طرف ثالث إطلاقاً.'),

          _section(
              '4. أمان البيانات',
              'جميع البيانات محفوظة على جهازك فقط باستخدام SharedPreferences. '
                  'لا يُرسَل أي شيء إلى خوادم خارجية. '
                  'يمكنك حذف جميع بياناتك في أي وقت عبر "إعادة ضبط" في الشاشة الرئيسية.'),

          _section(
              '5. حقوقك',
              'لديك الحق الكامل في:\n\n'
                  '• الاطلاع على بياناتك المحفوظة\n'
                  '• حذفها في أي وقت تشاء\n'
                  '• إيقاف استخدام التطبيق'),

          _section(
              '6. الأطفال',
              'تطبيقنا مناسب لجميع الأعمار. لا نجمع أي بيانات خاصة بالأطفال '
                  'دون موافقة ولي الأمر، إذ لا نجمع بيانات شخصية أصلاً.'),

          _section(
              '7. التعديلات',
              'قد نحدّث هذه السياسة من وقت لآخر. سيتم إخطارك بأي تغييرات '
                  'جوهرية عند تحديث التطبيق.'),

          _section(
              '8. تواصل معنا',
              'لأي استفسار حول سياسة الخصوصية:\n\n'
                  '📧 support@quizgame.app\n'
                  '🌐 www.quizgame.app'),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: AppColors.primaryDark.withOpacity(0.50))),
            child: const Text(
                'باستخدامك للتطبيق فأنت توافق على هذه السياسة. '
                'إن لم تكن موافقاً يرجى التوقف عن الاستخدام.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.6)),
          ),
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
