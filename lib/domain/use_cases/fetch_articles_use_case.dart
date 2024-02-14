import '../../data/repositories/article_repository_impl.dart';
import '../entities/article.dart';

class FetchArticlesUseCase {
  final ArticleRepositoryImpl repository;

  FetchArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.fetchArticles();
  }
}
