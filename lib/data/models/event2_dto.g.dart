// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event2_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      lastUpdated: json['last_updated'] as String,
      type: TypeDTO.fromJson(json['type'] as Map<String, dynamic>),
      description: json['description'] as String,
      webcastLive: json['webcast_live'] as bool,
      location: json['location'] as String,
      newsUrl: json['news_url'] as String?,
      videoUrl: json['video_url'] as String?,
      featureImage: json['feature_image'] as String,
      date: json['date'] as String,
      duration: json['duration'] as String?,
      agencies: (json['agencies'] as List<dynamic>?)
          ?.map((e) => AgencyDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      launches: (json['launches'] as List<dynamic>?)
          ?.map((e) => LinkLaunchDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      expeditions: (json['expeditions'] as List<dynamic>?)
          ?.map((e) => ExpeditionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      spaceStations: (json['spaceStations'] as List<dynamic>?)
          ?.map((e) => SpaceStationDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => ProgramDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'slug': instance.slug,
      'name': instance.name,
      'last_updated': instance.lastUpdated,
      'type': instance.type.toJson(),
      'description': instance.description,
      'webcast_live': instance.webcastLive,
      'location': instance.location,
      'news_url': instance.newsUrl,
      'video_url': instance.videoUrl,
      'feature_image': instance.featureImage,
      'date': instance.date,
      'duration': instance.duration,
      'agencies': instance.agencies?.map((e) => e.toJson()).toList(),
      'launches': instance.launches?.map((e) => e.toJson()).toList(),
      'expeditions': instance.expeditions?.map((e) => e.toJson()).toList(),
      'spaceStations': instance.spaceStations?.map((e) => e.toJson()).toList(),
      'programs': instance.programs?.map((e) => e.toJson()).toList(),
    };
