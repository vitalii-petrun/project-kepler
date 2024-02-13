import 'dart:convert';

import '../../data/models/article_dto.dart';
import '../entities/article.dart';

class ArticleDtoToEntityConverter extends Converter<ArticleDTO, Article> {
  @override
  Article convert(ArticleDTO input) {
    return Article(
      id: input.id,
      title: input.title,
      url: input.url,
      imageUrl: input.imageUrl,
      newsSite: input.newsSite,
      summary: input.summary,
      publishedAt: DateTime.parse(input.publishedAt),
      updatedAt: DateTime.parse(input.updatedAt),
      featured: input.featured,
    );
  }
}

class ArticleEntityToDtoConverter extends Converter<Article, ArticleDTO> {
  @override
  ArticleDTO convert(Article input) {
    return ArticleDTO(
      id: input.id,
      title: input.title,
      url: input.url,
      imageUrl: input.imageUrl,
      newsSite: input.newsSite,
      summary: input.summary,
      publishedAt: input.publishedAt.toIso8601String(),
      updatedAt: input.updatedAt.toIso8601String(),
      featured: input.featured,
    );
  }
}
