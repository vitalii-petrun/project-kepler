import 'package:json_annotation/json_annotation.dart';

part 'agency_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AgencyDTO {
  final int id;
  final String name;
  final String abbrev;
  final String? countryCode;
  final String? type;
  final String? description;
  final String? administrator;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;

  AgencyDTO(
    this.id,
    this.name,
    this.abbrev,
    this.countryCode,
    this.type,
    this.description,
    this.administrator,
    this.imageUrl,
    this.logoUrl,
  );
  AgencyDTO.empty()
      : id = 0,
        name = "",
        abbrev = "",
        countryCode = "",
        type = "",
        description = "",
        administrator = "",
        imageUrl = "",
        logoUrl = "";

  ///Converter from json to [AgencyDTO] object.
  factory AgencyDTO.fromJson(Map<String, dynamic> json) =>
      _$AgencyDTOFromJson(json);

  ///Converter from  [AgencyDTO] object to json.
  Map<String, dynamic> toJson() => _$AgencyDTOToJson(this);
}
