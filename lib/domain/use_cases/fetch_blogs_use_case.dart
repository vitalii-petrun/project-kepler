import '../../data/repositories/article_repository_impl.dart';
import '../entities/blog.dart';

class FetchBlogsUseCase {
  final ArticleRepositoryImpl repository;

  FetchBlogsUseCase(this.repository);

  Future<List<Blog>> call() async {
    return repository.fetchBlogs();
  }
}
