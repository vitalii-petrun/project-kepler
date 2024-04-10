import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';

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

    logger.d('Fetched favourite launches for user $userId');

    final launches = <Launch>[];
    for (final doc in snapshot.docs) {
      final launchDTO = LaunchDTO.fromJson(doc.data());
      final launch = dtoToEntityConverter.convert(launchDTO);
      logger.d('Fetched launch ${launch.id}');
      final translatedLaunch =
          await languageDetectionService.translateIfNecessary(launch);
      launches.add(translatedLaunch as Launch);
    }

    return launches;
  }
}
