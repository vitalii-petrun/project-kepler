import 'package:json_annotation/json_annotation.dart';

part 'launch2_dto.g.dart';

@JsonSerializable()
class LaunchDTO {
  // Used in Event model as a link to the Launch model.

  @JsonKey(name: 'launch_id')
  final String? launchID;
  final String? provider;

  LaunchDTO({
    required this.launchID,
    required this.provider,
  });

  factory LaunchDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchDTOToJson(this);
}
