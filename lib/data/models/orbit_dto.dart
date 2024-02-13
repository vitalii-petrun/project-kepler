import 'package:json_annotation/json_annotation.dart';
part 'orbit_dto.g.dart';

@JsonSerializable()

///Describes orbit on which launch mission will be provided.
class OrbitDTO {
  /// ID of object.
  final int id;

  /// Orbit name.
  final String name;

  /// Orbit abbrev.
  final String abbrev;

  /// Creates [OrbitDTO] object.
  OrbitDTO(this.id, this.name, this.abbrev);

  ///Converter from json to [OrbitDTO] object.
  factory OrbitDTO.fromJson(Map<String, dynamic> json) =>
      _$OrbitDTOFromJson(json);

  ///Converter from  [OrbitDTO] object to json.
  Map<String, dynamic> toJson() => _$OrbitDTOToJson(this);
}
