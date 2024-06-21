import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/core/utils/helpers.dart';
import 'package:project_kepler/core/utils/notification_service.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:timezone/timezone.dart' as tz;

class SetFavouriteEventUseCase {
  final FirebaseFirestore firestore;
  String? userId;

  SetFavouriteEventUseCase({
    required this.firestore,
    this.userId,
  });

  Future<void> call(Event event) async {
    logger.d('Setting favourite event call().  User id: $userId');
    if (userId == null) {
      throw Exception("User ID is null");
    }
    logger.d('Setting favourite event.  User id: $userId');

    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('events')
        .collection('events')
        .doc(event.id.toString())
        .set({
      'id': event.id,
      'name': event.name,
    });

    _scheduleNotification(event);
  }
}

void _scheduleNotification(Event event) async {
  final eventTime = event.date;
  final notificationTime = eventTime.subtract(const Duration(minutes: 5));

  await NotificationService().scheduleNotification(
    event.id.hashCode,
    '🚀 Event Reminder',
    'The launch ${event.name} starts in 5 minutes at ${formatDateTime(eventTime)} UTC',
    tz.TZDateTime.from(notificationTime, tz.local),
  );
}
