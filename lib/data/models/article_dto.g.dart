// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDTO _$ArticleDTOFromJson(Map<String, dynamic> json) => ArticleDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      imageUrl: json['image_url'] as String?,
      newsSite: json['news_site'] as String?,
      summary: json['summary'] as String,
      publishedAt: json['published_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      featured: json['featured'] as bool,
      launches: (json['launches'] as List<dynamic>?)
          ?.map((e) => LaunchDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => EventDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleDTOToJson(ArticleDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'image_url': instance.imageUrl,
      'news_site': instance.newsSite,
      'summary': instance.summary,
      'published_at': instance.publishedAt,
      'updated_at': instance.updatedAt,
      'featured': instance.featured,
      'launches': instance.launches?.map((e) => e.toJson()).toList(),
      'events': instance.events?.map((e) => e.toJson()).toList(),
    };
