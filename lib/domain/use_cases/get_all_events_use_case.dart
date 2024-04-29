import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

class GetAllEventsUseCase {
  final SpaceDevsRepository repository;
  final LanguageDetectionService languageDetectionService;

  GetAllEventsUseCase(this.repository, this.languageDetectionService);

  Future<List<Event>> call() async {
    final response = await repository.getAllEvents();

    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles
          .add(await languageDetectionService.translateIfNecessary(article));
    }

    return translatedArticles.cast<Event>();
  }
}
