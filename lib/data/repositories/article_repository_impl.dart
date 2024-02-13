// lib/data/repositories/article_repository_impl.dart

import '../../domain/converters/article_converter.dart';
import '../../domain/entities/article.dart';
import '../data sources/remote/api_client.dart';

class ArticleRepositoryImpl {
  final ApiClient apiClient;

  ArticleRepositoryImpl(this.apiClient);

  Future<List<Article>> fetchArticles() async {
    final List<Article> articles = [];
    final articleDTOs = await apiClient.get('/articles');
    for (var articleDTO in articleDTOs.data) {
      articles.add(ArticleDtoToEntityConverter().convert(articleDTO));
    }
    return articles;
  }
}
