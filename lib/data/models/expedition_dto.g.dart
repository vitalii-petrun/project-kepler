// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expedition_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpeditionDTO _$ExpeditionDTOFromJson(Map<String, dynamic> json) =>
    ExpeditionDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      name: json['name'] as String,
      start: json['start'] as String,
      end: json['end'] as String?,
      spacestation: SpaceStationDTO.fromJson(
          json['spacestation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpeditionDTOToJson(ExpeditionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'start': instance.start,
      'end': instance.end,
      'spacestation': instance.spacestation,
    };
