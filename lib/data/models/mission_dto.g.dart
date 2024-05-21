// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionDTO _$MissionDTOFromJson(Map<String, dynamic> json) => MissionDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['description'] as String,
      json['type'] as String,
      OrbitDTO.fromJson(json['orbit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MissionDTOToJson(MissionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'orbit': instance.orbit.toJson(),
    };
