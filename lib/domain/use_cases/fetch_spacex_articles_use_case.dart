import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';
import '../entities/article.dart';

class FetchSpaceXArticlesUseCase extends LocaleAwareUseCase {
  final ArticleRepository repository;

  FetchSpaceXArticlesUseCase(
      this.repository, LocaleTranslationService localeTranslationService)
      : super(localeTranslationService);

  Future<List<Article>> call() async {
    final response = await repository.fetchSpaceXArticles();
    return await _translateArticlesIfNeeded(response);
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
    // Implement the logic that needs to be executed when the locale changes
    call();
  }
}
