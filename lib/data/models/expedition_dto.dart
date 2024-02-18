import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/space_station_dto.dart';

part 'expedition_dto.g.dart';

@JsonSerializable()
class ExpeditionDTO {
  final int id;
  final String url;
  final String name;
  final String start;
  final String? end;
  final SpaceStationDTO spacestation;

  ExpeditionDTO({
    required this.id,
    required this.url,
    required this.name,
    required this.start,
    this.end,
    required this.spacestation,
  });

  factory ExpeditionDTO.fromJson(Map<String, dynamic> json) =>
      _$ExpeditionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExpeditionDTOToJson(this);
}
