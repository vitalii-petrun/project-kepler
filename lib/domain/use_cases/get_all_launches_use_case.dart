import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

import '../entities/launch.dart';

class GetAllLaunchesUseCase {
  final ApiRepository repository;
  final LanguageDetectionService languageDetectionService;

  GetAllLaunchesUseCase(this.repository, this.languageDetectionService);

  Future<List<Launch>> call() async {
    final response = await repository.getLaunchList();

    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles
          .add(await languageDetectionService.translateIfNecessary(article));
    }

    return translatedArticles.cast<Launch>();
  }
}
