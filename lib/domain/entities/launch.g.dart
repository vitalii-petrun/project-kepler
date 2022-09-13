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
      Mission.fromJson(json['mission'] as Map<String, dynamic>),
      Pad.fromJson(json['pad'] as Map<String, dynamic>),
      json['image'] as String,
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status.toJson(),
      'net': instance.net,
      'launch_service_provider': instance.launchServiceProvider.toJson(),
      'rocket': instance.rocket.toJson(),
      'mission': instance.mission.toJson(),
      'pad': instance.pad.toJson(),
      'image': instance.image,
    };
