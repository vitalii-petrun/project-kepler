// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyDTO _$AgencyDTOFromJson(Map<String, dynamic> json) => AgencyDTO(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['abbrev'] as String,
      json['countryCode'] as String?,
      json['type'] as String?,
      json['description'] as String?,
      json['administrator'] as String?,
      json['image_url'] as String?,
      json['logo_url'] as String?,
    );

Map<String, dynamic> _$AgencyDTOToJson(AgencyDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbrev': instance.abbrev,
      'countryCode': instance.countryCode,
      'type': instance.type,
      'description': instance.description,
      'administrator': instance.administrator,
      'image_url': instance.imageUrl,
      'logo_url': instance.logoUrl,
    };
