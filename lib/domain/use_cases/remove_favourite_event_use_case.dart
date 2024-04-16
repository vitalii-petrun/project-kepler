import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveFavouriteEventUseCase {
  final FirebaseFirestore firestore;
  String? userId;

  RemoveFavouriteEventUseCase({
    required this.firestore,
    this.userId,
  });

  Future<void> call(String eventId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('events')
        .collection('events')
        .doc(eventId)
        .delete();
  }
}
