import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';
import '../entities/article.dart';

class FetchSpaceXArticlesUseCase {
  final ArticleRepository repository;
  final LanguageDetectionService languageDetectionService;

  FetchSpaceXArticlesUseCase(this.repository, this.languageDetectionService);

  Future<List<Article>> call() async {
    final response = await repository.fetchSpaceXArticles();

    final translatedArticles = await _translateArticlesIfNeeded(response);

    return translatedArticles.cast<Article>();
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
