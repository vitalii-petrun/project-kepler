import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/article.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

// TODO: The _translateArticlesIfNeeded function performs a potentially heavy operation within a loop and awaits each translation one by one,
//which can be inefficient. Consider using  Future.wait to parallelize the translation tasks.
class FetchArticlesUseCase extends LocaleAwareUseCase {
  final ArticleRepository repository;

  FetchArticlesUseCase(
      this.repository, LocaleTranslationService localeTranslationService)
      : super(localeTranslationService);

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
        return await localeTranslationService.translateIfNecessary(article)
            as Article;
      }).toList(),
    );
  }

  @override
  void onLocaleChanged() {
    call();
  }
}
