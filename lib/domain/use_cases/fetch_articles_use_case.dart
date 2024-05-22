import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

// TODO: The _translateArticlesIfNeeded function performs a potentially heavy operation within a loop and awaits each translation one by one,
//which can be inefficient. Consider using  Future.wait to parallelize the translation tasks.
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
    return Future.wait(
      articles.map((article) async {
        return await locator<LocaleTranslationService>()
            .translateIfNecessary(article) as Article;
      }).toList(),
    );
  }
}
