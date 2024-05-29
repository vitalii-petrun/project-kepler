import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/utils/notification_service.dart';

class RemoveFavouriteLaunchUseCase {
  final FirebaseFirestore firestore;
  String? userId;

  RemoveFavouriteLaunchUseCase({
    required this.firestore,
    this.userId,
  });

  Future<void> call(String launchId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('launches')
        .collection('launches')
        .doc(launchId)
        .delete();

    await NotificationService().cancelNotification(launchId.hashCode);
  }
}
