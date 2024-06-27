import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/repositories/spaceflight_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

class FetchArticlesUseCase {
  final SpaceflightRepository repository;

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
    // Future.wait is used to parallelize the translation tasks
    return Future.wait(
      articles.map((article) async {
        return await locator<LocaleTranslationService>()
            .translateIfNecessary(article) as Article;
      }).toList(),
    );
  }
}
