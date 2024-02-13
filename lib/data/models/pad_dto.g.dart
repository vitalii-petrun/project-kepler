// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadDTO _$PadDTOFromJson(Map<String, dynamic> json) => PadDTO(
      json['id'] as int,
      json['agency_id'] as int?,
      json['name'] as String,
      PadLocationDTO.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PadDTOToJson(PadDTO instance) => <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyID,
      'name': instance.name,
      'location': instance.location.toJson(),
    };
