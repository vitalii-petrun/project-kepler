import '../../data/repositories/article_repository_impl.dart';
import '../entities/article.dart';

class FetchBlogsUseCase {
  final ArticleRepositoryImpl repository;

  FetchBlogsUseCase(this.repository);

  Future<List<Article>> call() async {
    return repository.fetchBlogs();
  }
}
