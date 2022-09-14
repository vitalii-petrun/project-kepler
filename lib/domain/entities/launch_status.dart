import 'package:json_annotation/json_annotation.dart';

part 'launch_status.g.dart';

@JsonSerializable()

/// Describes single launch status.
class LaunchStatus {
  /// ID of launch status.
  final int id;

  /// Status of launch.
  final String name;

  /// Detailed description.
  final String description;

  /// Default constructor.
  LaunchStatus(this.id, this.name, this.description);

  ///Converter from json to [LaunchStatus] object.
  factory LaunchStatus.fromJson(Map<String, dynamic> json) =>
      _$LaunchStatusFromJson(json);

  ///Converter from  [LaunchStatus] object to json.
  Map<String, dynamic> toJson() => _$LaunchStatusToJson(this);
}
