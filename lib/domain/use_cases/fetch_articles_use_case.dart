import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';

class FetchArticlesUseCase {
  final ArticleRepository repository;

  FetchArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    try {
      final articles = await repository.fetchArticles();
      return await _translateArticlesIfNeeded(articles);
    } catch (e) {
      logger.e('Error fetching articles: $e');
      rethrow;
    }
  }

  Future<List<Article>> _translateArticlesIfNeeded(
      List<Article> articles) async {
    List<Article> translatedArticles = [];
    for (var article in articles) {
      translatedArticles.add(await languageDetectionService
          .translateIfNecessary(article) as Article);
    }
    return translatedArticles;
  }
}
