import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/launch.dart';

import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';

class GetAllLaunchesUseCase {
  final SpaceDevsRepository repository;

  GetAllLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    final response = await repository.getLaunchList();
    return await _translateArticlesIfNeeded(response);
  }

  Future<List<Launch>> _translateArticlesIfNeeded(
      List<Translatable> articles) async {
    return Future.wait(
      articles.map((article) async {
        return await locator<LocaleTranslationService>()
            .translateIfNecessary(article) as Launch;
      }).toList(),
    );
  }
}
