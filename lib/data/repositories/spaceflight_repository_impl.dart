import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/repositories/spaceflight_repository.dart';
import '../../domain/converters/article_converter.dart';
import '../../domain/entities/article.dart';
import '../data sources/remote/api_client.dart';
import '../models/article_dto.dart';

class SpaceflightRepositoryImpl implements SpaceflightRepository {
  final ApiClient apiClient;
  final ArticleDtoToEntityConverter articleConverter;

  SpaceflightRepositoryImpl(this.apiClient, this.articleConverter);

  @override
  Future<List<Article>> fetchArticles() async {
    return _fetchArticlesFromEndpoint('/articles');
  }

  @override
  Future<List<Article>> fetchSpaceXArticles() async {
    return _fetchArticlesFromEndpoint('/articles?title_contains=SpaceX');
  }

  @override
  Future<List<Article>> fetchNasaArticles() async {
    return _fetchArticlesFromEndpoint('/articles?title_contains=NASA');
  }

  @override
  Future<List<Article>> fetchBlogs() async {
    return _fetchArticlesFromEndpoint('/blogs');
  }

  @override
  Future<Article> getArticleById(String id) async {
    final response = await apiClient.get('/articles/$id');
    final articleDto = ArticleDTO.fromJson(response.data);
    return articleConverter.convert(articleDto);
  }

  Future<List<Article>> _fetchArticlesFromEndpoint(String endpoint) async {
    try {
      final response = await apiClient.get(endpoint);
      final articleDtoList = (response.data["results"] as List)
          .map((item) => ArticleDTO.fromJson(item))
          .toList();
      return articleDtoList.map(articleConverter.convert).toList();
    } catch (e) {
      logger.e('Failed to fetch data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
