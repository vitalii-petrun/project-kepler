import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

class FetchFavouriteLaunchesUseCase extends LocaleAwareUseCase {
  final FirebaseFirestore firestore;
  String? userId;
  final SpaceDevsRepository apiRepository;

  FetchFavouriteLaunchesUseCase({
    this.userId,
    required this.firestore,
    required LocaleTranslationService localeTranslationService,
    required this.apiRepository,
  }) : super(localeTranslationService);

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
      return await localeTranslationService.translateIfNecessary(launch)
          as Launch;
    }).toList());

    return launches.reversed.toList();
  }

  @override
  void onLocaleChanged() {
    call();
  }
}
