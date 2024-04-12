import 'package:cloud_firestore/cloud_firestore.dart';

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
        .doc(launchId)
        .delete();
  }
}
