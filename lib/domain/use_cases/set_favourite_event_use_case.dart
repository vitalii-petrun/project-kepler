import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
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

    await NotificationService().scheduleNotification(
      event.id.hashCode,
      'Event Reminder',
      'The event ${event.name} is about to start at ${event.date}',
      tz.TZDateTime.from(event.date, tz.local),
    );
  }
}
