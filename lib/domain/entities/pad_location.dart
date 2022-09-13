import 'package:json_annotation/json_annotation.dart';

part 'pad_location.g.dart';

@JsonSerializable()

/// Physical location of the site.
class PadLocation {
  /// ID of object.
  final int id;

  /// Name of launch pad.
  final String name;

  /// Total launch count
  final int? totalLaunchCount;

  /// Total landing count.
  final int? totalLandingCount;

  ///Сreates [PadLocation] object.
  PadLocation(
    this.id,
    this.name,
    this.totalLaunchCount,
    this.totalLandingCount,
  );

  ///Converter from json to [PadLocation] object.
  factory PadLocation.fromJson(Map<String, dynamic> json) =>
      _$PadLocationFromJson(json);

  ///Converter from  [PadLocation] object to json.
  Map<String, dynamic> toJson() => _$PadLocationToJson(this);
}
