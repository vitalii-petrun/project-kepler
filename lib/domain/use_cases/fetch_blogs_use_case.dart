import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/domain/repositories/article_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../entities/article.dart';

class FetchBlogsUseCase {
  final SpaceflightRepository repository;

  FetchBlogsUseCase(this.repository);

  Future<List<Article>> call() async {
    final response = await repository.fetchBlogs();
    return await _translateArticlesIfNeeded(response);
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
