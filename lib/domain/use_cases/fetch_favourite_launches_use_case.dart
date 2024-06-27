import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/repositories/launch_library_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

class FetchFavouriteLaunchesUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final LaunchLibraryRepository apiRepository;

  FetchFavouriteLaunchesUseCase(
      {required this.firestore, this.userId, required this.apiRepository});

  Future<List<Launch>> call() async {
    logger.d('Fetching favourite launches. User id: $userId');

    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc('launches')
        .collection('launches')
        .get();

    final launches = await Future.wait(snapshot.docs.map((doc) async {
      final launch = await apiRepository.getLaunchDetailsById(doc.id);
      return await locator<LocaleTranslationService>()
          .translateIfNecessary(launch) as Launch;
    }).toList());

    return launches.reversed.toList();
  }
}
