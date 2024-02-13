import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/launch_service_provider_dto.dart';
import 'package:project_kepler/data/models/pad_dto.dart';
import 'package:project_kepler/data/models/rocket_dto.dart';

import 'launch_status_dto.dart';
import 'mission_dto.dart';

part 'launch_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LaunchDTO {
  final String id;
  final String net;
  final String name;
  final LaunchStatusDTO status;
  @JsonKey(name: 'launch_service_provider')
  final LaunchServiceProviderDTO launchServiceProvider;
  final MissionDTO? mission;
  final RocketDTO rocket;
  final String? image;

  final PadDTO pad;

  LaunchDTO(
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

  ///Converter from json to [LaunchDTO] object.
  factory LaunchDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchDTOFromJson(json);

  ///Converter from  [LaunchDTO] object to json.
  Map<String, dynamic> toJson() => _$LaunchDTOToJson(this);
}
