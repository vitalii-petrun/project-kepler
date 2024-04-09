import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

import '../../data/repositories/api_repository_impl.dart';
import '../entities/launch.dart';

class GetAllLaunchesUseCase {
  final ApiRepositoryImpl repository;

  GetAllLaunchesUseCase(this.repository);

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
