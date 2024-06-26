import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/utils/helpers.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:project_kepler/core/utils/notification_service.dart';

import '../converters/launch_converter.dart';
import '../entities/launch.dart';

class SetFavouriteLaunchUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final LaunchEntityToDtoConverter entityToDtoConverter;

  SetFavouriteLaunchUseCase({
    required this.firestore,
    this.userId,
    required this.entityToDtoConverter,
  });

  Future<void> call(Launch launch) async {
    // Ensure the user ID is not null
    if (userId == null) {
      throw Exception("User ID is null");
    }
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('launches')
        .collection('launches')
        .doc(launch.id)
        .set({
      'id': launch.id,
      'name': launch.name,
    });

    // Schedule a notification for the launch
    _scheduleNotification(launch);

    // TEST SCHEDULE NOTIFICATION
    // Schedule a notification 10 seconds from now
    // logger.d('Scheduling notification for launch ${launch.name} in 15 seconds');
    // await NotificationService().scheduleNotification(
    //   launch.id.hashCode,
    //   'Launch Reminder',
    //   'The launch ${launch.name} is about to start',
    //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
    // );

    // TEST SHOW NOTIFICATION
    // final launchTime = DateTime.parse(launch.net);

    // await NotificationService().showNotification(
    //   launch.id.hashCode,
    //   '🚀 Launch Reminder',
    //   'The launch ${launch.name} starts in 5 minutes at ${formatDateTime(launchTime)} UTC',
    // );
  }
}

void _scheduleNotification(Launch launch) async {
  final launchTime = DateTime.parse(launch.net);
  final notificationTime = launchTime.subtract(const Duration(minutes: 5));

  await NotificationService().scheduleNotification(
    launch.id.hashCode,
    '🚀 Launch Reminder',
    'The launch ${launch.name} starts in 5 minutes at ${formatDateTime(launchTime)} UTC',
    tz.TZDateTime.from(notificationTime, tz.local),
  );
}
