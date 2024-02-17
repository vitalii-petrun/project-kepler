import 'package:json_annotation/json_annotation.dart';
import 'package:project_kepler/data/models/type_dto.dart';

part 'space_station_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SpaceStationDTO {
  final String id;
  final String url;
  final String name;
  final TypeDTO status;
  final String founded;
  final String description;
  final String orbit;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  SpaceStationDTO({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.founded,
    required this.description,
    required this.orbit,
    required this.imageUrl,
  });

  factory SpaceStationDTO.fromJson(Map<String, dynamic> json) =>
      _$SpaceStationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceStationDTOToJson(this);
}
