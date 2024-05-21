import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';

class GetAllLaunchesUseCase extends LocaleAwareUseCase {
  final SpaceDevsRepository repository;

  GetAllLaunchesUseCase(
      this.repository, LocaleTranslationService localeTranslationService)
      : super(localeTranslationService);

  Future<List<Launch>> call() async {
    final response = await repository.getLaunchList();
    return await _translateArticlesIfNeeded(response);
  }

  Future<List<Launch>> _translateArticlesIfNeeded(
      List<Translatable> articles) async {
    return Future.wait(
      articles.map((article) async {
        return await localeTranslationService.translateIfNecessary(article)
            as Launch;
      }).toList(),
    );
  }

  @override
  void onLocaleChanged() {
    // Implement the logic that needs to be executed when the locale changes
    logger.d("Locale changed [@override void onLocaleChanged()]");
    call();
  }
}
