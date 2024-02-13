import 'package:json_annotation/json_annotation.dart';

part 'report_dto.g.dart';

@JsonSerializable()
class ReportDTO {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;
  final String updatedAt;

  ReportDTO({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
  });

  factory ReportDTO.fromJson(Map<String, dynamic> json) =>
      _$ReportDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDTOToJson(this);
}
