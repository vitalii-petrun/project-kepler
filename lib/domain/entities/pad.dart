import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/domain/entities/pad_location.dart';
part 'pad.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes place where launch of rocket is provided.
class Pad {
  /// ID of object.
  final int id;


  @JsonKey(name: 'agency_id')
  /// ID of agency which provides the launch.
  final int agencyID;

  /// Pad name.
  final String name;

  /// Physical location of the site.
  final PadLocation location;

  /// Creates [Pad] object.
  Pad(this.id, this.agencyID, this.name, this.location);

  ///Converter from json to [PadLocation] object.
  factory Pad.fromJson(Map<String, dynamic> json) => _$PadFromJson(json);

  ///Converter from  [PadLocation] object to json.
  Map<String, dynamic> toJson() => _$PadToJson(this);
}
