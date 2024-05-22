// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket_configuration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RocketConfigurationDTO _$RocketConfigurationDTOFromJson(
        Map<String, dynamic> json) =>
    RocketConfigurationDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['family'] as String,
      json['full_name'] as String,
      json['variant'] as String,
      json['manufacturer'] == null
          ? null
          : ManufacturerDTO.fromJson(
              json['manufacturer'] as Map<String, dynamic>),
      json['info_url'] as String?,
      json['wiki_url'] as String?,
      json['image_url'] as String?,
    );

Map<String, dynamic> _$RocketConfigurationDTOToJson(
        RocketConfigurationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'family': instance.family,
      'full_name': instance.fullName,
      'variant': instance.variant,
      'manufacturer': instance.manufacturer?.toJson(),
      'info_url': instance.infoUrl,
      'wiki_url': instance.wikiUrl,
      'image_url': instance.imageURL,
    };
