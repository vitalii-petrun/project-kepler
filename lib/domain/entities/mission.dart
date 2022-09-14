import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/orbit.dart';

part 'mission.g.dart';

@JsonSerializable(explicitToJson: true)

/// Space mission within which the launch is carried out.
class Mission {
  /// ID of mission.
  final int id;

  /// Mission name.
  final String name;

  /// Description of mission.
  final String description;

  /// Mission type.
  final String type;

  /// Orbit on which mission will be provided.
  final Orbit orbit;

  /// Creates [Mission] object.
  Mission(this.id, this.name, this.description, this.type, this.orbit);

  ///Converter from json to [Mission] object.
  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);

  ///Converter from  [Mission] object to json.
  Map<String, dynamic> toJson() => _$MissionToJson(this);
}
