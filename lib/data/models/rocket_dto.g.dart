// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RocketDTO _$RocketDTOFromJson(Map<String, dynamic> json) => RocketDTO(
      (json['id'] as num).toInt(),
      RocketConfigurationDTO.fromJson(
          json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RocketDTOToJson(RocketDTO instance) => <String, dynamic>{
      'id': instance.id,
      'configuration': instance.configuration.toJson(),
    };
