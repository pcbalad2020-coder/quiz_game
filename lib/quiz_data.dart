import 'package:flutter/material.dart';

/// نموذج السؤال الواحد
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

/// نموذج المرحلة
class QuizLevel {
  final int id;
  final String title;
  final String icon;
  final List<QuizQuestion> questions;
  final Color color;
  final int requiredScore;

  const QuizLevel({
    required this.id,
    required this.title,
    required this.icon,
    required this.questions,
    required this.color,
    required this.requiredScore,
  });
}

// ============================================================
// 🗄️ مستودع بيانات الأسئلة الكاملة (القديمة + الجديدة)
// ============================================================
class QuizData {
  static const List<QuizLevel> levels = [
    // ══════════════════════════════════════════════
    // 🔬 المرحلة 1 — العلوم العامة (29 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 1,
      title: 'العلوم العامة',
      icon: '🔬',
      color: Color(0xFF6C63FF),
      requiredScore: 0,
      questions: [
        QuizQuestion(
          question: 'ما هو أكبر كوكب في المجموعة الشمسية؟',
          options: ['الأرض', 'المريخ', 'المشتري', 'زحل'],
          correctIndex: 2,
          explanation: 'المشتري هو أكبر كوكب، يبلغ قطره 11 ضعف قطر الأرض.',
        ),
        QuizQuestion(
          question: 'كم عدد أضلاع المثلث؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 1,
          explanation: 'المثلث شكل هندسي له 3 أضلاع و3 زوايا.',
        ),
        QuizQuestion(
          question: 'ما الغاز الأكثر وفرة في الغلاف الجوي للأرض؟',
          options: [
            'الأكسجين',
            'ثاني أكسيد الكربون',
            'النيتروجين',
            'الهيدروجين'
          ],
          correctIndex: 2,
          explanation: 'النيتروجين يشكّل نحو 78% من الغلاف الجوي.',
        ),
        QuizQuestion(
          question: 'ما هو أصغر عنصر في الجدول الدوري؟',
          options: ['الهيليوم', 'الهيدروجين', 'الليثيوم', 'الأكسجين'],
          correctIndex: 1,
          explanation: 'الهيدروجين (H) رقمه الذري 1 وهو أخف العناصر.',
        ),
        QuizQuestion(
          question: 'ما هي سرعة الضوء تقريباً؟',
          options: [
            '300,000 كم/ث',
            '150,000 كم/ث',
            '500,000 كم/ث',
            '100,000 كم/ث'
          ],
          correctIndex: 0,
          explanation: 'سرعة الضوء 299,792 كيلومتراً في الثانية تقريباً.',
        ),
        QuizQuestion(
          question: 'ما الوحدة المستخدمة لقياس الطاقة؟',
          options: ['واط', 'جول', 'نيوتن', 'باسكال'],
          correctIndex: 1,
          explanation: 'الجول (J) هو الوحدة الأساسية للطاقة في نظام SI.',
        ),
        QuizQuestion(
          question: 'ما اسم العملية التي تحوّل الطاقة الشمسية لغذاء في النبات؟',
          options: ['التنفس الخلوي', 'البناء الضوئي', 'التخمر', 'الهضم'],
          correctIndex: 1,
          explanation:
              'البناء الضوئي يحوّل ثاني أكسيد الكربون والماء والضوء إلى غلوكوز.',
        ),
        QuizQuestion(
          question: 'كم تبلغ درجة حرارة الغليان للماء عند مستوى سطح البحر؟',
          options: ['90°C', '95°C', '100°C', '110°C'],
          correctIndex: 2,
          explanation: 'الماء يغلي عند 100 درجة مئوية على مستوى سطح البحر.',
        ),
        QuizQuestion(
          question: 'ما هو الرمز الكيميائي للذهب؟',
          options: ['Go', 'Gd', 'Au', 'Ag'],
          correctIndex: 2,
          explanation: 'رمز الذهب Au مشتق من اللاتينية "Aurum".',
        ),
        QuizQuestion(
          question: 'ما عدد الأسنان الدائمة لدى الإنسان البالغ؟',
          options: ['28', '30', '32', '34'],
          correctIndex: 2,
          explanation: 'الإنسان البالغ لديه 32 سناً دائماً شاملة ضرس العقل.',
        ),
        QuizQuestion(
          question: 'ما هو أصغر كوكب في المجموعة الشمسية؟',
          options: ['المريخ', 'زحل', 'عطارد', 'الزهرة'],
          correctIndex: 2,
          explanation: 'عطارد هو أصغر الكواكب الثمانية في مجموعتنا الشمسية.',
        ),
        QuizQuestion(
          question: 'ما اسم القوة التي تجذب الأجسام نحو مركز الأرض؟',
          options: ['المغناطيسية', 'الجاذبية', 'الكهرباء', 'الاحتكاك'],
          correctIndex: 1,
          explanation: 'الجاذبية الأرضية هي التي تجذب الأجسام نحو مركز الأرض.',
        ),
        QuizQuestion(
          question: 'ما عدد ألوان قوس قزح؟',
          options: ['5', '6', '7', '8'],
          correctIndex: 2,
          explanation:
              'قوس قزح يحتوي على 7 ألوان: أحمر، برتقالي، أصفر، أخضر، أزرق، نيلي، بنفسجي.',
        ),
        QuizQuestion(
          question: 'أي من الآتي لا يُعدّ حالة من حالات المادة؟',
          options: ['الصلبة', 'السائلة', 'الغازية', 'الضوئية'],
          correctIndex: 3,
          explanation:
              'الحالات الأساسية للمادة هي: الصلبة والسائلة والغازية والبلازما.',
        ),
        QuizQuestion(
          question: 'ما اسم العالم الذي اكتشف قانون الجاذبية؟',
          options: ['أينشتاين', 'غاليليو', 'نيوتن', 'كوبرنيكوس'],
          correctIndex: 2,
          explanation:
              'إسحاق نيوتن اكتشف قانون الجاذبية العامة في القرن السابع عشر.',
        ),
        QuizQuestion(
          question: 'ما اسم الجهاز المستخدم لقياس درجة الحرارة؟',
          options: ['البارومتر', 'الترمومتر', 'الأنيمومتر', 'الهيدرومتر'],
          correctIndex: 1,
          explanation: 'الترمومتر هو الجهاز المخصص لقياس درجات الحرارة.',
        ),
        QuizQuestion(
          question: 'ما هو الرمز الكيميائي للماء؟',
          options: ['CO2', 'H2O', 'O2', 'NaCl'],
          correctIndex: 1,
          explanation: 'جزيء الماء يتكون من ذرتي هيدروجين وذرة أكسجين H2O.',
        ),
        QuizQuestion(
          question: 'ما اسم العملية التي يتحول فيها السائل إلى غاز؟',
          options: ['التكاثف', 'التبخر', 'الانصهار', 'التجمد'],
          correctIndex: 1,
          explanation: 'التبخر هو تحوّل المادة من الحالة السائلة إلى الغازية.',
        ),
        QuizQuestion(
          question: 'من مخترع المصباح الكهربائي العملي؟',
          options: ['نيكولا تسلا', 'توماس إديسون', 'ألكسندر بيل', 'جيمس واط'],
          correctIndex: 1,
          explanation:
              'طوّر توماس إديسون أول مصباح كهربائي عملي طويل الأمد عام 1879.',
        ),
        QuizQuestion(
          question: 'ما أقرب نجم إلى الأرض؟',
          options: [
            'الشمس',
            'بروكسيما القنطور',
            'الشعرى اليمانية',
            'النجم القطبي'
          ],
          correctIndex: 0,
          explanation: 'الشمس نجم، وهي أقرب النجوم إلى الأرض.',
        ),
        QuizQuestion(
          question: 'ما الغاز الذي تمتصه النباتات في عملية البناء الضوئي؟',
          options: ['الأكسجين', 'النيتروجين', 'ثاني أكسيد الكربون', 'الهيليوم'],
          correctIndex: 2,
          explanation: 'تمتص النباتات ثاني أكسيد الكربون وتطلق الأكسجين.',
        ),
        QuizQuestion(
          question: 'ما وحدة قياس القوة في النظام الدولي؟',
          options: ['جول', 'نيوتن', 'واط', 'فولت'],
          correctIndex: 1,
          explanation: 'النيوتن (N) هو وحدة قياس القوة.',
        ),
        QuizQuestion(
          question: 'ما المعدن الذي يكون سائلاً في درجة حرارة الغرفة؟',
          options: ['الحديد', 'الزئبق', 'النحاس', 'الألمنيوم'],
          correctIndex: 1,
          explanation:
              'الزئبق (Hg) المعدن الوحيد السائل في الظروف العادية تقريباً.',
        ),
        QuizQuestion(
          question: 'كم عدد الكواكب الصخرية في المجموعة الشمسية؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation: 'عطارد والزهرة والأرض والمريخ.',
        ),
        QuizQuestion(
          question: 'ما الرمز الكيميائي للصوديوم؟',
          options: ['So', 'Na', 'Sd', 'N'],
          correctIndex: 1,
          explanation: 'رمز الصوديوم Na من الاسم اللاتيني Natrium.',
        ),
        QuizQuestion(
          question: 'في أي وسط ينتقل الصوت بأسرع شكل؟',
          options: ['الفراغ', 'الهواء', 'الماء', 'الفولاذ'],
          correctIndex: 3,
          explanation:
              'ينتقل الصوت في المواد الصلبة أسرع منه في السوائل والغازات، ولا ينتقل في الفراغ.',
        ),
        QuizQuestion(
          question: 'كم عدد أرجل الحشرة؟',
          options: ['4', '6', '8', '10'],
          correctIndex: 1,
          explanation: 'للحشرات ست أرجل.',
        ),
        QuizQuestion(
          question: 'ما العنصر الذي رمزه Fe؟',
          options: ['الفضة', 'الحديد', 'الفلور', 'الفرانسيوم'],
          correctIndex: 1,
          explanation: 'Fe من الاسم اللاتيني Ferrum أي الحديد.',
        ),
        QuizQuestion(
          question: 'ما اسم عملية فقدان النبات للماء على شكل بخار عبر أوراقه؟',
          options: ['النتح', 'التخمر', 'الانصهار', 'الترسيب'],
          correctIndex: 0,
          explanation: 'النتح هو تبخر الماء من الثغور في أوراق النبات.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🌍 المرحلة 2 — الجغرافيا (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 2,
      title: 'الجغرافيا',
      icon: '🌍',
      color: Color(0xFF26C6DA),
      requiredScore: 50,
      questions: [
        QuizQuestion(
          question: 'ما هي عاصمة المملكة العربية السعودية؟',
          options: ['جدة', 'مكة المكرمة', 'الرياض', 'الدمام'],
          correctIndex: 2,
          explanation: 'الرياض عاصمة المملكة العربية السعودية منذ توحيدها.',
        ),
        QuizQuestion(
          question: 'ما هو أطول نهر في العالم؟',
          options: [
            'نهر الأمازون',
            'نهر النيل',
            'نهر المسيسيبي',
            'نهر اليانغتسي'
          ],
          correctIndex: 1,
          explanation: 'نهر النيل أطول نهر بطول 6650 كيلومتراً.',
        ),
        QuizQuestion(
          question: 'في أي قارة تقع مصر؟',
          options: ['آسيا', 'أوروبا', 'أفريقيا', 'أمريكا الجنوبية'],
          correctIndex: 2,
          explanation:
              'مصر تقع في شمال أفريقيا مع امتداد صغير في آسيا (سيناء).',
        ),
        QuizQuestion(
          question: 'ما هي أكبر دولة في العالم مساحةً؟',
          options: ['الصين', 'الولايات المتحدة', 'كندا', 'روسيا'],
          correctIndex: 3,
          explanation: 'روسيا أكبر دولة بمساحة 17.1 مليون كيلومتر مربع.',
        ),
        QuizQuestion(
          question: 'ما هو المحيط الأكبر في العالم؟',
          options: ['الأطلسي', 'الهادئ', 'الهندي', 'المتجمد الشمالي'],
          correctIndex: 1,
          explanation: 'المحيط الهادئ يغطي نحو 165 مليون كيلومتر مربع.',
        ),
        QuizQuestion(
          question: 'ما عاصمة اليابان؟',
          options: ['أوساكا', 'كيوتو', 'طوكيو', 'هيروشيما'],
          correctIndex: 2,
          explanation: 'طوكيو عاصمة اليابان وأكبر مدنها.',
        ),
        QuizQuestion(
          question: 'أين تقع قناة السويس؟',
          options: ['المغرب', 'تونس', 'مصر', 'ليبيا'],
          correctIndex: 2,
          explanation:
              'قناة السويس تقع في مصر وتربط البحر الأبيض المتوسط بالبحر الأحمر.',
        ),
        QuizQuestion(
          question: 'ما هي أصغر دولة في العالم؟',
          options: ['موناكو', 'سان مارينو', 'الفاتيكان', 'ليختنشتاين'],
          correctIndex: 2,
          explanation: 'دولة الفاتيكان أصغر دولة بمساحة 0.44 كيلومتر مربع.',
        ),
        QuizQuestion(
          question: 'ما عاصمة البرازيل؟',
          options: ['ريو دي جانيرو', 'ساو باولو', 'برازيليا', 'سالفادور'],
          correctIndex: 2,
          explanation: 'برازيليا هي العاصمة الرسمية للبرازيل منذ 1960.',
        ),
        QuizQuestion(
          question: 'كم عدد قارات العالم؟',
          options: ['5', '6', '7', '8'],
          correctIndex: 2,
          explanation:
              'قارات العالم السبع: آسيا، أفريقيا، أمريكا الشمالية، أمريكا الجنوبية، أنتاركتيكا، أوروبا، أوقيانوسيا.',
        ),
        QuizQuestion(
          question: 'أين يقع برج إيفل؟',
          options: ['لندن', 'برلين', 'باريس', 'روما'],
          correctIndex: 2,
          explanation: 'برج إيفل في باريس، فرنسا، بُني عام 1889.',
        ),
        QuizQuestion(
          question: 'ما هو أعمق بحيرة في العالم؟',
          options: [
            'بحيرة فيكتوريا',
            'بحيرة بايكال',
            'بحيرة تيتيكاكا',
            'بحيرة سوبيريور'
          ],
          correctIndex: 1,
          explanation: 'بحيرة بايكال في روسيا أعمق بحيرة بعمق 1642 متراً.',
        ),
        QuizQuestion(
          question: 'ما عاصمة أستراليا؟',
          options: ['سيدني', 'ملبورن', 'كانبيرا', 'بريسبان'],
          correctIndex: 2,
          explanation: 'كانبيرا عاصمة أستراليا، وليست سيدني كما يُشاع.',
        ),
        QuizQuestion(
          question: 'ما هو الجبل الأعلى في العالم؟',
          options: ['K2', 'كنشنجونغا', 'إيفرست', 'لوتسه'],
          correctIndex: 2,
          explanation: 'جبل إيفرست ارتفاعه 8848 متراً فوق مستوى البحر.',
        ),
        QuizQuestion(
          question: 'أي دولة تمتلك أكبر عدد من السكان؟',
          options: ['الهند', 'الصين', 'الولايات المتحدة', 'إندونيسيا'],
          correctIndex: 0,
          explanation:
              'الهند تجاوزت الصين لتصبح أكثر دول العالم سكاناً في 2023.',
        ),
        QuizQuestion(
          question: 'ما هي عاصمة فرنسا؟',
          options: ['ليون', 'مرسيليا', 'باريس', 'نيس'],
          correctIndex: 2,
          explanation: 'باريس هي عاصمة فرنسا وأكبر مدنها.',
        ),
        QuizQuestion(
          question: 'أي دولة تُعرف تاريخياً بأنها "أرض الفراعنة"؟',
          options: ['السودان', 'مصر', 'ليبيا', 'الأردن'],
          correctIndex: 1,
          explanation: 'مصر موطن الحضارة الفرعونية القديمة على ضفاف النيل.',
        ),
        QuizQuestion(
          question: 'ما هي أصغر قارة من حيث المساحة؟',
          options: ['أوروبا', 'أنتاركتيكا', 'أوقيانوسيا', 'أمريكا الجنوبية'],
          correctIndex: 2,
          explanation: 'أوقيانوسيا (أستراليا وما حولها) أصغر القارات مساحة.',
        ),
        QuizQuestion(
          question: 'في أي قارة يقع نهر الأمازون؟',
          options: ['أفريقيا', 'آسيا', 'أمريكا الجنوبية', 'أمريكا الشمالية'],
          correctIndex: 2,
          explanation: 'نهر الأمازون يجري في قارة أمريكا الجنوبية.',
        ),
        QuizQuestion(
          question: 'أين تقع الصحراء الكبرى؟',
          options: ['جنوب أفريقيا', 'شمال أفريقيا', 'غرب آسيا', 'أستراليا'],
          correctIndex: 1,
          explanation:
              'الصحراء الكبرى تمتد عبر شمال أفريقيا وهي أكبر صحراء حارة في العالم.',
        ),
        QuizQuestion(
          question: 'ما عاصمة تركيا؟',
          options: ['إسطنبول', 'أنقرة', 'إزمير', 'بورصة'],
          correctIndex: 1,
          explanation: 'أنقرة هي العاصمة، وإسطنبول أكبر المدن.',
        ),
        QuizQuestion(
          question: 'ما عاصمة العراق؟',
          options: ['البصرة', 'الموصل', 'بغداد', 'أربيل'],
          correctIndex: 2,
          explanation: 'بغداد عاصمة العراق وأكبر مدنه.',
        ),
        QuizQuestion(
          question: 'إلى أين يصب نهرا دجلة والفرات في النهاية؟',
          options: [
            'البحر المتوسط',
            'الخليج العربي',
            'البحر الأحمر',
            'بحر قزوين'
          ],
          correctIndex: 1,
          explanation: 'يلتقيان في شط العرب ويصبان في الخليج العربي.',
        ),
        QuizQuestion(
          question: 'ما أكبر بحيرة عذبة في العالم من حيث المساحة؟',
          options: ['فيكتوريا', 'سوبيريور', 'بايكال', 'هورون'],
          correctIndex: 1,
          explanation: 'بحيرة سوبيريور في أمريكا الشمالية هي الأكبر مساحةً.',
        ),
        QuizQuestion(
          question: 'ما عاصمة كندا؟',
          options: ['تورنتو', 'أوتاوا', 'فانكوفر', 'مونتريال'],
          correctIndex: 1,
          explanation: 'أوتاوا هي العاصمة الاتحادية لكندا.',
        ),
        QuizQuestion(
          question: 'ما أكبر جزيرة في العالم؟',
          options: ['غرينلاند', 'مدغشقر', 'بورنيو', 'أيسلندا'],
          correctIndex: 0,
          explanation: 'غرينلاند أكبر جزيرة (من غير القارات).',
        ),
        QuizQuestion(
          question: 'ما عاصمة المغرب؟',
          options: ['الدار البيضاء', 'الرباط', 'مراكش', 'فاس'],
          correctIndex: 1,
          explanation: 'الرباط هي العاصمة، والدار البيضاء أكبر المدن.',
        ),
        QuizQuestion(
          question: 'ما أخفض نقطة على سطح اليابسة؟',
          options: ['البحر الميت', 'بحيرة فيكتوريا', 'وادي الموت', 'بحر قزوين'],
          correctIndex: 0,
          explanation:
              'شاطئ البحر الميت أخفض نقطة، نحو 430 متراً تحت مستوى سطح البحر.',
        ),
        QuizQuestion(
          question: 'أي مضيق يفصل بين أوروبا وأفريقيا؟',
          options: ['باب المندب', 'جبل طارق', 'هرمز', 'البسفور'],
          correctIndex: 1,
          explanation: 'مضيق جبل طارق يفصل إسبانيا عن المغرب.',
        ),
        QuizQuestion(
          question: 'أي من الدول التالية لا تطل على أي بحر أو محيط؟',
          options: ['عُمان', 'النمسا', 'البرتغال', 'اليونان'],
          correctIndex: 1,
          explanation: 'النمسا دولة حبيسة في وسط أوروبا.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 📜 المرحلة 3 — التاريخ (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 3,
      title: 'التاريخ',
      icon: '📜',
      color: Color(0xFFFF7043),
      requiredScore: 100,
      questions: [
        QuizQuestion(
          question: 'في أي عام بدأت الحرب العالمية الأولى؟',
          options: ['1912', '1914', '1916', '1918'],
          correctIndex: 1,
          explanation: 'اندلعت الحرب العالمية الأولى في أغسطس 1914.',
        ),
        QuizQuestion(
          question: 'من بنى الأهرامات؟',
          options: ['الرومان', 'الإغريق', 'المصريون القدماء', 'البابليون'],
          correctIndex: 2,
          explanation: 'بناها المصريون القدماء منذ أكثر من 4500 عام.',
        ),
        QuizQuestion(
          question: 'متى تأسست منظمة الأمم المتحدة؟',
          options: ['1943', '1945', '1947', '1950'],
          correctIndex: 1,
          explanation: 'أُسست الأمم المتحدة في 24 أكتوبر 1945.',
        ),
        QuizQuestion(
          question: 'من اخترع المطبعة؟',
          options: [
            'توماس إديسون',
            'يوهانس غوتنبرغ',
            'نيكولا تسلا',
            'ألكسندر بيل'
          ],
          correctIndex: 1,
          explanation: 'اخترع غوتنبرغ المطبعة بالحروف المتحركة حوالي 1440.',
        ),
        QuizQuestion(
          question: 'أي حضارة بنت الكولوسيوم؟',
          options: ['الإغريقية', 'الفارسية', 'الرومانية', 'المصرية'],
          correctIndex: 2,
          explanation: 'بنى الرومان الكولوسيوم بين عامي 72 و80 ميلادية.',
        ),
        QuizQuestion(
          question: 'في أي عام انتهت الحرب العالمية الثانية؟',
          options: ['1943', '1944', '1945', '1946'],
          correctIndex: 2,
          explanation:
              'انتهت الحرب العالمية الثانية عام 1945 باستسلام ألمانيا واليابان.',
        ),
        QuizQuestion(
          question: 'من كان أول رئيس للولايات المتحدة الأمريكية؟',
          options: [
            'أبراهام لينكولن',
            'توماس جيفرسون',
            'جورج واشنطن',
            'بنيامين فرانكلين'
          ],
          correctIndex: 2,
          explanation: 'جورج واشنطن تولى الرئاسة عام 1789.',
        ),
        QuizQuestion(
          question: 'أين وُلد النبي محمد ﷺ؟',
          options: ['المدينة المنورة', 'الطائف', 'مكة المكرمة', 'جدة'],
          correctIndex: 2,
          explanation: 'وُلد النبي محمد ﷺ في مكة المكرمة عام 570 ميلادي.',
        ),
        QuizQuestion(
          question:
              'ما اسم الإمبراطورية التي حكمت مساحات واسعة من العالم في القرن التاسع عشر؟',
          options: [
            'الإمبراطورية الرومانية',
            'الإمبراطورية البريطانية',
            'الإمبراطورية المغولية',
            'الإمبراطورية العثمانية'
          ],
          correctIndex: 1,
          explanation:
              'بلغت الإمبراطورية البريطانية ذروتها وشملت ربع مساحة الأرض.',
        ),
        QuizQuestion(
          question: 'متى سقطت القسطنطينية على يد العثمانيين؟',
          options: ['1353', '1453', '1553', '1653'],
          correctIndex: 1,
          explanation: 'فتح السلطان محمد الثاني القسطنطينية عام 1453.',
        ),
        QuizQuestion(
          question: 'من اكتشف أمريكا عام 1492؟',
          options: [
            'فاسكو دي غاما',
            'أمريكو فسبوتشي',
            'كريستوفر كولومبوس',
            'فرنسيس دريك'
          ],
          correctIndex: 2,
          explanation: 'وصل كولومبوس إلى أمريكا في 12 أكتوبر 1492.',
        ),
        QuizQuestion(
          question: 'ما اسم أول إنسان يمشي على القمر؟',
          options: [
            'يوري غاغارين',
            'نيل أرمسترونغ',
            'بوز ألدرين',
            'مايكل كولينز'
          ],
          correctIndex: 1,
          explanation:
              'نيل أرمسترونغ أول إنسان يمشي على القمر في 20 يوليو 1969.',
        ),
        QuizQuestion(
          question: 'في أي عام اندلعت الثورة الفرنسية؟',
          options: ['1779', '1789', '1799', '1809'],
          correctIndex: 1,
          explanation: 'اندلعت الثورة الفرنسية عام 1789 وانتهت بسقوط الملكية.',
        ),
        QuizQuestion(
          question: 'ما اسم القائد الذي فتح الأندلس؟',
          options: [
            'عمرو بن العاص',
            'طارق بن زياد',
            'خالد بن الوليد',
            'موسى بن نصير'
          ],
          correctIndex: 1,
          explanation: 'عبر طارق بن زياد المضيق عام 711 م وفتح الأندلس.',
        ),
        QuizQuestion(
          question:
              'أي حضارة ابتكرت الكتابة المسمارية، من أولى الكتابات المعروفة؟',
          options: ['الفرعونية', 'الإغريقية', 'السومرية', 'الفينيقية'],
          correctIndex: 2,
          explanation:
              'ابتكر السومريون الكتابة المسمارية قبل نحو 5000 عام في بلاد ما بين النهرين.',
        ),
        QuizQuestion(
          question: 'من هو أول خليفة للمسلمين بعد وفاة النبي محمد ﷺ؟',
          options: [
            'عمر بن الخطاب',
            'أبو بكر الصديق',
            'عثمان بن عفان',
            'علي بن أبي طالب'
          ],
          correctIndex: 1,
          explanation:
              'تولى أبو بكر الصديق الخلافة بعد وفاة النبي محمد ﷺ عام 632 م.',
        ),
        QuizQuestion(
          question: 'في أي عام سقط جدار برلين؟',
          options: ['1979', '1989', '1991', '1999'],
          correctIndex: 1,
          explanation: 'سقط جدار برلين في نوفمبر 1989 مؤذناً بتوحيد ألمانيا.',
        ),
        QuizQuestion(
          question: 'من هو مكتشف مادة البنسلين المضادة للبكتيريا؟',
          options: ['لويس باستور', 'ألكسندر فلمنغ', 'روبرت كوخ', 'إدوارد جينر'],
          correctIndex: 1,
          explanation: 'اكتشف ألكسندر فلمنغ البنسلين عام 1928 مصادفةً.',
        ),
        QuizQuestion(
          question: 'في أي عام أُعلن استقلال الولايات المتحدة الأمريكية؟',
          options: ['1756', '1776', '1796', '1812'],
          correctIndex: 1,
          explanation: 'صدر إعلان الاستقلال الأمريكي في 4 يوليو 1776.',
        ),
        QuizQuestion(
          question: 'ما اسم السفينة الشهيرة التي غرقت عام 1912؟',
          options: ['تايتانيك', 'لوسيتانيا', 'بسمارك', 'كوين ماري'],
          correctIndex: 0,
          explanation:
              'غرقت السفينة تايتانيك في المحيط الأطلسي في رحلتها الأولى عام 1912.',
        ),
        QuizQuestion(
          question: 'من القائد الذي انتصر في معركة حطين؟',
          options: ['صلاح الدين الأيوبي', 'بيبرس', 'قطز', 'نور الدين زنكي'],
          correctIndex: 0,
          explanation: 'انتصر صلاح الدين في حطين عام 1187م.',
        ),
        QuizQuestion(
          question: 'في أي عام وقعت معركة عين جالوت؟',
          options: ['1258', '1260', '1291', '1187'],
          correctIndex: 1,
          explanation: 'هزم المماليك بقيادة قطز المغول عام 1260م.',
        ),
        QuizQuestion(
          question: 'من مؤسس مدينة بغداد؟',
          options: [
            'هارون الرشيد',
            'أبو جعفر المنصور',
            'المأمون',
            'معاوية بن أبي سفيان'
          ],
          correctIndex: 1,
          explanation: 'أسسها الخليفة العباسي أبو جعفر المنصور عام 762م.',
        ),
        QuizQuestion(
          question: 'في أي معركة هُزم نابليون هزيمته الأخيرة عام 1815؟',
          options: ['واترلو', 'أوسترليتز', 'ليبزيغ', 'طرف الغار'],
          correctIndex: 0,
          explanation: 'هُزم نابليون في معركة واترلو في بلجيكا.',
        ),
        QuizQuestion(
          question: 'من مؤسس الدولة الأموية؟',
          options: [
            'معاوية بن أبي سفيان',
            'عبد الملك بن مروان',
            'يزيد بن معاوية',
            'مروان بن الحكم'
          ],
          correctIndex: 0,
          explanation: 'أسس معاوية الدولة الأموية عام 41 هـ وجعل عاصمتها دمشق.',
        ),
        QuizQuestion(
          question: 'في أي سنة هجرية فُتحت مكة المكرمة؟',
          options: ['6 هـ', '8 هـ', '10 هـ', '2 هـ'],
          correctIndex: 1,
          explanation: 'كان فتح مكة في رمضان سنة 8 هـ.',
        ),
        QuizQuestion(
          question: 'أي حضارة اشتهرت بمدينة بابل وحدائقها المعلقة؟',
          options: ['السومرية', 'البابلية', 'الفينيقية', 'الحثية'],
          correctIndex: 1,
          explanation: 'بابل عاصمة الحضارة البابلية في بلاد الرافدين.',
        ),
        QuizQuestion(
          question: 'من هو حمورابي؟',
          options: [
            'ملك بابلي اشتهر بشريعته',
            'فرعون مصري',
            'قائد روماني',
            'فيلسوف إغريقي'
          ],
          correctIndex: 0,
          explanation:
              'حمورابي ملك بابل، وتُنسب إليه إحدى أقدم المدونات القانونية.',
        ),
        QuizQuestion(
          question: 'في أي عام تفكك الاتحاد السوفيتي؟',
          options: ['1985', '1989', '1991', '1995'],
          correctIndex: 2,
          explanation: 'تفكك الاتحاد السوفيتي رسمياً في ديسمبر 1991.',
        ),
        QuizQuestion(
          question: 'من قاد الثورة البلشفية في روسيا عام 1917؟',
          options: ['ستالين', 'لينين', 'تروتسكي', 'خروتشوف'],
          correctIndex: 1,
          explanation: 'قاد فلاديمير لينين الثورة البلشفية.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 💻 المرحلة 4 — التكنولوجيا (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 4,
      title: 'التكنولوجيا',
      icon: '💻',
      color: Color(0xFF42A5F5),
      requiredScore: 150,
      questions: [
        QuizQuestion(
          question: 'ماذا يعني اختصار HTML؟',
          options: [
            'Hyper Text Markup Language',
            'High Tech Modern Language',
            'Hyper Transfer Markup Link',
            'Home Tool Markup Language'
          ],
          correctIndex: 0,
          explanation:
              'HTML اختصار لـ HyperText Markup Language لغة بناء صفحات الويب.',
        ),
        QuizQuestion(
          question: 'من أسس شركة Apple؟',
          options: ['بيل غيتس', 'ستيف جوبز', 'مارك زوكربيرغ', 'إيلون ماسك'],
          correctIndex: 1,
          explanation: 'أسس ستيف جوبز وستيف وزنياك وآخرون Apple عام 1976.',
        ),
        QuizQuestion(
          question: 'ما هي لغة البرمجة المستخدمة في Flutter؟',
          options: ['Java', 'Kotlin', 'Swift', 'Dart'],
          correctIndex: 3,
          explanation: 'Flutter إطار عمل من Google يستخدم لغة Dart.',
        ),
        QuizQuestion(
          question: 'ما اختصار CPU؟',
          options: [
            'Central Processing Unit',
            'Computer Personal Unit',
            'Central Power Utility',
            'Core Processing Utility'
          ],
          correctIndex: 0,
          explanation:
              'CPU اختصار Central Processing Unit وهو "المعالج المركزي".',
        ),
        QuizQuestion(
          question: 'ما الشركة التي طوّرت نظام Android؟',
          options: ['Apple', 'Microsoft', 'Google', 'Samsung'],
          correctIndex: 2,
          explanation: 'طوّرت Google نظام Android وتملك شركة Android Inc.',
        ),
        QuizQuestion(
          question: 'ما اختصار RAM؟',
          options: [
            'Random Access Memory',
            'Read And More',
            'Run Active Memory',
            'Real Access Module'
          ],
          correctIndex: 0,
          explanation: 'RAM تعني Random Access Memory، الذاكرة العشوائية.',
        ),
        QuizQuestion(
          question: 'ما أول متصفح ويب تجاري ناجح؟',
          options: [
            'Internet Explorer',
            'Netscape Navigator',
            'Firefox',
            'Opera'
          ],
          correctIndex: 1,
          explanation: 'Netscape Navigator كان أول متصفح ناجح تجارياً في 1994.',
        ),
        QuizQuestion(
          question: 'في أي عام أُطلق أول iPhone؟',
          options: ['2005', '2006', '2007', '2008'],
          correctIndex: 2,
          explanation: 'أعلن ستيف جوبز عن أول iPhone في يناير 2007.',
        ),
        QuizQuestion(
          question: 'ما اختصار AI؟',
          options: [
            'Advanced Internet',
            'Artificial Intelligence',
            'Automated Input',
            'Active Interface'
          ],
          correctIndex: 1,
          explanation:
              'AI اختصار Artificial Intelligence أي "الذكاء الاصطناعي".',
        ),
        QuizQuestion(
          question:
              'ما لغة البرمجة المستخدمة بشكل رئيسي في تطوير مواقع الويب الديناميكية؟',
          options: ['Python', 'JavaScript', 'C++', 'Swift'],
          correctIndex: 1,
          explanation: 'JavaScript اللغة الأساسية لجعل صفحات الويب تفاعلية.',
        ),
        QuizQuestion(
          question: 'ما وحدة تخزين البيانات الأكبر بين الآتية؟',
          options: ['Kilobyte', 'Megabyte', 'Gigabyte', 'Terabyte'],
          correctIndex: 3,
          explanation: 'Terabyte = 1024 Gigabyte وهو الأكبر في القائمة.',
        ),
        QuizQuestion(
          question: 'من مخترع شبكة الإنترنت العالمية (WWW)؟',
          options: ['بيل غيتس', 'ستيف جوبز', 'تيم بيرنرز لي', 'لينوس تورفالدز'],
          correctIndex: 2,
          explanation: 'اخترع تيم بيرنرز لي الشبكة العنكبوتية WWW عام 1989.',
        ),
        QuizQuestion(
          question: 'ما نظام التشغيل مفتوح المصدر الأشهر للخوادم؟',
          options: ['Windows Server', 'macOS', 'Linux', 'FreeBSD'],
          correctIndex: 2,
          explanation: 'Linux نظام مفتوح المصدر يشغّل غالبية خوادم الإنترنت.',
        ),
        QuizQuestion(
          question: 'ما اختصار USB؟',
          options: [
            'Universal Serial Bus',
            'Ultra Speed Boost',
            'Unified System Board',
            'Universal Storage Block'
          ],
          correctIndex: 0,
          explanation:
              'USB اختصار Universal Serial Bus، الناقل التسلسلي العالمي.',
        ),
        QuizQuestion(
          question: 'أي شركة صنعت أول حاسوب شخصي تجاري ناجح؟',
          options: ['Apple', 'IBM', 'Commodore', 'Atari'],
          correctIndex: 0,
          explanation: 'كمبيوتر Apple II (1977) كان أول حاسوب شخصي تجاري ناجح.',
        ),
        QuizQuestion(
          question: 'من مؤسس شركة Microsoft؟',
          options: ['ستيف جوبز', 'بيل غيتس', 'إيلون ماسك', 'جيف بيزوس'],
          correctIndex: 1,
          explanation: 'أسس بيل غيتس وبول ألين شركة Microsoft عام 1975.',
        ),
        QuizQuestion(
          question: 'من مؤسس شبكة فيسبوك؟',
          options: [
            'مارك زوكربيرغ',
            'جاك دورسي',
            'ايفان شبيغل',
            'كيفن سيستروم'
          ],
          correctIndex: 0,
          explanation: 'أسس مارك زوكربيرغ فيسبوك عام 2004.',
        ),
        QuizQuestion(
          question: 'ماذا يعني اختصار URL؟',
          options: [
            'Universal Resource Locator',
            'Uniform Resource Locator',
            'United Resource Link',
            'Unique Reference Locator'
          ],
          correctIndex: 1,
          explanation:
              'URL اختصار Uniform Resource Locator، عنوان الموقع على الويب.',
        ),
        QuizQuestion(
          question:
              'أي إحدى أقدم لغات البرمجة عالية المستوى التي ظهرت في الخمسينيات؟',
          options: ['Python', 'Fortran', 'Java', 'Swift'],
          correctIndex: 1,
          explanation:
              'لغة Fortran ظهرت عام 1957 وتُعد من أقدم اللغات عالية المستوى.',
        ),
        QuizQuestion(
          question:
              'أي شركة تصنع معالجات Snapdragon المستخدمة في الهواتف الذكية؟',
          options: ['Intel', 'Qualcomm', 'Samsung', 'MediaTek'],
          correctIndex: 1,
          explanation:
              'شركة Qualcomm الأمريكية هي المصنّعة لمعالجات Snapdragon.',
        ),
        QuizQuestion(
          question: 'ماذا يعني اختصار GPS؟',
          options: [
            'Global Positioning System',
            'General Power Source',
            'Great Path Signal',
            'Global Processing Server'
          ],
          correctIndex: 0,
          explanation: 'GPS هو نظام تحديد المواقع العالمي.',
        ),
        QuizQuestion(
          question: 'من أنشأ لغة البرمجة Python؟',
          options: [
            'جيدو فان روسوم',
            'دينيس ريتشي',
            'جيمس غوسلينغ',
            'بيارن ستروستروب'
          ],
          correctIndex: 0,
          explanation: 'أنشأ جيدو فان روسوم لغة Python وأطلقها عام 1991.',
        ),
        QuizQuestion(
          question: 'ماذا يعني اختصار SSD؟',
          options: [
            'Solid State Drive',
            'Super Speed Disk',
            'Smart Storage Device',
            'System Software Drive'
          ],
          correctIndex: 0,
          explanation: 'SSD قرص تخزين بالحالة الصلبة ولا يحتوي أجزاء متحركة.',
        ),
        QuizQuestion(
          question: 'ما هو Git؟',
          options: [
            'نظام للتحكم بالإصدارات',
            'لغة برمجة',
            'قاعدة بيانات',
            'نظام تشغيل'
          ],
          correctIndex: 0,
          explanation:
              'Git نظام لتتبع التغييرات في الشيفرة البرمجية، أنشأه لينوس تورفالدز.',
        ),
        QuizQuestion(
          question: 'ماذا يعني اختصار HTTP؟',
          options: [
            'HyperText Transfer Protocol',
            'High Transfer Text Page',
            'Hyper Tool Transfer Process',
            'Host Text Transfer Program'
          ],
          correctIndex: 0,
          explanation: 'HTTP بروتوكول نقل النص التشعبي المستخدم في الويب.',
        ),
        QuizQuestion(
          question: 'من أنشأ نواة نظام Linux؟',
          options: [
            'ريتشارد ستالمان',
            'لينوس تورفالدز',
            'دينيس ريتشي',
            'كين طومسون'
          ],
          correctIndex: 1,
          explanation: 'بدأ لينوس تورفالدز تطوير Linux عام 1991.',
        ),
        QuizQuestion(
          question: 'ما النظام العددي الذي تعتمد عليه الحواسيب داخلياً؟',
          options: ['العشري', 'الثنائي', 'الثماني', 'الستيني'],
          correctIndex: 1,
          explanation: 'تعمل الحواسيب بالنظام الثنائي (0 و1).',
        ),
        QuizQuestion(
          question: 'أي شركة تملك منصة YouTube؟',
          options: ['Meta', 'Google', 'Microsoft', 'Amazon'],
          correctIndex: 1,
          explanation: 'اشترت Google منصة YouTube عام 2006.',
        ),
        QuizQuestion(
          question: 'ما وحدة قياس تردد المعالج؟',
          options: ['واط', 'هرتز', 'فولت', 'أمبير'],
          correctIndex: 1,
          explanation: 'يُقاس تردد المعالج بالهرتز، وغالباً بالغيغاهرتز GHz.',
        ),
        QuizQuestion(
          question: 'ماذا يعني اختصار VPN؟',
          options: [
            'Virtual Private Network',
            'Very Private Node',
            'Visual Protocol Network',
            'Virtual Public Network'
          ],
          correctIndex: 0,
          explanation: 'VPN شبكة افتراضية خاصة تشفّر الاتصال وتخفي العنوان.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // ⚽ المرحلة 5 — الرياضة (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 5,
      title: 'الرياضة',
      icon: '⚽',
      color: Color(0xFF66BB6A),
      requiredScore: 200,
      questions: [
        QuizQuestion(
          question: 'كم عدد لاعبي كرة القدم في كل فريق؟',
          options: ['9', '10', '11', '12'],
          correctIndex: 2,
          explanation: 'كل فريق يتكون من 11 لاعباً أساسياً على أرض الملعب.',
        ),
        QuizQuestion(
          question: 'كم سنة تُقام الألعاب الأولمبية الصيفية؟',
          options: ['2 سنوات', '4 سنوات', '6 سنوات', '8 سنوات'],
          correctIndex: 1,
          explanation: 'الألعاب الأولمبية الصيفية تُنظَّم كل 4 سنوات.',
        ),
        QuizQuestion(
          question: 'ما الدولة الفائزة بكأس العالم 2022؟',
          options: ['البرازيل', 'فرنسا', 'الأرجنتين', 'ألمانيا'],
          correctIndex: 2,
          explanation:
              'فازت الأرجنتين بكأس العالم 2022 في قطر على الفرنسيين بركلات الجزاء.',
        ),
        QuizQuestion(
          question: 'من يحمل رقم قياسي العالم في سباق 100 متر؟',
          options: ['كارل لويس', 'أوساين بولت', 'يوهان بلايك', 'تايسون غاي'],
          correctIndex: 1,
          explanation: 'أوساين بولت سجّل 9.58 ثانية في برلين 2009.',
        ),
        QuizQuestion(
          question: 'في أي مدينة أُقيمت أولى الألعاب الأولمبية الحديثة؟',
          options: ['روما', 'باريس', 'أثينا', 'لندن'],
          correctIndex: 2,
          explanation:
              'أُقيمت أولى الألعاب الأولمبية الحديثة في أثينا عام 1896.',
        ),
        QuizQuestion(
          question: 'كم تدوم مباراة كرة القدم العادية؟',
          options: ['80 دقيقة', '90 دقيقة', '100 دقيقة', '120 دقيقة'],
          correctIndex: 1,
          explanation: 'المباراة تتكون من شوطين بـ45 دقيقة لكل شوط = 90 دقيقة.',
        ),
        QuizQuestion(
          question: 'كم عدد لاعبي كرة السلة في كل فريق؟',
          options: ['4', '5', '6', '7'],
          correctIndex: 1,
          explanation: 'كل فريق كرة سلة يلعب بـ5 لاعبين على أرض الملعب.',
        ),
        QuizQuestion(
          question: 'في أي رياضة تُستخدم كلمة "رافعة"؟',
          options: ['الملاكمة', 'رفع الأثقال', 'الجمباز', 'السباحة'],
          correctIndex: 1,
          explanation:
              'رافعة الأثقال أو "Clean and Jerk" مصطلح في رفع الأثقال.',
        ),
        QuizQuestion(
          question: 'ما أكثر دولة فوزاً بكأس العالم لكرة القدم؟',
          options: ['ألمانيا', 'إيطاليا', 'البرازيل', 'الأرجنتين'],
          correctIndex: 2,
          explanation:
              'البرازيل فازت بكأس العالم 5 مرات (1958، 1962، 1970، 1994، 2002).',
        ),
        QuizQuestion(
          question: 'في أي رياضة تُستخدم كلمة "سكاش"؟',
          options: ['الإسكواش', 'الجودو', 'التنس', 'الغولف'],
          correctIndex: 0,
          explanation: 'الإسكواش رياضة تُلعب بمضارب في غرفة مغلقة.',
        ),
        QuizQuestion(
          question: 'كم نقطة يساوي "التراي" في كرة القدم الأمريكية؟',
          options: ['3', '6', '7', '8'],
          correctIndex: 1,
          explanation: '"التراي" يساوي 6 نقاط ثم يُضاف إليها نقطة الإضافة.',
        ),
        QuizQuestion(
          question: 'من هو أكثر لاعب حائز على كأس العالم لكرة القدم؟',
          options: ['رونالدو', 'بيليه', 'كافاني', 'زيدان'],
          correctIndex: 1,
          explanation:
              'بيليه فاز بكأس العالم 3 مرات مع البرازيل (1958، 1962، 1970).',
        ),
        QuizQuestion(
          question: 'في أي مدينة أُقيمت دورة الألعاب الأولمبية 2024؟',
          options: ['لندن', 'طوكيو', 'باريس', 'لوس أنجلوس'],
          correctIndex: 2,
          explanation: 'استضافت باريس دورة الألعاب الأولمبية الصيفية 2024.',
        ),
        QuizQuestion(
          question: 'ما رياضة تُعرف بـ"الملك"؟',
          options: ['كرة القدم', 'كرة السلة', 'التنس', 'الملاكمة'],
          correctIndex: 0,
          explanation: 'تُعرف كرة القدم بـ"اللعبة الملكية" لانتشارها الواسع.',
        ),
        QuizQuestion(
          question: 'كم عدد اللاعبين في فريق الكريكيت؟',
          options: ['9', '10', '11', '12'],
          correctIndex: 2,
          explanation: 'فريق الكريكيت يتكون من 11 لاعباً.',
        ),
        QuizQuestion(
          question:
              'كم عدد الأشواط (الأرباع) في مباراة كرة السلة الاحترافية NBA؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation: 'تنقسم مباراة NBA إلى 4 أرباع مدة كل منها 12 دقيقة.',
        ),
        QuizQuestion(
          question:
              'في أي رياضة يُستخدم مصطلح "Ace" للإشارة إلى إرسال مباشر يفوز بالنقطة؟',
          options: ['التنس', 'كرة الطائرة', 'الجولف', 'كليهما أ وب'],
          correctIndex: 3,
          explanation:
              'مصطلح Ace يُستخدم في التنس وكرة الطائرة للإرسال الذي لا يُرد عليه.',
        ),
        QuizQuestion(
          question: 'أي دولة استضافت كأس العالم لكرة القدم عام 2018؟',
          options: ['البرازيل', 'ألمانيا', 'روسيا', 'قطر'],
          correctIndex: 2,
          explanation: 'استضافت روسيا نهائيات كأس العالم لكرة القدم عام 2018.',
        ),
        QuizQuestion(
          question: 'كم عدد لاعبي فريق الكرة الطائرة داخل الملعب؟',
          options: ['5', '6', '7', '8'],
          correctIndex: 1,
          explanation: 'يتكون فريق الكرة الطائرة من 6 لاعبين داخل الملعب.',
        ),
        QuizQuestion(
          question:
              'ما الدولة الحاصلة على أكبر عدد من الميداليات الذهبية الأولمبية تاريخياً؟',
          options: ['روسيا', 'الصين', 'الولايات المتحدة', 'ألمانيا'],
          correctIndex: 2,
          explanation:
              'تتصدر الولايات المتحدة تاريخياً قائمة الميداليات الذهبية الأولمبية.',
        ),
        QuizQuestion(
          question: 'كم عدد لاعبي كرة اليد داخل الملعب لكل فريق؟',
          options: ['6', '7', '9', '11'],
          correctIndex: 1,
          explanation: 'يلعب كل فريق بسبعة لاعبين بينهم حارس المرمى.',
        ),
        QuizQuestion(
          question: 'أي دولة فازت بكأس العالم لكرة القدم 2010؟',
          options: ['هولندا', 'إسبانيا', 'ألمانيا', 'أوروغواي'],
          correctIndex: 1,
          explanation: 'فازت إسبانيا على هولندا في جنوب أفريقيا.',
        ),
        QuizQuestion(
          question: 'كم حلقة في شعار الألعاب الأولمبية؟',
          options: ['4', '5', '6', '7'],
          correctIndex: 1,
          explanation: 'خمس حلقات متشابكة ترمز إلى القارات الخمس.',
        ),
        QuizQuestion(
          question: 'في أي رياضة تُقام بطولة ويمبلدون؟',
          options: ['الغولف', 'التنس', 'الكريكيت', 'الرغبي'],
          correctIndex: 1,
          explanation: 'ويمبلدون من أعرق بطولات التنس وتُلعب على العشب.',
        ),
        QuizQuestion(
          question: 'ما مسافة سباق الماراثون؟',
          options: ['21 كم', '42.195 كم', '50 كم', '30 كم'],
          correctIndex: 1,
          explanation: 'مسافة الماراثون الرسمية 42.195 كيلومتراً.',
        ),
        QuizQuestion(
          question: 'أي دولة استضافت كأس العالم 1998؟',
          options: ['إيطاليا', 'فرنسا', 'ألمانيا', 'إسبانيا'],
          correctIndex: 1,
          explanation: 'استضافت فرنسا البطولة وفازت بها.',
        ),
        QuizQuestion(
          question: 'كم نقطة تُحتسب للرمية الحرة الناجحة في كرة السلة؟',
          options: ['1', '2', '3', '4'],
          correctIndex: 0,
          explanation: 'الرمية الحرة تساوي نقطة واحدة.',
        ),
        QuizQuestion(
          question: 'في أي رياضة يُمنح الحزام الأسود؟',
          options: ['الكاراتيه', 'الشطرنج', 'التنس', 'السباحة'],
          correctIndex: 0,
          explanation: 'الحزام الأسود من أعلى الدرجات في الكاراتيه والجودو.',
        ),
        QuizQuestion(
          question: 'ما الرياضة التي تُقام فيها بطولة "تور دو فرانس"؟',
          options: ['الجري', 'سباق الدراجات', 'السباحة', 'الفروسية'],
          correctIndex: 1,
          explanation: 'تور دو فرانس أشهر سباق دراجات على الطرق في العالم.',
        ),
        QuizQuestion(
          question: 'في أي دولة نشأت رياضة الجودو؟',
          options: ['الصين', 'كوريا', 'اليابان', 'تايلاند'],
          correctIndex: 2,
          explanation: 'أسس جيغورو كانو الجودو في اليابان عام 1882.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🌿 المرحلة 6 — عالم الطبيعة (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 6,
      title: 'عالم الطبيعة',
      icon: '🌿',
      color: Color(0xFF26A69A),
      requiredScore: 250,
      questions: [
        QuizQuestion(
          question: 'ما أكبر حيوان بري في العالم؟',
          options: ['الزرافة', 'وحيد القرن', 'الفيل الأفريقي', 'فرس النهر'],
          correctIndex: 2,
          explanation:
              'الفيل الأفريقي يزن حتى 7 أطنان وهو أضخم الحيوانات البرية.',
        ),
        QuizQuestion(
          question: 'ما أسرع حيوان بري في العالم؟',
          options: ['الأسد', 'الفهد', 'النمر', 'الحصان'],
          correctIndex: 1,
          explanation: 'الفهد يصل لـ 120 كم/ساعة ويُعدّ أسرع حيوان بري.',
        ),
        QuizQuestion(
          question: 'من أين يصنع النحل العسل؟',
          options: ['الفطر', 'رحيق الزهور', 'الطحالب', 'الحشائش'],
          correctIndex: 1,
          explanation: 'النحل يجمع رحيق الزهور ويحوّله إلى عسل داخل الخلية.',
        ),
        QuizQuestion(
          question: 'ما أكبر حيوان في العالم؟',
          options: [
            'الحوت الأزرق',
            'القرش الأبيض',
            'التمساح',
            'الفيل الأفريقي'
          ],
          correctIndex: 0,
          explanation: 'الحوت الأزرق أكبر حيوان على الإطلاق بطول 30 متراً.',
        ),
        QuizQuestion(
          question: 'ما اسم أنثى الأسد؟',
          options: ['نمرة', 'لبؤة', 'ضبعة', 'ذئبة'],
          correctIndex: 1,
          explanation: 'أنثى الأسد تسمى "لبؤة".',
        ),
        QuizQuestion(
          question: 'كم عدد أرجل العنكبوت؟',
          options: ['4', '6', '8', '10'],
          correctIndex: 2,
          explanation: 'العناكب من العنكبيات (وليست حشرات) ولها 8 أرجل.',
        ),
        QuizQuestion(
          question: 'ما اسم المجموعة التي تنتمي إليها الخفافيش؟',
          options: ['الزواحف', 'الطيور', 'الثدييات', 'البرمائيات'],
          correctIndex: 2,
          explanation: 'الخفاش هو الثديي الوحيد القادر على الطيران الحقيقي.',
        ),
        QuizQuestion(
          question: 'ما الحيوان الذي يُعرف بـ"سفينة الصحراء"؟',
          options: ['الحمار', 'البغل', 'الجمل', 'الخيل'],
          correctIndex: 2,
          explanation: 'الجمل يُعرف بـ"سفينة الصحراء" لقدرته على التحمل.',
        ),
        QuizQuestion(
          question: 'كم عاماً تعيش السلحفاة عادةً؟',
          options: ['20-30', '50-70', '100-150', '200-300'],
          correctIndex: 2,
          explanation: 'السلاحف تعيش بين 100 و150 عاماً في المتوسط.',
        ),
        QuizQuestion(
          question: 'ما الحيوان الذي يستطيع تغيير لونه؟',
          options: ['الحرذون', 'الحرباء', 'السمندل', 'الضفدع'],
          correctIndex: 1,
          explanation: 'الحرباء تغيّر لونها للتمويه والتواصل وتنظيم الحرارة.',
        ),
        QuizQuestion(
          question: 'ما أطول رقبة بين الحيوانات؟',
          options: ['الزرافة', 'الفيل', 'الجمل', 'الإبل'],
          correctIndex: 0,
          explanation: 'رقبة الزرافة تصل لـ 2 متر وهي الأطول بين الحيوانات.',
        ),
        QuizQuestion(
          question: 'ما الحيوان الذي ينام واقفاً؟',
          options: ['الحصان', 'الفيل', 'البقرة', 'جميع ما سبق'],
          correctIndex: 3,
          explanation: 'الحصان والفيل والبقرة كلها قادرة على النوم واقفةً.',
        ),
        QuizQuestion(
          question: 'ما عدد أذرع الأخطبوط؟',
          options: ['6', '7', '8', '10'],
          correctIndex: 2,
          explanation: 'الأخطبوط له 8 أذرع تحتوي على ممصات.',
        ),
        QuizQuestion(
          question: 'ما اسم فصيلة الدب الكبيرة؟',
          options: ['Felidae', 'Canidae', 'Ursidae', 'Mustelidae'],
          correctIndex: 2,
          explanation: 'الدببة تنتمي إلى الفصيلة Ursidae.',
        ),
        QuizQuestion(
          question: 'ما الحيوان البحري الذي يُعرف بامتلاكه لـ5 أذرع؟',
          options: ['قنديل البحر', 'نجم البحر', 'قرد البحر', 'قنفذ البحر'],
          correctIndex: 1,
          explanation: 'نجم البحر (نجمة البحر) له عادةً 5 أذرع.',
        ),
        QuizQuestion(
          question: 'أي حيوان يُلقّب بـ"ملك الغابة"؟',
          options: ['النمر', 'الأسد', 'الفهد', 'الدب'],
          correctIndex: 1,
          explanation: 'يُطلق على الأسد لقب "ملك الغابة" لهيبته وقوته.',
        ),
        QuizQuestion(
          question: 'كم عدد قلوب الأخطبوط؟',
          options: ['1', '2', '3', '4'],
          correctIndex: 2,
          explanation:
              'للأخطبوط 3 قلوب: قلب رئيسي وقلبان يضخان الدم إلى الخياشيم.',
        ),
        QuizQuestion(
          question: 'ما اسم أصغر طائر معروف في العالم؟',
          options: ['العصفور', 'الطائر الطنان', 'الحسون', 'الكناري'],
          correctIndex: 1,
          explanation:
              'الطائر الطنان (Hummingbird) هو أصغر أنواع الطيور المعروفة.',
        ),
        QuizQuestion(
          question: 'أي من الحيوانات التالية ثديي يبيض بدلاً من أن يلد؟',
          options: ['الكنغر', 'منقار البط', 'الخفاش', 'الدلفين'],
          correctIndex: 1,
          explanation:
              'حيوان منقار البط (Platypus) من الثدييات النادرة التي تبيض.',
        ),
        QuizQuestion(
          question: 'ما اسم عملية تحوّل اليرقة إلى فراشة؟',
          options: [
            'التبخر',
            'الاستحالة (التحول الكامل)',
            'التبرعم',
            'الانقسام'
          ],
          correctIndex: 1,
          explanation:
              'تمر الفراشة بعملية استحالة كاملة من بيضة إلى يرقة إلى شرنقة ثم فراشة.',
        ),
        QuizQuestion(
          question: 'أي من هذه الطيور لا يستطيع الطيران؟',
          options: ['النسر', 'النعامة', 'الصقر', 'البومة'],
          correctIndex: 1,
          explanation: 'النعامة أكبر الطيور ولا تطير لكنها تجري بسرعة كبيرة.',
        ),
        QuizQuestion(
          question: 'ما الغذاء الرئيسي للباندا العملاقة؟',
          options: ['الخيزران', 'العشب', 'السمك', 'الفاكهة'],
          correctIndex: 0,
          explanation: 'يشكل الخيزران معظم غذاء الباندا.',
        ),
        QuizQuestion(
          question: 'أي حيوان يعيش في القطب الجنوبي بشكل طبيعي؟',
          options: ['الدب القطبي', 'البطريق', 'الرنة', 'الثعلب القطبي'],
          correctIndex: 1,
          explanation:
              'البطريق يعيش في نصف الكرة الجنوبي، أما الدب القطبي فمن القطب الشمالي.',
        ),
        QuizQuestion(
          question: 'ما الحيوان الذي يتغذى أساساً على النمل والنمل الأبيض؟',
          options: ['آكل النمل', 'الزرافة', 'الحصان', 'الأرنب'],
          correctIndex: 0,
          explanation: 'آكل النمل يلتقط النمل بلسانه الطويل اللزج.',
        ),
        QuizQuestion(
          question: 'ما أسرع طائر في العالم أثناء الانقضاض؟',
          options: ['النعامة', 'الصقر الشاهين', 'الحمام', 'البجع'],
          correctIndex: 1,
          explanation: 'الصقر الشاهين يتجاوز 300 كم/ساعة أثناء الانقضاض.',
        ),
        QuizQuestion(
          question: 'إلى أي مجموعة تنتمي الدلافين؟',
          options: ['الأسماك', 'الثدييات', 'الزواحف', 'القشريات'],
          correctIndex: 1,
          explanation: 'الدلفين ثديي يتنفس الهواء ويرضع صغاره.',
        ),
        QuizQuestion(
          question: 'ماذا تنتج دودة القز؟',
          options: ['العسل', 'الحرير', 'الشمع', 'الصمغ'],
          correctIndex: 1,
          explanation: 'تغزل دودة القز شرنقة من خيط الحرير.',
        ),
        QuizQuestion(
          question: 'أي من هذه النباتات يتغذى على الحشرات؟',
          options: ['الصبار', 'نبات الجرة', 'النخيل', 'الزيتون'],
          correctIndex: 1,
          explanation: 'نبات الجرة يصطاد الحشرات في أوراقه المتحورة.',
        ),
        QuizQuestion(
          question: 'كم عدد أرجل السلطعون (الكابوريا) بما فيها الكماشتان؟',
          options: ['6', '8', '10', '12'],
          correctIndex: 2,
          explanation: 'السلطعون من عشريات الأرجل: عشر أرجل بينها الكماشتان.',
        ),
        QuizQuestion(
          question: 'أي شجرة من التالية هي الأطول في العالم؟',
          options: ['الصنوبر', 'السكويا الساحلية', 'البلوط', 'النخيل'],
          correctIndex: 1,
          explanation: 'السكويا الساحلية تتجاوز 110 أمتار.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🚀 المرحلة 7 — استكشاف الفضاء (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 7,
      title: 'استكشاف الفضاء',
      icon: '🚀',
      color: Color(0xFF7E57C2),
      requiredScore: 300,
      questions: [
        QuizQuestion(
          question: 'من كان أول إنسان يدخل الفضاء؟',
          options: ['نيل أرمسترونغ', 'يوري غاغارين', 'بوز ألدرين', 'جون غلين'],
          correctIndex: 1,
          explanation:
              'يوري غاغارين السوفيتي أول إنسان في الفضاء في أبريل 1961.',
        ),
        QuizQuestion(
          question: 'ما أقرب كوكب للشمس؟',
          options: ['الزهرة', 'الأرض', 'عطارد', 'المريخ'],
          correctIndex: 2,
          explanation:
              'عطارد أقرب الكواكب للشمس بمتوسط مسافة 58 مليون كيلومتر.',
        ),
        QuizQuestion(
          question: 'ما اسم مجرتنا؟',
          options: ['أندروميدا', 'درب التبانة', 'المثلث', 'برنارد'],
          correctIndex: 1,
          explanation: 'نحن نعيش في مجرة درب التبانة (The Milky Way).',
        ),
        QuizQuestion(
          question: 'كم يستغرق ضوء الشمس للوصول للأرض؟',
          options: ['1 دقيقة', '8 دقائق', '30 دقيقة', 'ساعة'],
          correctIndex: 1,
          explanation: 'يستغرق ضوء الشمس 8 دقائق و20 ثانية للوصول للأرض.',
        ),
        QuizQuestion(
          question: 'ما أكبر جسم في المجموعة الشمسية؟',
          options: ['المشتري', 'زحل', 'الشمس', 'الأرض'],
          correctIndex: 2,
          explanation: 'الشمس تحتوي على 99.86% من كتلة المجموعة الشمسية.',
        ),
        QuizQuestion(
          question: 'ما اسم محطة الفضاء الدولية؟',
          options: ['ISS', 'MIR', 'Skylab', 'Tiangong'],
          correctIndex: 0,
          explanation: 'ISS اختصار International Space Station.',
        ),
        QuizQuestion(
          question: 'ما الكوكب المعروف بـ"الكوكب الأحمر"؟',
          options: ['عطارد', 'الزهرة', 'المريخ', 'المشتري'],
          correctIndex: 2,
          explanation: 'المريخ يبدو أحمر بسبب أكسيد الحديد في سطحه.',
        ),
        QuizQuestion(
          question: 'كم عدد كواكب المجموعة الشمسية؟',
          options: ['7', '8', '9', '10'],
          correctIndex: 1,
          explanation:
              'بعد تصنيف بلوتو كـ"كوكب قزم" عام 2006 أصبح عدد الكواكب 8.',
        ),
        QuizQuestion(
          question: 'ما اسم أول قمر صناعي في الفضاء؟',
          options: ['أبولو 1', 'سبوتنيك 1', 'فويجر 1', 'هابل'],
          correctIndex: 1,
          explanation: 'أطلق الاتحاد السوفيتي سبوتنيك 1 في أكتوبر 1957.',
        ),
        QuizQuestion(
          question: 'ما أبعد جسم أرسله الإنسان في الفضاء؟',
          options: ['أبولو 17', 'فويجر 1', 'نيو هورايزنز', 'بايونير 10'],
          correctIndex: 1,
          explanation:
              'فويجر 1 أبعد جسم صنعه الإنسان، تجاوز حدود المجموعة الشمسية.',
        ),
        QuizQuestion(
          question: 'ما اسم الثقب في مركز مجرتنا؟',
          options: ['عقرب A', 'القوس A*', 'كنتاروس B', 'NGC 1277'],
          correctIndex: 1,
          explanation: 'الثقب الأسود الهائل في مركز مجرتنا يُعرف بـ"القوس A*".',
        ),
        QuizQuestion(
          question: 'ما سرعة صاروخ الفضاء للخروج من جاذبية الأرض؟',
          options: ['8 كم/ث', '11 كم/ث', '20 كم/ث', '30 كم/ث'],
          correctIndex: 1,
          explanation:
              'سرعة الإفلات من جاذبية الأرض حوالي 11.2 كيلومتر في الثانية.',
        ),
        QuizQuestion(
          question: 'ما الكوكب الذي له حلقات مميزة؟',
          options: ['المشتري', 'زحل', 'أورانوس', 'كلاهما ب وج'],
          correctIndex: 3,
          explanation:
              'زحل وأورانوس والمشتري ونبتون كلها لها حلقات، لكن حلقات زحل الأبرز.',
        ),
        QuizQuestion(
          question: 'كم عدد أقمار المريخ؟',
          options: ['0', '1', '2', '3'],
          correctIndex: 2,
          explanation: 'للمريخ قمران: فوبوس وديموس.',
        ),
        QuizQuestion(
          question: 'ما تلسكوب الفضاء الذي أطلقته NASA عام 1990؟',
          options: ['كبلر', 'جيمس ويب', 'هابل', 'سبيتزر'],
          correctIndex: 2,
          explanation: 'تلسكوب هابل الفضائي أُطلق عام 1990 ولا يزال يعمل.',
        ),
        QuizQuestion(
          question: 'من هي أول امرأة تسافر إلى الفضاء؟',
          options: [
            'سالي رايد',
            'فالنتينا تيريشكوفا',
            'مي جيميسون',
            'بيغي ويتسون'
          ],
          correctIndex: 1,
          explanation:
              'فالنتينا تيريشكوفا السوفيتية أول امرأة في الفضاء عام 1963.',
        ),
        QuizQuestion(
          question: 'كم تستغرق الأرض تقريباً لتدور حول نفسها دورة واحدة؟',
          options: ['12 ساعة', '24 ساعة', '48 ساعة', 'أسبوع'],
          correctIndex: 1,
          explanation:
              'تدور الأرض حول محورها مرة كل 24 ساعة تقريباً مكوّنة اليوم والليلة.',
        ),
        QuizQuestion(
          question:
              'ما اسم المهمة الفضائية التي أوصلت أول إنسان إلى سطح القمر؟',
          options: ['أبولو 8', 'أبولو 11', 'جيميني 4', 'مركوري 7'],
          correctIndex: 1,
          explanation:
              'مهمة أبولو 11 عام 1969 أوصلت أرمسترونغ وألدرين إلى سطح القمر.',
        ),
        QuizQuestion(
          question: 'ما اسم أقرب نظام نجمي إلى شمسنا؟',
          options: [
            'الشعرى اليمانية',
            'ألفا القنطور (بروكسيما)',
            'نجم الشمال',
            'الدجاجة'
          ],
          correctIndex: 1,
          explanation:
              'نظام ألفا القنطور ويضم نجم بروكسيما هو الأقرب إلى شمسنا.',
        ),
        QuizQuestion(
          question: 'كم يُقدَّر عمر الكون تقريباً؟',
          options: [
            '4.6 مليار سنة',
            '8 مليارات سنة',
            '13.8 مليار سنة',
            '20 مليار سنة'
          ],
          correctIndex: 2,
          explanation:
              'يُقدّر العلماء عمر الكون بنحو 13.8 مليار سنة منذ الانفجار العظيم.',
        ),
        QuizQuestion(
          question: 'ما أكبر أقمار كوكب زحل؟',
          options: ['إنسيلادوس', 'تيتان', 'ريا', 'ميماس'],
          correctIndex: 1,
          explanation:
              'تيتان ثاني أكبر قمر في المجموعة الشمسية وله غلاف جوي كثيف.',
        ),
        QuizQuestion(
          question: 'ما أكبر قمر في المجموعة الشمسية؟',
          options: ['قمر الأرض', 'غانيميد', 'تيتان', 'أوروبا'],
          correctIndex: 1,
          explanation: 'غانيميد قمر المشتري وهو الأكبر، وأكبر حتى من عطارد.',
        ),
        QuizQuestion(
          question:
              'ما اسم مركبة ناسا الجوالة التي هبطت على المريخ في فبراير 2021؟',
          options: [
            'كيوريوسيتي',
            'برسيفيرنس (المثابرة)',
            'سبيريت',
            'أوبورتيونيتي'
          ],
          correctIndex: 1,
          explanation: 'هبطت المثابرة في فوهة جيزيرو في 18 فبراير 2021.',
        ),
        QuizQuestion(
          question: 'أي كوكب يدور حول الشمس وهو مائل على جانبه تقريباً؟',
          options: ['نبتون', 'أورانوس', 'زحل', 'المشتري'],
          correctIndex: 1,
          explanation: 'ميل محور أورانوس نحو 98 درجة.',
        ),
        QuizQuestion(
          question: 'ما أشد كواكب المجموعة الشمسية حرارة؟',
          options: ['عطارد', 'الزهرة', 'المريخ', 'المشتري'],
          correctIndex: 1,
          explanation:
              'الزهرة أسخن بسبب غلافها الكثيف الغني بثاني أكسيد الكربون.',
        ),
        QuizQuestion(
          question: 'كم يوماً تقريباً تستغرق الأرض لتدور دورة كاملة حول الشمس؟',
          options: ['300', '365', '400', '500'],
          correctIndex: 1,
          explanation: 'نحو 365 يوماً وربع، ولهذا توجد السنة الكبيسة.',
        ),
        QuizQuestion(
          question: 'ما اسم أول كائن حي أُرسل إلى مدار الأرض؟',
          options: ['لايكا', 'بلكا', 'هام', 'لاكي'],
          correctIndex: 0,
          explanation: 'الكلبة لايكا أُرسلت على متن سبوتنيك 2 عام 1957.',
        ),
        QuizQuestion(
          question: 'كل كم سنة يمر مذنب هالي قرب الأرض تقريباً؟',
          options: ['76 سنة', '10 سنوات', '200 سنة', '500 سنة'],
          correctIndex: 0,
          explanation: 'دورته نحو 75-76 سنة، وآخر ظهور له كان عام 1986.',
        ),
        QuizQuestion(
          question: 'ما التلسكوب الفضائي الذي أُطلق في ديسمبر 2021؟',
          options: ['هابل', 'جيمس ويب', 'كبلر', 'تشاندرا'],
          correctIndex: 1,
          explanation: 'تلسكوب جيمس ويب يرصد بالأشعة تحت الحمراء.',
        ),
        QuizQuestion(
          question: 'أي من هذه الكواكب أصغر من الأرض؟',
          options: ['المريخ', 'نبتون', 'زحل', 'أورانوس'],
          correctIndex: 0,
          explanation: 'قطر المريخ نحو نصف قطر الأرض تقريباً.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🎨 المرحلة 8 — الفن والثقافة (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 8,
      title: 'الفن والثقافة',
      icon: '🎨',
      color: Color(0xFFEF5350),
      requiredScore: 350,
      questions: [
        QuizQuestion(
          question: 'من رسم لوحة الموناليزا؟',
          options: ['مايكل أنجلو', 'رافائيل', 'ليوناردو دافنشي', 'رمبرانت'],
          correctIndex: 2,
          explanation: 'رسم ليوناردو دافنشي الموناليزا بين 1503 و1519.',
        ),
        QuizQuestion(
          question: 'ما اللغة الرسمية في البرازيل؟',
          options: ['الإسبانية', 'البرتغالية', 'الإنجليزية', 'الفرنسية'],
          correctIndex: 1,
          explanation:
              'اللغة البرتغالية رسمية في البرازيل بسبب الاستعمار البرتغالي.',
        ),
        QuizQuestion(
          question: 'من ألّف سيمفونية "القدر"؟',
          options: ['موزارت', 'باخ', 'بتهوفن', 'شوبان'],
          correctIndex: 2,
          explanation: 'لودفيغ فان بتهوفن ألّف السيمفونية الخامسة "القدر".',
        ),
        QuizQuestion(
          question: 'ما أكثر اللغات انتشاراً في العالم بعدد المتحدثين؟',
          options: ['الإنجليزية', 'الإسبانية', 'الماندرين', 'الهندية'],
          correctIndex: 2,
          explanation: 'الصينية الماندرين أكثر لغة بعدد المتحدثين الأصليين.',
        ),
        QuizQuestion(
          question: 'في أي بلد وُلد موزارت؟',
          options: ['ألمانيا', 'فرنسا', 'النمسا', 'إيطاليا'],
          correctIndex: 2,
          explanation: 'وُلد موزارت في سالزبورغ، النمسا عام 1756.',
        ),
        QuizQuestion(
          question: 'من كتب رواية "ألف ليلة وليلة"؟',
          options: ['أبو نواس', 'ابن بطوطة', 'تراث شعبي مجهول', 'الجاحظ'],
          correctIndex: 2,
          explanation: 'ألف ليلة وليلة تراث شعبي تراكمي لا مؤلف محدد له.',
        ),
        QuizQuestion(
          question: 'من نحت تمثال "داود" الشهير؟',
          options: ['دافنشي', 'رافائيل', 'بيكاسو', 'مايكل أنجلو'],
          correctIndex: 3,
          explanation: 'نحت مايكل أنجلو تمثال داود بين 1501 و1504.',
        ),
        QuizQuestion(
          question: 'في أي قرن بُنيت سور الصين العظيم؟',
          options: [
            'القرن الثالث ق.م',
            'القرن الأول م',
            'القرن العاشر م',
            'القرن الخامس عشر م'
          ],
          correctIndex: 0,
          explanation: 'بدأ بناء سور الصين العظيم في القرن الثالث قبل الميلاد.',
        ),
        QuizQuestion(
          question: 'ما أشهر متحف في العالم؟',
          options: [
            'المتحف البريطاني',
            'متحف اللوفر',
            'متحف الميترو',
            'متحف الأرميتاج'
          ],
          correctIndex: 1,
          explanation: 'متحف اللوفر في باريس أشهر متاحف العالم وأكثرها زواراً.',
        ),
        QuizQuestion(
          question: 'ما الأداة الموسيقية التي تحتوي على أكبر عدد من الأوتار؟',
          options: ['الكمان', 'الجيتار', 'البيانو', 'القيثارة'],
          correctIndex: 2,
          explanation: 'البيانو يحتوي على 230 وتراً تقريباً.',
        ),
        QuizQuestion(
          question: 'ما الحرف الأكثر استخداماً في اللغة العربية؟',
          options: ['الألف', 'الباء', 'العين', 'اللام'],
          correctIndex: 0,
          explanation: 'الألف أكثر الحروف شيوعاً في النصوص العربية.',
        ),
        QuizQuestion(
          question: 'كم عدد حروف اللغة العربية؟',
          options: ['26', '28', '30', '32'],
          correctIndex: 1,
          explanation: 'اللغة العربية تحتوي على 28 حرفاً.',
        ),
        QuizQuestion(
          question: 'من كتب المقامات الأدبية؟',
          options: ['الجاحظ', 'بديع الزمان الهمذاني', 'المتنبي', 'ابن خلدون'],
          correctIndex: 1,
          explanation: 'بديع الزمان الهمذاني مؤسس فن المقامات الأدبية.',
        ),
        QuizQuestion(
          question: 'في أي بلد يقع متحف الأرميتاج؟',
          options: ['فرنسا', 'إيطاليا', 'روسيا', 'النمسا'],
          correctIndex: 2,
          explanation: 'متحف الأرميتاج يقع في سان بطرسبرغ، روسيا.',
        ),
        QuizQuestion(
          question: 'ما جنسية الرسام فنسنت فان غوخ؟',
          options: ['فرنسية', 'بلجيكية', 'هولندية', 'ألمانية'],
          correctIndex: 2,
          explanation: 'فان غوخ رسام هولندي اشتُهر بعد وفاته.',
        ),
        QuizQuestion(
          question: 'من مؤلف رواية "الحرب والسلام"؟',
          options: [
            'فيودور دوستويفسكي',
            'ليو تولستوي',
            'أنطون تشيخوف',
            'ماكسيم غوركي'
          ],
          correctIndex: 1,
          explanation: 'كتب الروائي الروسي ليو تولستوي رواية "الحرب والسلام".',
        ),
        QuizQuestion(
          question: 'من مؤلف ملحمة "الإلياذة"؟',
          options: ['أفلاطون', 'أرسطو', 'هوميروس', 'سقراط'],
          correctIndex: 2,
          explanation:
              'يُنسب تأليف ملحمتي الإلياذة والأوديسة إلى الشاعر الإغريقي هوميروس.',
        ),
        QuizQuestion(
          question:
              'ما الطراز المعماري المعروف بأقواسه المدببة ونوافذه الزجاجية الملونة؟',
          options: [
            'الطراز الكلاسيكي',
            'الطراز القوطي',
            'الطراز الباروكي',
            'الطراز الحديث'
          ],
          correctIndex: 1,
          explanation:
              'الطراز القوطي (Gothic) اشتُهر بالأقواس المدببة والنوافذ الزجاجية الملونة في كاتدرائيات أوروبا.',
        ),
        QuizQuestion(
          question: 'من رسم لوحة "الصرخة" الشهيرة؟',
          options: [
            'بابلو بيكاسو',
            'سلفادور دالي',
            'إدوارد مونك',
            'كلود مونيه'
          ],
          correctIndex: 2,
          explanation:
              'رسم الفنان النرويجي إدوارد مونك لوحة "الصرخة" عام 1893.',
        ),
        QuizQuestion(
          question: 'ما اللغة الأكثر استخداماً في محتوى الإنترنت عالمياً؟',
          options: ['الإسبانية', 'الإنجليزية', 'العربية', 'الفرنسية'],
          correctIndex: 1,
          explanation:
              'تبقى الإنجليزية اللغة الأكثر استخداماً في محتوى مواقع الإنترنت.',
        ),
        QuizQuestion(
          question: 'من رسم لوحة "ليلة النجوم"؟',
          options: ['فان غوخ', 'مونيه', 'دالي', 'ماتيس'],
          correctIndex: 0,
          explanation: 'رسمها فنسنت فان غوخ عام 1889.',
        ),
        QuizQuestion(
          question: 'من مؤلف رواية "دون كيخوته"؟',
          options: ['ميغيل دي ثربانتس', 'لوركا', 'ماركيز', 'بورخيس'],
          correctIndex: 0,
          explanation: 'كتبها الإسباني ثربانتس وصدر جزؤها الأول عام 1605.',
        ),
        QuizQuestion(
          question: 'من مؤلف "الأمير الصغير"؟',
          options: [
            'أنطوان دو سانت إكزوبيري',
            'فيكتور هوغو',
            'ألبير كامو',
            'جول فيرن'
          ],
          correctIndex: 0,
          explanation: 'صدرت الرواية عام 1943 وهي من أكثر الكتب ترجمةً.',
        ),
        QuizQuestion(
          question: 'في أي عام نال نجيب محفوظ جائزة نوبل في الأدب؟',
          options: ['1978', '1988', '1998', '2008'],
          correctIndex: 1,
          explanation:
              'نال نجيب محفوظ نوبل عام 1988، وهو أول عربي يفوز بها في الأدب.',
        ),
        QuizQuestion(
          question: 'ما الآلة الموسيقية العربية ذات الشكل الكمثري والأوتار؟',
          options: ['القانون', 'العود', 'الناي', 'الطبلة'],
          correctIndex: 1,
          explanation: 'العود من أشهر الآلات الوترية في الموسيقى العربية.',
        ),
        QuizQuestion(
          question: 'ما جنسية الفنان بابلو بيكاسو؟',
          options: ['فرنسي', 'إسباني', 'إيطالي', 'برتغالي'],
          correctIndex: 1,
          explanation: 'وُلد بيكاسو في ملقة بإسبانيا.',
        ),
        QuizQuestion(
          question: 'أي مسرحية لشكسبير بطلها أمير دنماركي؟',
          options: ['هاملت', 'عطيل', 'ماكبث', 'الملك لير'],
          correctIndex: 0,
          explanation: 'مسرحية هاملت أمير الدنمارك.',
        ),
        QuizQuestion(
          question: 'ما اسم فن طي الورق الياباني؟',
          options: ['أوريغامي', 'إيكيبانا', 'بونساي', 'كاليغرافي'],
          correctIndex: 0,
          explanation: 'الأوريغامي فن تشكيل الورق بالطي دون قص أو لصق.',
        ),
        QuizQuestion(
          question: 'من مؤلف السيرة الذاتية "الأيام"؟',
          options: ['طه حسين', 'عباس العقاد', 'توفيق الحكيم', 'المازني'],
          correctIndex: 0,
          explanation: 'كتب طه حسين "الأيام" وروى فيها طفولته وشبابه.',
        ),
        QuizQuestion(
          question: 'كم عدد أوتار الكمان؟',
          options: ['3', '4', '5', '6'],
          correctIndex: 1,
          explanation: 'للكمان أربعة أوتار مضبوطة على سول ري لا مي.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🏥 المرحلة 9 — الطب والصحة (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 9,
      title: 'الطب والصحة',
      icon: '🏥',
      color: Color(0xFF26C6DA),
      requiredScore: 400,
      questions: [
        QuizQuestion(
          question: 'كم عدد عظام جسم الإنسان البالغ؟',
          options: ['106', '206', '306', '406'],
          correctIndex: 1,
          explanation: 'جسم الإنسان البالغ يحتوي على 206 عظمة.',
        ),
        QuizQuestion(
          question: 'ما أكبر عضو في جسم الإنسان؟',
          options: ['الكبد', 'الجلد', 'الدماغ', 'الرئة'],
          correctIndex: 1,
          explanation: 'الجلد أكبر عضو بمساحة 1.5 - 2 متر مربع.',
        ),
        QuizQuestion(
          question: 'ما درجة الحرارة الطبيعية للجسم؟',
          options: ['35°C', '36.5 - 37.5°C', '38 - 39°C', '40°C'],
          correctIndex: 1,
          explanation: 'الحرارة الطبيعية بين 36.5 و37.5 درجة مئوية.',
        ),
        QuizQuestion(
          question: 'ما الفيتامين الذي نحصل عليه من أشعة الشمس؟',
          options: ['A', 'B12', 'C', 'D'],
          correctIndex: 3,
          explanation:
              'فيتامين D يُصنع في الجلد عند التعرض للأشعة فوق البنفسجية.',
        ),
        QuizQuestion(
          question: 'كم مرة يضرب القلب السليم في الدقيقة تقريباً؟',
          options: ['40-50', '60-100', '120-150', '150-200'],
          correctIndex: 1,
          explanation: 'معدل ضربات القلب الطبيعي 60-100 نبضة في الدقيقة.',
        ),
        QuizQuestion(
          question: 'ما أكبر غدة في الجسم؟',
          options: ['الكبد', 'البنكرياس', 'الغدة الدرقية', 'الكلية'],
          correctIndex: 0,
          explanation: 'الكبد أكبر غدة في الجسم ويزن نحو 1.5 كيلوجرام.',
        ),
        QuizQuestion(
          question: 'ما اسم الجزء من الدم المسؤول عن نقل الأكسجين؟',
          options: [
            'الصفائح',
            'البلازما',
            'كريات الدم الحمراء',
            'كريات الدم البيضاء'
          ],
          correctIndex: 2,
          explanation:
              'كريات الدم الحمراء تحتوي على الهيموجلوبين الذي ينقل الأكسجين.',
        ),
        QuizQuestion(
          question: 'كم طول الأمعاء الدقيقة لدى الإنسان؟',
          options: ['2-3 متر', '4-5 متر', '6-7 متر', '10-12 متر'],
          correctIndex: 2,
          explanation: 'الأمعاء الدقيقة يتراوح طولها بين 6 و7 أمتار.',
        ),
        QuizQuestion(
          question: 'ما الفيروس المسبّب لمرض الإيدز؟',
          options: ['HPV', 'HIV', 'HCV', 'HBV'],
          correctIndex: 1,
          explanation: 'HIV اختصار Human Immunodeficiency Virus مسبّب الإيدز.',
        ),
        QuizQuestion(
          question: 'كم عدد أسنان طفل اللبن؟',
          options: ['16', '18', '20', '24'],
          correctIndex: 2,
          explanation: 'يملك الطفل 20 سناً لبنياً.',
        ),
        QuizQuestion(
          question: 'ما أسرع جزء من الجهاز العصبي في نقل الإشارات؟',
          options: [
            'النخاع الشوكي',
            'الألياف العصبية الحسية',
            'الألياف العصبية الحركية المغلّفة',
            'الدماغ'
          ],
          correctIndex: 2,
          explanation:
              'الألياف الحركية المغلّفة بالمايلين تنقل الإشارات بسرعة 70-120 م/ث.',
        ),
        QuizQuestion(
          question: 'ما اسم العلم الذي يختص بدراسة الجلد؟',
          options: ['علم الأعصاب', 'علم الأمراض', 'الجلدية', 'علم العظام'],
          correctIndex: 2,
          explanation: 'الجلدية (Dermatology) هي تخصص طبي لدراسة الجلد.',
        ),
        QuizQuestion(
          question: 'ما الغدة المسؤولة عن إفراز الأنسولين؟',
          options: [
            'الغدة الكظرية',
            'الغدة الدرقية',
            'البنكرياس',
            'الغدة النخامية'
          ],
          correctIndex: 2,
          explanation: 'البنكرياس يُفرز الأنسولين المسؤول عن تنظيم سكر الدم.',
        ),
        QuizQuestion(
          question: 'ما أطول عظمة في الجسم؟',
          options: ['عظمة الفخذ', 'عظمة الذراع', 'العمود الفقري', 'عظمة الساق'],
          correctIndex: 0,
          explanation: 'عظمة الفخذ (Femur) أطول وأقوى عظمة في الجسم.',
        ),
        QuizQuestion(
          question: 'ما عدد فصائل الدم الرئيسية في نظام ABO؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation: 'فصائل الدم الأربعة هي: A، B، AB، O.',
        ),
        QuizQuestion(
          question: 'ما اسم الهرمون الذي يُعرف بـ"هرمون التوتر"؟',
          options: ['الإنسولين', 'الكورتيزول', 'الأدرينالين', 'الميلاتونين'],
          correctIndex: 1,
          explanation: 'الكورتيزول يُفرز استجابة للتوتر ويُعرف بهرمون التوتر.',
        ),
        QuizQuestion(
          question: 'كم عدد حجرات القلب البشري؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation: 'يتكون القلب من 4 حجرات: أذينان وبطينان.',
        ),
        QuizQuestion(
          question: 'أي فيتامين مسؤول بشكل أساسي عن عملية تخثر الدم؟',
          options: ['فيتامين A', 'فيتامين C', 'فيتامين D', 'فيتامين K'],
          correctIndex: 3,
          explanation: 'فيتامين K ضروري لتصنيع عوامل التخثر في الدم.',
        ),
        QuizQuestion(
          question: 'ما العضو المسؤول عن تصفية الفضلات من الدم؟',
          options: ['الكبد', 'الكلى', 'الطحال', 'المعدة'],
          correctIndex: 1,
          explanation: 'الكليتان تقومان بتصفية الدم من الفضلات وإنتاج البول.',
        ),
        QuizQuestion(
          question:
              'ما اسم المرض الناتج عن نقص إفراز الأنسولين أو مقاومة الجسم له؟',
          options: ['فقر الدم', 'مرض السكري', 'الربو', 'النقرس'],
          correctIndex: 1,
          explanation: 'مرض السكري ينتج عن نقص الأنسولين أو مقاومة الجسم له.',
        ),
        QuizQuestion(
          question: 'نقص أي فيتامين يسبب مرض الإسقربوط؟',
          options: ['A', 'B1', 'C', 'D'],
          correctIndex: 2,
          explanation: 'نقص فيتامين C يسبب الإسقربوط ونزف اللثة.',
        ),
        QuizQuestion(
          question: 'نقص الحديد قد يؤدي إلى؟',
          options: ['فقر الدم', 'السكري', 'الربو', 'النقرس'],
          correctIndex: 0,
          explanation: 'الحديد ضروري لتكوين الهيموغلوبين.',
        ),
        QuizQuestion(
          question: 'أي عضو ينتج العصارة الصفراوية؟',
          options: ['المرارة', 'الكبد', 'المعدة', 'البنكرياس'],
          correctIndex: 1,
          explanation: 'ينتجها الكبد وتُخزَّن في المرارة.',
        ),
        QuizQuestion(
          question: 'كم تبلغ نسبة الماء تقريباً في جسم الإنسان البالغ؟',
          options: ['20%', '40%', '60%', '90%'],
          correctIndex: 2,
          explanation: 'نحو 60% من وزن الجسم ماء.',
        ),
        QuizQuestion(
          question: 'ما أصغر عظمة في جسم الإنسان؟',
          options: ['الركاب', 'المطرقة', 'الرضفة', 'الزند'],
          correctIndex: 0,
          explanation: 'الركاب عظمة صغيرة في الأذن الوسطى.',
        ),
        QuizQuestion(
          question: 'ما الجهاز المستخدم لقياس ضغط الدم؟',
          options: [
            'الترمومتر',
            'مقياس ضغط الدم',
            'السماعة الطبية',
            'منظار الأذن'
          ],
          correctIndex: 1,
          explanation: 'يُقاس الضغط بجهاز السفيغمومانومتر.',
        ),
        QuizQuestion(
          question: 'أي خلايا الدم تقوم بدور أساسي في المناعة؟',
          options: [
            'كريات الدم البيضاء',
            'كريات الدم الحمراء',
            'الصفائح',
            'البلازما'
          ],
          correctIndex: 0,
          explanation: 'كريات الدم البيضاء تحارب الجراثيم والفيروسات.',
        ),
        QuizQuestion(
          question: 'أي من هذه الأمراض يسببه فيروس؟',
          options: ['الإنفلونزا', 'الكوليرا', 'السل', 'الملاريا'],
          correctIndex: 0,
          explanation:
              'الإنفلونزا فيروسية، أما الكوليرا والسل فبكتيريان، والملاريا طفيلي.',
        ),
        QuizQuestion(
          question: 'أي عنصر هو المكون الرئيسي لبناء العظام والأسنان؟',
          options: ['الكالسيوم', 'الصوديوم', 'البوتاسيوم', 'اليود'],
          correctIndex: 0,
          explanation: 'الكالسيوم أساسي لقوة العظام والأسنان.',
        ),
        QuizQuestion(
          question: 'كم ساعة نوم يُوصى بها غالباً للبالغين يومياً؟',
          options: ['3-4', '7-9', '10-12', '12-14'],
          correctIndex: 1,
          explanation: 'توصي الجهات الصحية عادةً بـ 7 إلى 9 ساعات للبالغين.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 👑 المرحلة 10 — التحدي الأخير (30 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 10,
      title: 'التحدي الأخير',
      icon: '👑',
      color: Color(0xFFFFB300),
      requiredScore: 450,
      questions: [
        QuizQuestion(
          question: 'ما أعمق نقطة في المحيطات؟',
          options: [
            'خندق تونغا',
            'خندق بورتوريكو',
            'خندق ماريانا',
            'خندق يافان'
          ],
          correctIndex: 2,
          explanation: 'خندق ماريانا في المحيط الهادئ عمقه 11,034 متراً.',
        ),
        QuizQuestion(
          question: 'ما أكثر العناصر وفرة في الكون؟',
          options: ['الأكسجين', 'الكربون', 'الهيدروجين', 'الهيليوم'],
          correctIndex: 2,
          explanation: 'الهيدروجين يمثّل حوالي 75% من كتلة الكون المرئية.',
        ),
        QuizQuestion(
          question: 'من طوّر نظرية النسبية؟',
          options: ['نيوتن', 'آينشتاين', 'هوكينغ', 'بلانك'],
          correctIndex: 1,
          explanation:
              'ألبرت آينشتاين طوّر النسبية الخاصة (1905) والعامة (1915).',
        ),
        QuizQuestion(
          question: 'كم عدد الدول الأعضاء في الأمم المتحدة؟',
          options: ['163', '183', '193', '203'],
          correctIndex: 2,
          explanation: 'الأمم المتحدة تضم 193 دولة عضواً حتى 2025.',
        ),
        QuizQuestion(
          question: 'ما أقدم جامعة تعمل حتى اليوم؟',
          options: ['أكسفورد', 'القرويين', 'بولونيا', 'الأزهر'],
          correctIndex: 1,
          explanation: 'جامعة القرويين في المغرب أُسست عام 859 م وهي الأقدم.',
        ),
        QuizQuestion(
          question: 'ما الجسيم الذي يُعرف بـ"جسيم الله"؟',
          options: ['الإلكترون', 'البروتون', 'بوزون هيغز', 'النيوترون'],
          correctIndex: 2,
          explanation: 'اكتُشف بوزون هيغز عام 2012 في مختبر CERN.',
        ),
        QuizQuestion(
          question: 'كم عدد نجوم علم الولايات المتحدة؟',
          options: ['48', '49', '50', '52'],
          correctIndex: 2,
          explanation: 'علم الولايات المتحدة يحتوي على 50 نجمة تمثّل الولايات.',
        ),
        QuizQuestion(
          question: 'ما المادة الأصلب في جسم الإنسان؟',
          options: ['العظام', 'مينا الأسنان', 'الأظافر', 'الغضاريف'],
          correctIndex: 1,
          explanation: 'مينا الأسنان (Enamel) أصلب مادة في جسم الإنسان.',
        ),
        QuizQuestion(
          question: 'كم عدد ألوان الطيف المرئي؟',
          options: ['5', '6', '7', '8'],
          correctIndex: 2,
          explanation:
              'الطيف المرئي يتكون من 7 ألوان: أحمر وبرتقالي وأصفر وأخضر وأزرق ونيلي وبنفسجي.',
        ),
        QuizQuestion(
          question: 'ما اسم أول روبوت يحصل على الجنسية؟',
          options: ['أسيمو', 'صوفيا', 'أطلس', 'ناو'],
          correctIndex: 1,
          explanation:
              'صوفيا روبوت من Hanson Robotics حصل على جنسية سعودية عام 2017.',
        ),
        QuizQuestion(
          question: 'كم تبلغ مساحة القارة القطبية الجنوبية؟',
          options: [
            '7 مليون كم²',
            '14 مليون كم²',
            '20 مليون كم²',
            '28 مليون كم²'
          ],
          correctIndex: 1,
          explanation: 'مساحة أنتاركتيكا نحو 14 مليون كيلومتر مربع.',
        ),
        QuizQuestion(
          question: 'ما أكبر صحراء في العالم؟',
          options: [
            'الصحراء الكبرى',
            'صحراء غوبي',
            'صحراء أنتاركتيكا',
            'صحراء العرب'
          ],
          correctIndex: 2,
          explanation:
              'صحراء أنتاركتيكا أكبر صحراء (باردة) بمساحة 14 مليون كم².',
        ),
        QuizQuestion(
          question: 'كم عدد كروموسومات الإنسان السليم؟',
          options: ['44', '46', '48', '50'],
          correctIndex: 1,
          explanation: 'الإنسان السليم يحتوي على 46 كروموسوماً (23 زوجاً).',
        ),
        QuizQuestion(
          question: 'ما أثقل عنصر مُكتشف في الجدول الدوري (أعلى رقم ذري)؟',
          options: ['اليورانيوم', 'البلوتونيوم', 'الأوغانيسون', 'الرادون'],
          correctIndex: 2,
          explanation:
              'الأوغانيسون (Og) رقمه الذري 118 وهو أعلى العناصر المكتشفة رقماً ذرياً.',
        ),
        QuizQuestion(
          question: 'ما الكمية الفيزيائية التي تقاس بالمول؟',
          options: ['الكتلة', 'الحجم', 'كمية المادة', 'درجة الحرارة'],
          correctIndex: 2,
          explanation: 'المول هو وحدة قياس كمية المادة في نظام SI.',
        ),
        QuizQuestion(
          question: 'ما اسم أول عنصر في الجدول الدوري؟',
          options: ['الهيليوم', 'الهيدروجين', 'الكربون', 'الليثيوم'],
          correctIndex: 1,
          explanation:
              'الهيدروجين هو العنصر الأول في الجدول الدوري برقم ذري 1.',
        ),
        QuizQuestion(
          question: 'كم عدد عظام جمجمة الإنسان البالغ؟',
          options: ['14', '18', '22', '26'],
          correctIndex: 2,
          explanation: 'تتكون جمجمة الإنسان البالغ من 22 عظمة متصلة.',
        ),
        QuizQuestion(
          question: 'من صاحب نظرية التطور بالانتخاب الطبيعي؟',
          options: [
            'غريغور مندل',
            'تشارلز داروين',
            'لويس باستور',
            'ألفريد فيغنر'
          ],
          correctIndex: 1,
          explanation:
              'طرح تشارلز داروين نظرية التطور بالانتخاب الطبيعي في كتابه "أصل الأنواع".',
        ),
        QuizQuestion(
          question:
              'ما اسم أصغر وحدة في المادة تحتفظ بخصائص العنصر الكيميائية؟',
          options: ['الجزيء', 'الذرة', 'الإلكترون', 'الخلية'],
          correctIndex: 1,
          explanation:
              'الذرة هي أصغر وحدة بنائية تحتفظ بخصائص العنصر الكيميائية.',
        ),
        QuizQuestion(
          question:
              'ما اسم الوثيقة التي حدّت من سلطة الملك في إنجلترا عام 1215؟',
          options: [
            'الماغنا كارتا',
            'إعلان الاستقلال',
            'العهد الأطلسي',
            'ميثاق باريس'
          ],
          correctIndex: 0,
          explanation:
              'وثيقة الماغنا كارتا عام 1215 قيّدت سلطة الملك الإنجليزي لأول مرة.',
        ),
        QuizQuestion(
          question: 'ما أعلى شلال في العالم؟',
          options: ['نياغارا', 'أنجل', 'فيكتوريا', 'إغواسو'],
          correctIndex: 1,
          explanation: 'شلال أنجل في فنزويلا ارتفاعه نحو 979 متراً.',
        ),
        QuizQuestion(
          question: 'ما العملة الرسمية لليابان؟',
          options: ['اليوان', 'الين', 'الوون', 'الروبية'],
          correctIndex: 1,
          explanation: 'عملة اليابان هي الين.',
        ),
        QuizQuestion(
          question: 'ما أصغر دولة عربية من حيث المساحة؟',
          options: ['قطر', 'البحرين', 'الكويت', 'لبنان'],
          correctIndex: 1,
          explanation: 'مساحة البحرين نحو 780 كم² تقريباً.',
        ),
        QuizQuestion(
          question: 'من العالم الذي يُنسب إليه تأسيس علم الجبر؟',
          options: ['الخوارزمي', 'ابن سينا', 'الرازي', 'ابن الهيثم'],
          correctIndex: 0,
          explanation: 'ألّف الخوارزمي كتاب "الجبر والمقابلة".',
        ),
        QuizQuestion(
          question: 'من العالم المسلم الملقب بأبي علم البصريات؟',
          options: ['ابن الهيثم', 'الفارابي', 'البيروني', 'جابر بن حيان'],
          correctIndex: 0,
          explanation:
              'ألّف ابن الهيثم كتاب المناظر وأسس منهجاً تجريبياً في البصريات.',
        ),
        QuizQuestion(
          question: 'ما قيمة العدد π تقريباً؟',
          options: ['2.71', '3.14', '1.62', '1.41'],
          correctIndex: 1,
          explanation: 'π ≈ 3.14159 وهو نسبة محيط الدائرة إلى قطرها.',
        ),
        QuizQuestion(
          question: 'كم عدد الأعداد الأولية بين 1 و10؟',
          options: ['3', '4', '5', '6'],
          correctIndex: 1,
          explanation: 'هي 2 و3 و5 و7.',
        ),
        QuizQuestion(
          question: 'ما أطول سلسلة جبلية على اليابسة؟',
          options: ['الهيمالايا', 'الأنديز', 'روكي', 'الألب'],
          correctIndex: 1,
          explanation:
              'الأنديز تمتد نحو 7000 كم على امتداد غرب أمريكا الجنوبية.',
        ),
        QuizQuestion(
          question: 'ما اسم الكتاب الطبي الشهير لابن سينا؟',
          options: ['الحاوي', 'القانون في الطب', 'التصريف', 'المنصوري'],
          correctIndex: 1,
          explanation:
              'ظل "القانون في الطب" مرجعاً في الجامعات الأوروبية قروناً.',
        ),
        QuizQuestion(
          question: 'كم دقيقة في اليوم الواحد؟',
          options: ['1200', '1440', '1640', '2400'],
          correctIndex: 1,
          explanation: '24 ساعة × 60 دقيقة = 1440 دقيقة.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🕌 المرحلة 11 — المعرفة الدينية (22 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 11,
      title: 'المعرفة الدينية',
      icon: '🕌',
      color: Color(0xFF00897B),
      requiredScore: 500,
      questions: [
        QuizQuestion(
          question: 'كم عدد أركان الإسلام؟',
          options: ['3', '4', '5', '6'],
          correctIndex: 2,
          explanation:
              'أركان الإسلام خمسة: الشهادتان، الصلاة، الزكاة، الصوم، الحج.',
        ),
        QuizQuestion(
          question: 'في أي شهر هجري يصوم المسلمون؟',
          options: ['شعبان', 'رمضان', 'شوال', 'رجب'],
          correctIndex: 1,
          explanation: 'يصوم المسلمون شهر رمضان، تاسع الأشهر الهجرية.',
        ),
        QuizQuestion(
          question: 'كم عدد الصلوات المفروضة في اليوم؟',
          options: ['3', '4', '5', '6'],
          correctIndex: 2,
          explanation: 'فرض الله على المسلمين خمس صلوات في اليوم والليلة.',
        ),
        QuizQuestion(
          question: 'ما اسم الكتاب المقدس عند المسلمين؟',
          options: ['التوراة', 'الإنجيل', 'القرآن الكريم', 'الزبور'],
          correctIndex: 2,
          explanation:
              'القرآن الكريم هو الكتاب المقدس ومصدر التشريع الأول عند المسلمين.',
        ),
        QuizQuestion(
          question: 'إلى أين يتوجه المسلمون في صلاتهم؟',
          options: [
            'المسجد الأقصى',
            'الكعبة المشرفة',
            'المدينة المنورة',
            'الشرق'
          ],
          correctIndex: 1,
          explanation:
              'يتوجه المسلمون في صلاتهم نحو الكعبة المشرفة في مكة المكرمة.',
        ),
        QuizQuestion(
          question: 'ما اسم الرحلة الليلية للنبي محمد ﷺ من مكة إلى القدس؟',
          options: ['الهجرة', 'الإسراء والمعراج', 'الفتح', 'الغزوة'],
          correctIndex: 1,
          explanation:
              'الإسراء والمعراج رحلة ليلية معجزة للنبي محمد ﷺ من مكة إلى المسجد الأقصى ثم إلى السماء.',
        ),
        QuizQuestion(
          question: 'كم عدد سور القرآن الكريم؟',
          options: ['104', '114', '124', '134'],
          correctIndex: 1,
          explanation: 'يحتوي القرآن الكريم على 114 سورة.',
        ),
        QuizQuestion(
          question: 'ما اسم أول سورة نزلت من القرآن الكريم؟',
          options: ['الفاتحة', 'البقرة', 'العلق', 'الإخلاص'],
          correctIndex: 2,
          explanation:
              'نزلت أوائل سورة العلق (اقرأ باسم ربك) أول ما نزل من القرآن.',
        ),
        QuizQuestion(
          question:
              'ما اسم الركن الخامس من أركان الإسلام المتعلق بالسفر إلى مكة؟',
          options: ['الزكاة', 'الصوم', 'الحج', 'الشهادة'],
          correctIndex: 2,
          explanation:
              'الحج هو الركن الخامس، ويكون بزيارة مكة المكرمة في وقت محدد لمن استطاع.',
        ),
        QuizQuestion(
          question: 'ما اسم زوجة النبي محمد ﷺ الأولى؟',
          options: [
            'عائشة بنت أبي بكر',
            'خديجة بنت خويلد',
            'حفصة بنت عمر',
            'صفية بنت حيي'
          ],
          correctIndex: 1,
          explanation:
              'خديجة بنت خويلد كانت أول زوجات النبي محمد ﷺ وأول من آمن به.',
        ),
        QuizQuestion(
          question: 'ما اسم الصدقة الواجبة التي تُخرج في عيد الفطر؟',
          options: ['زكاة المال', 'زكاة الفطر', 'الصدقة الجارية', 'الكفارة'],
          correctIndex: 1,
          explanation: 'زكاة الفطر صدقة واجبة تُخرج قبل صلاة عيد الفطر.',
        ),
        QuizQuestion(
          question: 'كم عدد الأشهر في السنة الهجرية؟',
          options: ['10', '11', '12', '13'],
          correctIndex: 2,
          explanation: 'السنة الهجرية القمرية تتكون من 12 شهراً.',
        ),
        QuizQuestion(
          question: 'ما أطول سورة في القرآن الكريم؟',
          options: ['آل عمران', 'البقرة', 'النساء', 'المائدة'],
          correctIndex: 1,
          explanation: 'سورة البقرة وآياتها 286 آية.',
        ),
        QuizQuestion(
          question: 'ما أقصر سورة في القرآن الكريم؟',
          options: ['الإخلاص', 'الكوثر', 'العصر', 'النصر'],
          correctIndex: 1,
          explanation: 'سورة الكوثر وآياتها ثلاث.',
        ),
        QuizQuestion(
          question: 'ما أولى الغزوات الكبرى في الإسلام؟',
          options: ['أحد', 'بدر', 'الخندق', 'حنين'],
          correctIndex: 1,
          explanation: 'كانت غزوة بدر الكبرى في رمضان سنة 2 هـ.',
        ),
        QuizQuestion(
          question: 'كم عدد الأنبياء المذكورين بأسمائهم في القرآن الكريم؟',
          options: ['20', '25', '30', '35'],
          correctIndex: 1,
          explanation: 'ذُكر خمسة وعشرون نبياً ورسولاً بأسمائهم.',
        ),
        QuizQuestion(
          question: 'ما أول مسجد بُني في الإسلام؟',
          options: [
            'المسجد النبوي',
            'مسجد قباء',
            'المسجد الأقصى',
            'مسجد القيروان'
          ],
          correctIndex: 1,
          explanation: 'بُني مسجد قباء عند وصول النبي ﷺ إلى المدينة.',
        ),
        QuizQuestion(
          question: 'أي سورة في القرآن لا تبدأ بالبسملة؟',
          options: ['التوبة', 'الأنفال', 'يونس', 'هود'],
          correctIndex: 0,
          explanation: 'سورة التوبة لا تبدأ بالبسملة.',
        ),
        QuizQuestion(
          question: 'كم عدد ركعات صلاة الفجر؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 0,
          explanation: 'صلاة الفجر ركعتان.',
        ),
        QuizQuestion(
          question: 'ما الجبل الذي يقف عنده الحجاج يوم عرفة؟',
          options: ['أحد', 'عرفة', 'ثور', 'النور'],
          correctIndex: 1,
          explanation: 'الوقوف بعرفة أعظم أركان الحج.',
        ),
        QuizQuestion(
          question: 'من هو أول مؤذن في الإسلام؟',
          options: [
            'بلال بن رباح',
            'عمار بن ياسر',
            'أبو ذر الغفاري',
            'سلمان الفارسي'
          ],
          correctIndex: 0,
          explanation: 'كان بلال بن رباح رضي الله عنه أول من أذّن للصلاة.',
        ),
        QuizQuestion(
          question: 'في أي عام ميلادي كانت هجرة النبي ﷺ إلى المدينة؟',
          options: ['610', '622', '632', '570'],
          correctIndex: 1,
          explanation: 'كانت الهجرة عام 622م وبها بدأ التقويم الهجري.',
        ),
      ],
    ),

    // ══════════════════════════════════════════════
    // 🧩 المرحلة 12 — الألغاز والذكاء (22 سؤال)
    // ══════════════════════════════════════════════
    QuizLevel(
      id: 12,
      title: 'الألغاز والذكاء',
      icon: '🧩',
      color: Color(0xFFEC407A),
      requiredScore: 550,
      questions: [
        QuizQuestion(
          question: 'لغز: ما الشيء الذي يزيد كلما أخذت منه؟',
          options: ['الماء', 'الحفرة', 'الخبز', 'الرمل'],
          correctIndex: 1,
          explanation: 'الحفرة تكبر كلما أخذت منها المزيد من التراب.',
        ),
        QuizQuestion(
          question: 'إذا كان اليوم الثلاثاء، فما اليوم بعد 3 أيام؟',
          options: ['الخميس', 'الجمعة', 'السبت', 'الأحد'],
          correctIndex: 1,
          explanation: 'ثلاثاء + 3 أيام = أربعاء، خميس، جمعة.',
        ),
        QuizQuestion(
          question: 'ما العدد الذي إذا ضربته في نفسه أعطى 81؟',
          options: ['7', '8', '9', '11'],
          correctIndex: 2,
          explanation: '9 × 9 = 81.',
        ),
        QuizQuestion(
          question:
              'أب وابنه تعرضا لحادث سيارة، الأب توفي فوراً ونُقل الابن للمستشفى، فقال الجراح: "لا أستطيع إجراء العملية فهذا ابني" فكيف يُفسَّر ذلك؟',
          options: [
            'كان الجراح يحلم',
            'الجراح هي والدة الطفل',
            'كان هناك أب آخر',
            'الطفل ليس ابنه فعلاً'
          ],
          correctIndex: 1,
          explanation:
              'الجراح هي والدة الطفل، وهذا لغز شهير يوضّح تحيّزنا الذهني في افتراض أن الطبيب رجل.',
        ),
        QuizQuestion(
          question: 'ما الحرف الذي يأتي بعد حرف "ت" في الأبجدية العربية؟',
          options: ['ب', 'ث', 'ج', 'خ'],
          correctIndex: 1,
          explanation: 'ترتيب الحروف: ...ب، ت، ث، ج...',
        ),
        QuizQuestion(
          question: 'كم عدد أضلاع الشكل السداسي؟',
          options: ['5', '6', '7', '8'],
          correctIndex: 1,
          explanation: 'الشكل السداسي له 6 أضلاع و6 زوايا.',
        ),
        QuizQuestion(
          question:
              'إذا كانت 5 قطط تصطاد 5 فئران في 5 دقائق، فكم قطة تحتاج لاصطياد 100 فأر في 100 دقيقة؟',
          options: ['5 قطط', '20 قطة', '100 قطة', '50 قطة'],
          correctIndex: 0,
          explanation:
              'كل قطة تصطاد فأراً واحداً كل 5 دقائق، فتصطاد 20 فأراً في 100 دقيقة، و5 قطط تصطاد 100 فأر بالضبط.',
        ),
        QuizQuestion(
          question: 'ما العدد الناقص في السلسلة: 2، 4، 8، 16، ...؟',
          options: ['18', '24', '32', '20'],
          correctIndex: 2,
          explanation: 'كل رقم هو ضعف الرقم الذي قبله، لذا الرقم التالي هو 32.',
        ),
        QuizQuestion(
          question: 'كم عدد الأحرف في كلمة "لغز"؟',
          options: ['2', '3', '4', '5'],
          correctIndex: 1,
          explanation: 'كلمة "لغز" تتكون من 3 أحرف: ل، غ، ز.',
        ),
        QuizQuestion(
          question: 'أي الأشكال التالية ليس له زوايا؟',
          options: ['المربع', 'المثلث', 'الدائرة', 'المستطيل'],
          correctIndex: 2,
          explanation: 'الدائرة شكل هندسي منحنٍ لا يحتوي على أي زوايا.',
        ),
        QuizQuestion(
          question: 'لغز: ما الشيء الذي له مفاتيح لكنه لا يفتح أي قفل؟',
          options: ['الباب', 'لوحة المفاتيح (البيانو)', 'الخزنة', 'السيارة'],
          correctIndex: 1,
          explanation:
              'لوحة مفاتيح البيانو أو الحاسوب لها "مفاتيح" لكنها لا تفتح أقفالاً.',
        ),
        QuizQuestion(
          question:
              'إذا استبدلنا كل حرف بالحرف الذي يليه مباشرة في الأبجدية، فماذا يصبح حرف "أ"؟',
          options: ['ت', 'ب', 'ث', 'ج'],
          correctIndex: 1,
          explanation: 'الحرف الذي يلي "أ" مباشرة في الترتيب الأبجدي هو "ب".',
        ),
        QuizQuestion(
          question: 'لغز: ما الشيء الذي يكتب ولا يقرأ؟',
          options: ['القلم', 'الكتاب', 'الورقة', 'الحبر'],
          correctIndex: 0,
          explanation: 'القلم يكتب لكنه لا يقرأ.',
        ),
        QuizQuestion(
          question: 'ما العدد التالي في المتتالية: 1، 1، 2، 3، 5، 8، ...؟',
          options: ['11', '12', '13', '15'],
          correctIndex: 2,
          explanation:
              'متتالية فيبوناتشي: كل عدد مجموع العددين السابقين (5+8=13).',
        ),
        QuizQuestion(
          question: 'ما ناتج: 15 + 15 ÷ 3؟',
          options: ['10', '20', '30', '25'],
          correctIndex: 1,
          explanation: 'القسمة أولاً: 15 ÷ 3 = 5، ثم 15 + 5 = 20.',
        ),
        QuizQuestion(
          question: 'لغز: ما الشيء الذي يمشي بلا أرجل؟',
          options: ['الوقت', 'الكرسي', 'الباب', 'الجدار'],
          correctIndex: 0,
          explanation: 'الوقت "يمشي" ويمر دون أرجل.',
        ),
        QuizQuestion(
          question: 'أي عدد من التالية يقبل القسمة على 2 و3 معاً؟',
          options: ['9', '12', '15', '20'],
          correctIndex: 1,
          explanation: '12 تقبل القسمة على 2 و3.',
        ),
        QuizQuestion(
          question: 'كم يوماً في شهر فبراير في السنة الكبيسة؟',
          options: ['27', '28', '29', '30'],
          correctIndex: 2,
          explanation: 'في السنة الكبيسة يكون فبراير 29 يوماً.',
        ),
        QuizQuestion(
          question: 'ما العدد الذي مربعه 144؟',
          options: ['11', '12', '13', '14'],
          correctIndex: 1,
          explanation: '12 × 12 = 144.',
        ),
        QuizQuestion(
          question: 'لغز: ما الشيء الذي كلما جفّف ابتلّ؟',
          options: ['الإسفنج', 'المنشفة', 'الصابون', 'الشمس'],
          correctIndex: 1,
          explanation: 'المنشفة تجفف غيرها فتبتل هي.',
        ),
        QuizQuestion(
          question: 'ما ناتج: نصف العدد 100 زائد 10؟',
          options: ['40', '50', '60', '110'],
          correctIndex: 2,
          explanation: 'نصف 100 يساوي 50، و50 + 10 = 60.',
        ),
        QuizQuestion(
          question: 'لغز: ما الشيء الذي له عين ولا يرى؟',
          options: ['الإبرة', 'الذبابة', 'الحجر', 'الباب'],
          correctIndex: 0,
          explanation: 'للإبرة "عين" هي ثقبها.',
        ),
      ],
    ),
  ];
}
