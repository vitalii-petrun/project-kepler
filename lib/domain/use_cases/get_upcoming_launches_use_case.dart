import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

import '../../data/repositories/api_repository_impl.dart';
import '../entities/launch.dart';

class GetUpcomingLaunchesUseCase {
  final ApiRepositoryImpl repository;

  GetUpcomingLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    final response = await repository.getUpcomingLaunchList();

    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles
          .add(await languageDetectionService.translateIfNecessary(article));
    }

    return translatedArticles.cast<Launch>();
  }
}
