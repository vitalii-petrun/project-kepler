import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../helpers/test_helpers.mocks.dart';

void main() {
  group('Notification Test', () {
    late MockFlutterLocalNotificationsPlugin mockNotificationsPlugin;

    setUp(() {
      mockNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
    });

    test('should schedule a notification', () async {
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
        ),
      );

      when(mockNotificationsPlugin.zonedSchedule(
        any,
        any,
        any,
        any,
        any,
        androidAllowWhileIdle: anyNamed('androidAllowWhileIdle'),
        uiLocalNotificationDateInterpretation:
            anyNamed('uiLocalNotificationDateInterpretation'),
        matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
      )).thenAnswer((_) async {});

      await scheduleNotification(mockNotificationsPlugin);

      verify(mockNotificationsPlugin.zonedSchedule(
        0,
        'Test Notification',
        'This is a test notification',
        any, // You can specify the exact DateTime if your function uses a fixed time
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      )).called(1);
    });
  });
}

Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin notificationsPlugin) async {
  const NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
    ),
  );

  await notificationsPlugin.zonedSchedule(
    0,
    'Test Notification',
    'This is a test notification',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    notificationDetails,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
