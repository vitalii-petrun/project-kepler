import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

// TODO: The _translateArticlesIfNeeded function performs a potentially heavy operation within a loop and awaits each translation one by one,
//which can be inefficient. Consider using  Future.wait to parallelize the translation tasks.
class FetchArticlesUseCase {
  final ArticleRepository repository;
  final LanguageDetectionService languageDetectionService;

  FetchArticlesUseCase(this.repository, this.languageDetectionService);

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
