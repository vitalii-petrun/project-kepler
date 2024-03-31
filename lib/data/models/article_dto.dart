import 'package:json_annotation/json_annotation.dart';

import 'event_dto.dart';
import 'link_launch_dto.dart';

part 'article_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticleDTO {
  final int id;
  final String title;
  final String url;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'news_site')
  final String? newsSite;
  final String summary;
  @JsonKey(name: 'published_at')
  final String? publishedAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final bool featured;
  final List<LinkLaunchDTO>? launches;
  final List<EventDTO>? events;

  ArticleDTO({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
    this.launches,
    this.events,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDTOToJson(this);
}
