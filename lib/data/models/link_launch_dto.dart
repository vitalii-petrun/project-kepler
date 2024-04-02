import 'package:json_annotation/json_annotation.dart';

part 'link_launch_dto.g.dart';

@JsonSerializable()
class LinkLaunchDTO {
  /// Used in Event model as a link to the Launch model.

  @JsonKey(name: 'launch_id')
  final String? launchID;
  final String? provider;

  LinkLaunchDTO({
    required this.launchID,
    required this.provider,
  });

  factory LinkLaunchDTO.fromJson(Map<String, dynamic> json) =>
      _$LinkLaunchDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LinkLaunchDTOToJson(this);
}
