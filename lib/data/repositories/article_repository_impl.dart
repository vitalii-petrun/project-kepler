import '../../domain/converters/article_converter.dart';

import '../../domain/entities/article.dart';

import '../data sources/remote/api_client.dart';
import '../models/article_dto.dart';

class ArticleRepositoryImpl {
  final ApiClient apiClient;

  ArticleRepositoryImpl(this.apiClient);

  Future<List<Article>> fetchArticles() async {
    ArticleDtoToEntityConverter articleConverter =
        ArticleDtoToEntityConverter();

    final response = await apiClient.get('/articles');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => ArticleDTO.fromJson(item))
        .toList();
    return launchDtoList.map(articleConverter.convert).toList();
  }

  Future<List<Article>> fetchSpaceXArticles() async {
    ArticleDtoToEntityConverter articleConverter =
        ArticleDtoToEntityConverter();

    final response = await apiClient.get('/articles?title_contains=SpaceX');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => ArticleDTO.fromJson(item))
        .toList();
    return launchDtoList.map(articleConverter.convert).toList();
  }

  Future<List<Article>> fetchNasaArticles() async {
    ArticleDtoToEntityConverter articleConverter =
        ArticleDtoToEntityConverter();

    final response = await apiClient.get('/articles?title_contains=NASA');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => ArticleDTO.fromJson(item))
        .toList();
    return launchDtoList.map(articleConverter.convert).toList();
  }

  Future<List<Article>> fetchBlogs() async {
    ArticleDtoToEntityConverter articleConverter =
        ArticleDtoToEntityConverter();

    final response = await apiClient.get('/blogs');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => ArticleDTO.fromJson(item))
        .toList();
    return launchDtoList.map(articleConverter.convert).toList();
  }
}
