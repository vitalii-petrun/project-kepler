// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pad _$PadFromJson(Map<String, dynamic> json) => Pad(
      json['id'] as int,
      json['agency_id'] as int?,
      json['name'] as String,
      PadLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PadToJson(Pad instance) => <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyID,
      'name': instance.name,
      'location': instance.location.toJson(),
    };
