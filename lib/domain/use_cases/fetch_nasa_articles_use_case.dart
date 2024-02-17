import '../../data/repositories/article_repository_impl.dart';
import '../entities/article.dart';

class FetchNasaArticlesUseCase {
  final ArticleRepositoryImpl repository;

  FetchNasaArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.fetchNasaArticles();
  }
}
