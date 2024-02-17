import '../../../domain/entities/article.dart';

abstract class NewsState {}

class NewsLoading extends NewsState {}

class RecentArticlesLoaded extends NewsState {
  final List<Article> articles;

  RecentArticlesLoaded(this.articles);
}

class SpaceXArticlesLoaded extends NewsState {
  final List<Article> articles;

  SpaceXArticlesLoaded(this.articles);
}

class NasaArticlesLoaded extends NewsState {
  final List<Article> articles;

  NasaArticlesLoaded(this.articles);
}

class BlogsLoaded extends NewsState {
  final List<Article> blogs;

  BlogsLoaded(this.blogs);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
