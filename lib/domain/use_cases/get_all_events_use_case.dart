import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

import '../../data/repositories/api_repository_impl.dart';

class GetAllEventsUseCase {
  final ApiRepositoryImpl repository;

  GetAllEventsUseCase(this.repository);

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
