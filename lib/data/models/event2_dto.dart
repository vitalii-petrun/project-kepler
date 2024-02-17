import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/program_dto.dart';
import 'package:project_kepler/data/models/space_station_dto.dart';
import 'package:project_kepler/data/models/type_dto.dart';

import 'agency_dto.dart';
import 'expedition_dto.dart';
import 'launch2_dto.dart';

part 'event2_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class EventDTO {
  final int id;
  final String url;
  final String slug;
  final String name;

  @JsonKey(name: 'last_updated')
  final String lastUpdated;
  final TypeDTO type;
  final String description;
  @JsonKey(name: 'webcast_live')
  final bool webcastLive;
  final String location;
  @JsonKey(name: 'news_url')
  final String? newsUrl;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'feature_image')
  final String featureImage;
  final String date;
  final String? duration;
  final List<AgencyDTO>? agencies;
  final List<LaunchDTO>? launches;
  final List<ExpeditionDTO>? expeditions;
  final List<SpaceStationDTO>? spaceStations;
  final List<ProgramDTO>? programs;

  EventDTO({
    required this.id,
    required this.url,
    required this.slug,
    required this.name,
    required this.lastUpdated,
    required this.type,
    required this.description,
    required this.webcastLive,
    required this.location,
    required this.newsUrl,
    required this.videoUrl,
    required this.featureImage,
    required this.date,
    required this.duration,
    required this.agencies,
    required this.launches,
    required this.expeditions,
    required this.spaceStations,
    required this.programs,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) =>
      _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);
}
