import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');
    var initilaiztionSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: ((id, title, body, payload) async {}));
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initilaiztionSettingsIOS,
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

//Get the stored importance
  Importance getImportance() {
    Importance importance;
    String value = Hive.box('settings').get(
      "notificationMode",
      defaultValue: 'Max',
    );
    switch (value) {
      case 'Max':
        importance = Importance.max;
        return importance;
      case 'High':
        importance = Importance.high;
        return importance;
      case 'low':
        importance = Importance.low;
        return importance;
      case 'min':
        importance = Importance.min;
        return importance;
      default:
        importance = Importance.max;
    }
    return importance;
  }

//#Gnerate unifue id for each notification
  int generateUniqueId() {
    Random random = Random();
    return random.nextInt(1000000); // You can adjust the range as needed
  }

  notificationDetails() => NotificationDetails(
        android: AndroidNotificationDetails(
          '10 ${generateUniqueId()}',
          'channelName',
          importance: getImportance(),
          icon: "app_icon",
        ),
        iOS: const DarwinNotificationDetails(),
      );

  Future showNotification({
    required int id,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    return notificationsPlugin.show(
        generateUniqueId(), title, body, await notificationDetails());
  }

  Future schduleNotification(
      {required int id,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduleNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future cancelNotification({required notificationId}) async {
    // print(notificationId.toString() + " " + "from notification service");
    await notificationsPlugin.cancel(notificationId);
    notificationsPlugin.pendingNotificationRequests();
  }
}
