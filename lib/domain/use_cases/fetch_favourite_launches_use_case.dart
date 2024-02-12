import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/launch_dto.dart';
import '../converters/launch_converter.dart';
import '../entities/launch.dart';

class FetchFavouriteLaunchesUseCase {
  final FirebaseFirestore firestore;
  final String userId;
  final LaunchDtoToEntityConverter dtoToEntityConverter;

  FetchFavouriteLaunchesUseCase({
    required this.firestore,
    required this.userId,
    required this.dtoToEntityConverter,
  });

  Future<List<Launch>> call() async {
    final snapshot = await firestore
        .collection('launches')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((e) {
      final launchDTO = LaunchDTO.fromJson(e.data());
      return dtoToEntityConverter.convert(launchDTO);
    }).toList();
  }
}
