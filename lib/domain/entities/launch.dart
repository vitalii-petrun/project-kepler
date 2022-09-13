import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/launch_service_provider.dart';
import 'package:project_kepler/domain/entities/launch_status.dart';
import 'package:project_kepler/domain/entities/mission.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/domain/entities/rocket.dart';

part 'launch.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes a launch settings.
class Launch {
  /// ID of launch.
  final String id;

  /// Name of launch.
  final String name;

  /// Launch status.
  final LaunchStatus status;

  /// Time of launch
  final String net;

  @JsonKey(name: 'launch_service_provider')
  /// Company that provides launch.
  final LaunchServiceProvider launchServiceProvider;

  /// Rocket to launch.
  final Rocket rocket;

  /// Space mission.
  final Mission mission;

  /// Place where launch of rocket is provided.
  final Pad pad;

  /// Link to image.
  final String image;

  ///Creates [Launch] object
  Launch(
    this.id,
    this.name,
    this.status,
    this.net,
    this.launchServiceProvider,
    this.rocket,
    this.mission,
    this.pad,
    this.image,
  );

  ///Converter from json to [Launch] object.
  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  ///Converter from  [Launch] object to json.
  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
