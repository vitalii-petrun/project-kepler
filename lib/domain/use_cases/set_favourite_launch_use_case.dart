import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/launch_dto.dart';
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
    LaunchDTO launchDto = entityToDtoConverter.convert(launch);
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(launch.id)
        .set(launchDto.toJson());
  }
}
