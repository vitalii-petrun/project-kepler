import 'package:json_annotation/json_annotation.dart';

import 'manufacturer_dto.dart';

part 'rocket_configuration_dto.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes parameters of rocket.
class RocketConfigurationDTO {
  /// ID of object.
  final int id;

  /// Rocket's name.
  final String name;

  /// Rocket's family.
  final String family;

  @JsonKey(name: 'full_name')

  /// Full name.
  final String fullName;

  /// Rocket's variant.
  final String variant;

  /// Rocket's manufacturer.
  final ManufacturerDTO? manufacturer;

  /// URL for additional information about the rocket.
  @JsonKey(name: 'info_url')
  final String? infoUrl;

  /// URL for the rocket's wikipedia page.
  @JsonKey(name: 'wiki_url')
  final String? wikiUrl;

  @JsonKey(name: 'image_url')
  final String? imageURL;

  /// Creates [RocketConfigurationDTO] object
  RocketConfigurationDTO(
    this.id,
    this.name,
    this.family,
    this.fullName,
    this.variant,
    this.manufacturer,
    this.infoUrl,
    this.wikiUrl,
    this.imageURL,
  );

  /// Converter from json to [RocketConfigurationDTO] object.
  factory RocketConfigurationDTO.fromJson(Map<String, dynamic> json) =>
      _$RocketConfigurationDTOFromJson(json);

  /// Converter from [RocketConfigurationDTO] object to json.
  Map<String, dynamic> toJson() => _$RocketConfigurationDTOToJson(this);
}
