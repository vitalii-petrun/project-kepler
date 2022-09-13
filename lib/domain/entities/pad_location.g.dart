// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadLocation _$PadLocationFromJson(Map<String, dynamic> json) => PadLocation(
      json['id'] as int,
      json['name'] as String,
      json['totalLaunchCount'] as int?,
      json['totalLandingCount'] as int?,
    );

Map<String, dynamic> _$PadLocationToJson(PadLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'totalLaunchCount': instance.totalLaunchCount,
      'totalLandingCount': instance.totalLandingCount,
    };
