// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expedition_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpeditionDTO _$ExpeditionDTOFromJson(Map<String, dynamic> json) =>
    ExpeditionDTO(
      id: json['id'] as String,
      url: json['url'] as String,
      name: json['name'] as String,
      start: json['start'] as String,
      end: json['end'] as String?,
      spacestation: SpaceStationDTO.fromJson(
          json['spacestation'] as Map<String, dynamic>),
      missionPatches: (json['mission_patches'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spacewalks: (json['spacewalks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExpeditionDTOToJson(ExpeditionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'start': instance.start,
      'end': instance.end,
      'spacestation': instance.spacestation,
      'mission_patches': instance.missionPatches,
      'spacewalks': instance.spacewalks,
    };
