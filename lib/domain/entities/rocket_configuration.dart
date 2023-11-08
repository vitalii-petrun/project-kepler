import 'package:json_annotation/json_annotation.dart';

import 'manufacturer.dart';

part 'rocket_configuration.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes parameters of rocket.
class RocketConfiguration {
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
  final Manufacturer? manufacturer;

  /// URL for additional information about the rocket.
  @JsonKey(name: 'info_url')
  final String? infoUrl;

  /// URL for the rocket's wikipedia page.
  @JsonKey(name: 'wiki_url')
  final String? wikiUrl;

  @JsonKey(name: 'image_url')
  final String? imageURL;

  /// Creates [RocketConfiguration] object
  RocketConfiguration(
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

  /// Converter from json to [RocketConfiguration] object.
  factory RocketConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RocketConfigurationFromJson(json);

  /// Converter from [RocketConfiguration] object to json.
  Map<String, dynamic> toJson() => _$RocketConfigurationToJson(this);
}
