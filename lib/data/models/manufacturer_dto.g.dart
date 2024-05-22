// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manufacturer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManufacturerDTO _$ManufacturerDTOFromJson(Map<String, dynamic> json) =>
    ManufacturerDTO(
      (json['id'] as num).toInt(),
      json['url'] as String,
      json['name'] as String,
      json['type'] as String,
      json['country_code'] as String,
      json['abbrev'] as String,
      json['description'] as String?,
      json['administrator'] as String?,
      json['founding_year'] as String?,
      json['spacecraft'] as String,
      json['image_url'] as String?,
      json['logo_url'] as String?,
    );

Map<String, dynamic> _$ManufacturerDTOToJson(ManufacturerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'type': instance.type,
      'country_code': instance.countryCode,
      'abbrev': instance.abbrev,
      'description': instance.description,
      'administrator': instance.administrator,
      'founding_year': instance.foundingYear,
      'spacecraft': instance.spacecraft,
      'image_url': instance.imageUrl,
      'logo_url': instance.logoUrl,
    };
