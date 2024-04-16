import 'package:project_kepler/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> fetchArticles();

  Future<Article> getArticleById(String id);

  Future<List<Article>> fetchSpaceXArticles();

  Future<List<Article>> fetchNasaArticles();

  Future<List<Article>> fetchBlogs();
}
