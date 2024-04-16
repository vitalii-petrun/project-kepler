import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/domain/entities/event.dart';

class SetFavouriteEventUseCase {
  final FirebaseFirestore firestore;
  String? userId;

  SetFavouriteEventUseCase({
    required this.firestore,
    this.userId,
  });

  Future<void> call(Event event) async {
    if (userId == null) {
      throw Exception("User ID is null");
    }
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
  }
}
