import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/launch_library_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

class GetUpcomingLaunchesUseCase {
  final LaunchLibraryRepository repository;

  GetUpcomingLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    final response = await repository.getUpcomingLaunchList();
    logger.d('Requesting upcoming launches [${response.length} items]');
    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles.add(await locator<LocaleTranslationService>()
          .translateIfNecessary(article));
    }

    return translatedArticles.cast<Launch>();
  }
}
