import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ServisiNotifikacija {
  ServisiNotifikacija();

  final servisNotifikacija = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await servisNotifikacija.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> detalji() async {
    const AndroidNotificationDetails androidDetalji =
        AndroidNotificationDetails("id", "nazivKanala",
            importance: Importance.max);

    return const NotificationDetails(android: androidDetalji);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await detalji();
    await servisNotifikacija.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await detalji();
    await servisNotifikacija.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: seconds)), tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await detalji();
    await servisNotifikacija.show(id, title, body, details, payload: payload);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    print(response);
    if (response.payload != null) {
      onNotificationClick.add(response.payload);
    }
  }
}
