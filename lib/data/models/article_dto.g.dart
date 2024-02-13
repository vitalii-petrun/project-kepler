// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDTO _$ArticleDTOFromJson(Map<String, dynamic> json) => ArticleDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String,
      newsSite: json['newsSite'] as String,
      summary: json['summary'] as String,
      publishedAt: json['publishedAt'] as String,
      updatedAt: json['updatedAt'] as String,
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
      'imageUrl': instance.imageUrl,
      'newsSite': instance.newsSite,
      'summary': instance.summary,
      'publishedAt': instance.publishedAt,
      'updatedAt': instance.updatedAt,
      'featured': instance.featured,
      'launches': instance.launches?.map((e) => e.toJson()).toList(),
      'events': instance.events?.map((e) => e.toJson()).toList(),
    };
