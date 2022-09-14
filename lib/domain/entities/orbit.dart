import 'package:json_annotation/json_annotation.dart';
part 'orbit.g.dart';

@JsonSerializable()

///Describes orbit on which launch mission will be provided.
class Orbit {
  /// ID of object.
  final int id;

  /// Orbit name.
  final String name;

  /// Orbit abbrev.
  final String abbrev;

  /// Creates [Orbit] object.
  Orbit(this.id, this.name, this.abbrev);

  ///Converter from json to [Orbit] object.
  factory Orbit.fromJson(Map<String, dynamic> json) => _$OrbitFromJson(json);

  ///Converter from  [Orbit] object to json.
  Map<String, dynamic> toJson() => _$OrbitToJson(this);
}
