import '../../data/repositories/article_repository_impl.dart';
import '../entities/article.dart';

class FetchSpaceXArticlesUseCase {
  final ArticleRepositoryImpl repository;

  FetchSpaceXArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.fetchSpaceXArticles();
  }
}
