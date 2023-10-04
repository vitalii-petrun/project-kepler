// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => Launch(
      json['id'] as String,
      json['name'] as String,
      LaunchStatus.fromJson(json['status'] as Map<String, dynamic>),
      json['net'] as String,
      LaunchServiceProvider.fromJson(
          json['launch_service_provider'] as Map<String, dynamic>),
      Rocket.fromJson(json['rocket'] as Map<String, dynamic>),
      json['mission'] == null
          ? null
          : Mission.fromJson(json['mission'] as Map<String, dynamic>),
      Pad.fromJson(json['pad'] as Map<String, dynamic>),
      json['image'] as String?,
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
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
