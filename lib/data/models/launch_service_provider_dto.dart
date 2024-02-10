import 'package:json_annotation/json_annotation.dart';

part 'launch_service_provider_dto.g.dart';

@JsonSerializable()
class LaunchServiceProviderDTO {
  final int id;
  final String name;
  final String? type;

  LaunchServiceProviderDTO(
    this.id,
    this.name,
    this.type,
  );

  ///Converter from json to [LaunchServiceProviderDTO] object.
  factory LaunchServiceProviderDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchServiceProviderDTOFromJson(json);

  ///Converter from  [LaunchServiceProviderDTO] object to json.
  Map<String, dynamic> toJson() => _$LaunchServiceProviderDTOToJson(this);
}
