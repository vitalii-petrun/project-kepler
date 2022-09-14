// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mission _$MissionFromJson(Map<String, dynamic> json) => Mission(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['type'] as String,
      Orbit.fromJson(json['orbit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MissionToJson(Mission instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'orbit': instance.orbit.toJson(),
    };
