import 'package:cloud_firestore/cloud_firestore.dart';

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
  }
}
