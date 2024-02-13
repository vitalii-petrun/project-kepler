import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/pad_location_dto.dart';
import 'package:project_kepler/domain/entities/pad_location.dart';
part 'pad_dto.g.dart';

@JsonSerializable(explicitToJson: true)

/// Describes place where launch of rocket is provided.
class PadDTO {
  /// ID of object.
  final int id;

  /// ID of agency which provides the launch.
  @JsonKey(name: 'agency_id')
  final int? agencyID;

  /// Pad name.
  final String name;

  /// Physical location of the site.
  final PadLocationDTO location;

  /// Creates [PadDTO] object.
  PadDTO(this.id, this.agencyID, this.name, this.location);

  ///Converter from json to [PadLocation] object.
  factory PadDTO.fromJson(Map<String, dynamic> json) => _$PadDTOFromJson(json);

  ///Converter from  [PadLocation] object to json.
  Map<String, dynamic> toJson() => _$PadDTOToJson(this);
}
