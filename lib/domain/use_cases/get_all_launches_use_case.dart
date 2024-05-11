import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/core/utils/notification_service.dart';
import 'package:project_kepler/domain/entities/translatable.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';
import 'package:timezone/timezone.dart' as tz;

import '../entities/launch.dart';

class GetAllLaunchesUseCase {
  final SpaceDevsRepository repository;
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
