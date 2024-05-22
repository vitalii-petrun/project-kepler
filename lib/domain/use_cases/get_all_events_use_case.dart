import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

/// Use case for retrieving all events.
///
/// Utilizes [SpaceDevsRepository] for fetching events data and
/// [LocaleTranslationService] for setting up appropriate language configurations.
class GetAllEventsUseCase {
  final SpaceDevsRepository repository;

  GetAllEventsUseCase(this.repository);

  Future<List<Event>> call() async {
    final response = await repository.getAllEvents();
    return await _translateArticlesIfNeeded(response);
  }

  Future<List<Event>> _translateArticlesIfNeeded(
      List<Translatable> articles) async {
    return Future.wait(
      articles.map((article) async {
        return await locator<LocaleTranslationService>()
            .translateIfNecessary(article) as Event;
      }).toList(),
    );
  }
}
