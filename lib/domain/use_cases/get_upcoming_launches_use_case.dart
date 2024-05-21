import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

class GetUpcomingLaunchesUseCase extends LocaleAwareUseCase {
  final SpaceDevsRepository repository;

  GetUpcomingLaunchesUseCase(
      this.repository, LocaleTranslationService localeTranslationService)
      : super(localeTranslationService);

  Future<List<Launch>> call() async {
    final response = await repository.getUpcomingLaunchList();
    logger.d('Requesting upcoming launches [${response.length} items]');
    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles
          .add(await localeTranslationService.translateIfNecessary(article));
    }

    return translatedArticles.cast<Launch>();
  }

  @override
  void onLocaleChanged() {
    // Implement the logic that needs to be executed when the locale changes
    call();
  }
}
