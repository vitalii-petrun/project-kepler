// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramDTO _$ProgramDTOFromJson(Map<String, dynamic> json) => ProgramDTO(
      id: json['id'] as int,
      url: json['url'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      agencies: (json['agencies'] as List<dynamic>)
          .map((e) => AgencyDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['image_url'] as String,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      infoUrl: json['info_url'] as String?,
      wikiUrl: json['wiki_url'] as String?,
      missionPatches: (json['mission_patches'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProgramDTOToJson(ProgramDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'description': instance.description,
      'agencies': instance.agencies.map((e) => e.toJson()).toList(),
      'image_url': instance.imageUrl,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'info_url': instance.infoUrl,
      'wiki_url': instance.wikiUrl,
      'mission_patches': instance.missionPatches,
    };
