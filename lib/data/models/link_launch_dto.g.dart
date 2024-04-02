// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_launch_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkLaunchDTO _$LinkLaunchDTOFromJson(Map<String, dynamic> json) =>
    LinkLaunchDTO(
      launchID: json['launch_id'] as String?,
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$LinkLaunchDTOToJson(LinkLaunchDTO instance) =>
    <String, dynamic>{
      'launch_id': instance.launchID,
      'provider': instance.provider,
    };
