import 'package:json_annotation/json_annotation.dart';

part 'launch_status.g.dart';

@JsonSerializable()
class LaunchStatus {
  final int id;
  final String name;
  final String description;

  LaunchStatus(this.id, this.name, this.description);

  ///Converter from json to [LaunchStatus] object.
  factory LaunchStatus.fromJson(Map<String, dynamic> json) =>
      _$LaunchStatusFromJson(json);

  ///Converter from  [LaunchStatus] object to json.
  Map<String, dynamic> toJson() => _$LaunchStatusToJson(this);
}
