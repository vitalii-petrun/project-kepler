import 'package:json_annotation/json_annotation.dart';

part 'rocket_configuration.g.dart';

@JsonSerializable()

/// Describes paramaters of rocket.
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

  ///Creates [RocketConfiguration] object
  RocketConfiguration(
    this.id,
    this.name,
    this.family,
    this.fullName,
    this.variant,
  );

  ///Converter from json to [RocketConfiguration] object.
  factory RocketConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RocketConfigurationFromJson(json);

  ///Converter from  [RocketConfiguration] object to json.
  Map<String, dynamic> toJson() => _$RocketConfigurationToJson(this);
}
