// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orbit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orbit _$OrbitFromJson(Map<String, dynamic> json) => Orbit(
      json['id'] as int,
      json['name'] as String,
      json['abbrev'] as String,
    );

Map<String, dynamic> _$OrbitToJson(Orbit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbrev': instance.abbrev,
    };
