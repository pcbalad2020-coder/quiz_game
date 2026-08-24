import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

// خدمة الإشعارات: تذكير المستخدم باللعب يومياً الساعة 1 ظهراً و8 مساءً
class ReminderNotificationService {
  ReminderNotificationService._();
  static final ReminderNotificationService instance =
      ReminderNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _noonNotificationId = 1001;
  static const int _eveningNotificationId = 1002;

  Future<void> init() async {
    tz_data.initializeTimeZones();
    try {
      final localTz = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localTz.identifier));
    } catch (_) {
      // إن تعذر تحديد المنطقة الزمنية نستخدم UTC كخيار آمن
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings: initSettings);

    await _requestPermissions();
    await _scheduleDailyReminders();
  }

  Future<void> _requestPermissions() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
      await androidImpl.requestExactAlarmsPermission();
    }

    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      await iosImpl.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _scheduleDailyReminders() async {
    await _scheduleDaily(
      id: _noonNotificationId,
      hour: 13,
      minute: 0,
      title: 'لعبة الأسئلة 🧠',
      body: 'حان وقت اختبار معلوماتك! العب الآن واكسب المزيد من النقاط 🏆',
    );
    await _scheduleDaily(
      id: _eveningNotificationId,
      hour: 20,
      minute: 0,
      title: 'لعبة الأسئلة 🧠',
      body: 'لا تفوت جولتك اليومية! تحدَّ نفسك وأكمل مرحلة جديدة الآن 🎯',
    );
  }

  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'تذكير يومي',
          channelDescription: 'تذكير يومي بلعب لعبة الأسئلة',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
