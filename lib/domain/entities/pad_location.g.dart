// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadLocation _$PadLocationFromJson(Map<String, dynamic> json) => PadLocation(
      json['id'] as int,
      json['name'] as String,
      json['total_launch_count'] as int?,
      json['total_landing_count'] as int?,
    );

Map<String, dynamic> _$PadLocationToJson(PadLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total_launch_count': instance.totalLaunchCount,
      'total_landing_count': instance.totalLandingCount,
    };
