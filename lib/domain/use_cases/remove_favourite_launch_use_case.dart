import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveFavouriteLaunchUseCase {
  final FirebaseFirestore firestore;

  RemoveFavouriteLaunchUseCase({
    required this.firestore,
  });

  Future<void> call(String launchId) async {
    await firestore.collection('launches').doc(launchId).delete();
  }
}
