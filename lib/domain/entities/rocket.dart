import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';
part 'rocket.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes rocket object
class Rocket {
  /// ID of object.
  final int id;

  /// Rocket's configuration.
  RocketConfiguration configuration;

  /// Creates [Rocket] object.
  Rocket(this.id, this.configuration);

  ///Converter from json to [Rocket] object.
  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);

  ///Converter from  [Rocket] object to json.
  Map<String, dynamic> toJson() => _$RocketToJson(this);
}
