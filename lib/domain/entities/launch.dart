import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/launch_service_provider.dart';
import 'package:project_kepler/domain/entities/launch_status.dart';
import 'package:project_kepler/domain/entities/mission.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/domain/entities/rocket.dart';

part 'launch.g.dart';

@JsonSerializable(explicitToJson: true)
class Launch {
  final String id;
  final String net;
  final String name;
  final LaunchStatus status;
  @JsonKey(name: 'launch_service_provider')
  final LaunchServiceProvider launchServiceProvider;
  final Mission? mission;
  final Rocket rocket;
  final String image;

  final Pad pad;

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
