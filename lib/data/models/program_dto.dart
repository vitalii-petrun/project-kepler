import 'agency_dto.dart';

import 'package:json_annotation/json_annotation.dart';

part 'program_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProgramDTO {
  final int id;
  final String url;
  final String name;
  final String? description;
  final List<AgencyDTO> agencies;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'info_url')
  final String? infoUrl;
  @JsonKey(name: 'wiki_url')
  final String? wikiUrl;
  @JsonKey(name: 'mission_patches')
  final List<String> missionPatches;

  ProgramDTO({
    required this.id,
    required this.url,
    required this.name,
    this.description,
    required this.agencies,
    required this.imageUrl,
    this.startDate,
    this.endDate,
    this.infoUrl,
    this.wikiUrl,
    required this.missionPatches,
  });

  factory ProgramDTO.fromJson(Map<String, dynamic> json) =>
      _$ProgramDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramDTOToJson(this);
}
