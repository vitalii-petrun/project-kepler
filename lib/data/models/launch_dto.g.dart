// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchDTO _$LaunchDTOFromJson(Map<String, dynamic> json) => LaunchDTO(
      json['id'] as String,
      json['name'] as String,
      LaunchStatusDTO.fromJson(json['status'] as Map<String, dynamic>),
      json['net'] as String,
      LaunchServiceProviderDTO.fromJson(
          json['launch_service_provider'] as Map<String, dynamic>),
      RocketDTO.fromJson(json['rocket'] as Map<String, dynamic>),
      json['mission'] == null
          ? null
          : MissionDTO.fromJson(json['mission'] as Map<String, dynamic>),
      PadDTO.fromJson(json['pad'] as Map<String, dynamic>),
      json['image'] as String?,
    );

Map<String, dynamic> _$LaunchDTOToJson(LaunchDTO instance) => <String, dynamic>{
      'id': instance.id,
      'net': instance.net,
      'name': instance.name,
      'status': instance.status.toJson(),
      'launch_service_provider': instance.launchServiceProvider.toJson(),
      'mission': instance.mission?.toJson(),
      'rocket': instance.rocket.toJson(),
      'image': instance.image,
      'pad': instance.pad.toJson(),
    };
