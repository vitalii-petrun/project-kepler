// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RocketConfiguration _$RocketConfigurationFromJson(Map<String, dynamic> json) =>
    RocketConfiguration(
      json['id'] as int,
      json['name'] as String,
      json['family'] as String,
      json['full_name'] as String,
      json['variant'] as String,
    );

Map<String, dynamic> _$RocketConfigurationToJson(
        RocketConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'family': instance.family,
      'full_name': instance.fullName,
      'variant': instance.variant,
    };
