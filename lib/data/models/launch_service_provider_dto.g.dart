// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_service_provider_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchServiceProviderDTO _$LaunchServiceProviderDTOFromJson(
        Map<String, dynamic> json) =>
    LaunchServiceProviderDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['type'] as String?,
    );

Map<String, dynamic> _$LaunchServiceProviderDTOToJson(
        LaunchServiceProviderDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };
