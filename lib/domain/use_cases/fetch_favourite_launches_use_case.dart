import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

import '../entities/launch.dart';

class FetchFavouriteLaunchesUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final SpaceDevsRepository apiRepository;
  final LanguageDetectionService languageDetectionService;

  FetchFavouriteLaunchesUseCase({
    this.userId,
    required this.firestore,
    required this.languageDetectionService,
    required this.apiRepository,
  });

  Future<List<Launch>> call() async {
    logger.d('Fetching favourite launches.  User id: $userId');

    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('launches')
        .collection('launches')
        .get();

    final launches = <Launch>[];
    for (final doc in snapshot.docs) {
      final launch = await apiRepository.getLaunchDetailsById(doc.id);

      final translatedLaunch =
          await languageDetectionService.translateIfNecessary(launch);
      launches.add(translatedLaunch as Launch);
    }

    return launches;
  }
}
