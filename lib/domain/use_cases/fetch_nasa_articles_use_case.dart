import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/translatable.dart';

import '../../data/repositories/article_repository_impl.dart';
import '../entities/article.dart';

class FetchNasaArticlesUseCase {
  final ArticleRepositoryImpl repository;

  FetchNasaArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    final response = await repository.fetchNasaArticles();

    List<Translatable> translatedArticles = [];
    for (var article in response) {
      translatedArticles
          .add(await languageDetectionService.translateIfNecessary(article));
    }

    return translatedArticles.cast<Article>();
  }
}
