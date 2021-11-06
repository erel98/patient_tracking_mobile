import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import './global.dart';

class BildirimAPI {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();
  static List<int> bildirimGunleri = [];
  static Future<List<int>> initNotificationDays() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isPazartesi')) bildirimGunleri.add(DateTime.monday);
    if (prefs.getBool('isSali')) bildirimGunleri.add(DateTime.tuesday);
    if (prefs.getBool('isCarsamba')) bildirimGunleri.add(DateTime.wednesday);
    if (prefs.getBool('isPersembe')) bildirimGunleri.add(DateTime.thursday);
    if (prefs.getBool('isCuma')) bildirimGunleri.add(DateTime.friday);
    if (prefs.getBool('isCumartesi')) bildirimGunleri.add(DateTime.saturday);
    if (prefs.getBool('isPazar')) bildirimGunleri.add(DateTime.sunday);

    return bildirimGunleri;
  }

  static Future<Time> initNotificationTime() async {
    var prefs = await SharedPreferences.getInstance();
    var hour = prefs.getInt('bildirim-saat');
    var minute = prefs.getInt('bildirim-dakika');

    return Time(hour, minute);
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.defaultImportance),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static void showScheduledNotification({
    int id = 0,
    String title,
    String body,
    String payload,
    DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          _scheduleWeekly(await initNotificationTime(),
              days: await initNotificationDays()),
          //_scheduleDaily(Time(8)),
          //TZDateTime.from(scheduledDate, local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
          //matchDateTimeComponents: DateTimeComponents.time
          );

  static TZDateTime _scheduleDaily(Time time) {
    final now = TZDateTime.now(local);
    final scheduledDate = TZDateTime(
      local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  static TZDateTime _scheduleWeekly(Time time, {List<int> days}) {
    TZDateTime scheduleDate = _scheduleDaily(time);

    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
}
