import 'package:json_annotation/json_annotation.dart';

part 'launch_status_dto.g.dart';

@JsonSerializable()
class LaunchStatusDTO {
  final int id;
  final String name;
  final String description;

  LaunchStatusDTO(this.id, this.name, this.description);

  ///Converter from json to [LaunchStatusDTO] object.
  factory LaunchStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchStatusDTOFromJson(json);

  ///Converter from  [LaunchStatusDTO] object to json.
  Map<String, dynamic> toJson() => _$LaunchStatusDTOToJson(this);
}
