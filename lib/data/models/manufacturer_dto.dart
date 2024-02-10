import 'package:json_annotation/json_annotation.dart';

part 'manufacturer_dto.g.dart';

@JsonSerializable()
class ManufacturerDTO {
  final int id;
  final String url;
  final String name;
  final String type;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String abbrev;
  final String? description;
  final String? administrator;
  @JsonKey(name: 'founding_year')
  final String? foundingYear;
  final String spacecraft;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;

  ManufacturerDTO(
    this.id,
    this.url,
    this.name,
    this.type,
    this.countryCode,
    this.abbrev,
    this.description,
    this.administrator,
    this.foundingYear,
    this.spacecraft,
    this.imageUrl,
    this.logoUrl,
  );

  /// Converter from json to [ManufacturerDTO] object.
  factory ManufacturerDTO.fromJson(Map<String, dynamic> json) =>
      _$ManufacturerDTOFromJson(json);

  /// Converter from [ManufacturerDTO] object to json.
  Map<String, dynamic> toJson() => _$ManufacturerDTOToJson(this);
}
