import 'dart:convert';

import '../../data/models/blog_dto.dart';
import '../entities/blog.dart';

class BlogDtoToEntityConverter extends Converter<BlogDTO, Blog> {
  @override
  Blog convert(BlogDTO input) {
    return Blog(
      id: input.id,
      title: input.title,
      url: input.url,
      imageUrl: input.imageUrl,
      newsSite: input.newsSite,
      summary: input.summary,
      publishedAt: input.publishedAt,
      updatedAt: input.updatedAt,
      featured: input.featured,
    );
  }
}

class BlogEntityToDTOConverter extends Converter<Blog, BlogDTO> {
  @override
  BlogDTO convert(Blog input) {
    return BlogDTO(
      id: input.id,
      title: input.title,
      url: input.url,
      imageUrl: input.imageUrl,
      newsSite: input.newsSite,
      summary: input.summary,
      publishedAt: input.publishedAt,
      updatedAt: input.updatedAt,
      featured: input.featured,
      launches: [],
      events: [],
    );
  }
}
