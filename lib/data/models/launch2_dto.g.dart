// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch2_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchDTO _$LaunchDTOFromJson(Map<String, dynamic> json) => LaunchDTO(
      launchID: json['launch_id'] as String,
      provider: json['provider'] as String,
    );

Map<String, dynamic> _$LaunchDTOToJson(LaunchDTO instance) => <String, dynamic>{
      'launch_id': instance.launchID,
      'provider': instance.provider,
    };
