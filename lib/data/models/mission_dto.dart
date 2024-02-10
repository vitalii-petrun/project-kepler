import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/orbit_dto.dart';

part 'mission_dto.g.dart';

@JsonSerializable(explicitToJson: true)

/// Space mission within which the launch is carried out.
class MissionDTO {
  /// ID of mission.
  final int id;

  /// Mission name.
  final String name;

  /// Description of mission.
  final String description;

  /// Mission type.
  final String type;

  /// Orbit on which mission will be provided.
  final OrbitDTO orbit;

  /// Creates [MissionDTO] object.
  MissionDTO(this.id, this.name, this.description, this.type, this.orbit);

  ///Converter from json to [MissionDTO] object.
  factory MissionDTO.fromJson(Map<String, dynamic> json) =>
      _$MissionDTOFromJson(json);

  ///Converter from  [MissionDTO] object to json.
  Map<String, dynamic> toJson() => _$MissionDTOToJson(this);
}
