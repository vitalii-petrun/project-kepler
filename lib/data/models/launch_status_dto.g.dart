// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchStatusDTO _$LaunchStatusDTOFromJson(Map<String, dynamic> json) =>
    LaunchStatusDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$LaunchStatusDTOToJson(LaunchStatusDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
