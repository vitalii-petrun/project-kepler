import 'package:json_annotation/json_annotation.dart';

part 'pad_location_dto.g.dart';

@JsonSerializable()

/// Physical location of the site.
class PadLocationDTO {
  /// ID of object.
  final int id;

  /// Name of launch pad.
  final String name;

  @JsonKey(name: 'total_launch_count')

  /// Total launch count
  final int? totalLaunchCount;

  @JsonKey(name: 'total_landing_count')

  /// Total landing count.
  final int? totalLandingCount;

  ///Сreates [PadLocationDTO] object.
  PadLocationDTO(
    this.id,
    this.name,
    this.totalLaunchCount,
    this.totalLandingCount,
  );

  ///Converter from json to [PadLocationDTO] object.
  factory PadLocationDTO.fromJson(Map<String, dynamic> json) =>
      _$PadLocationDTOFromJson(json);

  ///Converter from  [PadLocationDTO] object to json.
  Map<String, dynamic> toJson() => _$PadLocationDTOToJson(this);
}
