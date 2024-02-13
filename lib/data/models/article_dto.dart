import 'package:json_annotation/json_annotation.dart';

import 'event_dto.dart';
import 'launch2_dto.dart';

part 'article_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticleDTO {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;
  final String updatedAt;
  final bool featured;
  final List<LaunchDTO> launches;
  final List<EventDTO> events;

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
    required this.launches,
    required this.events,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) =>
      _$ArticleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDTOToJson(this);
}
