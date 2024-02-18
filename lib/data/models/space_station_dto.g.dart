// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_station_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceStationDTO _$SpaceStationDTOFromJson(Map<String, dynamic> json) =>
    SpaceStationDTO(
      id: json['id'] as int,
      url: json['url'] as String,
      name: json['name'] as String,
      status: TypeDTO.fromJson(json['status'] as Map<String, dynamic>),
      founded: json['founded'] as String?,
      description: json['description'] as String?,
      orbit: json['orbit'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$SpaceStationDTOToJson(SpaceStationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'status': instance.status.toJson(),
      'founded': instance.founded,
      'description': instance.description,
      'orbit': instance.orbit,
      'image_url': instance.imageUrl,
    };
