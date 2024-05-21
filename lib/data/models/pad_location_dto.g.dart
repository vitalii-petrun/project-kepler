// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadLocationDTO _$PadLocationDTOFromJson(Map<String, dynamic> json) =>
    PadLocationDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['total_launch_count'] as num?)?.toInt(),
      (json['total_landing_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PadLocationDTOToJson(PadLocationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total_launch_count': instance.totalLaunchCount,
      'total_landing_count': instance.totalLandingCount,
    };
