// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      json['id'] as int,
      json['name'] as String,
      json['abbrev'] as String,
      json['countryCode'] as String?,
      json['type'] as String?,
      json['description'] as String?,
      json['administrator'] as String?,
      json['image_url'] as String?,
      json['logo_url'] as String?,
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
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
