import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/rocket_configuration_dto.dart';

part 'rocket_dto.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes rocket object
class RocketDTO {
  /// ID of object.
  final int id;

  /// Rocket's configuration.
  RocketConfigurationDTO configuration;

  /// Creates [RocketDTO] object.
  RocketDTO(this.id, this.configuration);

  ///Converter from json to [RocketDTO] object.
  factory RocketDTO.fromJson(Map<String, dynamic> json) =>
      _$RocketDTOFromJson(json);

  ///Converter from  [RocketDTO] object to json.
  Map<String, dynamic> toJson() => _$RocketDTOToJson(this);
}
