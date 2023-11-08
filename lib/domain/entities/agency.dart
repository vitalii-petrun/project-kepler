import 'package:json_annotation/json_annotation.dart';

part 'agency.g.dart';

@JsonSerializable(explicitToJson: true)
class Agency {
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

  Agency(
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
  Agency.empty()
      : id = 0,
        name = "",
        abbrev = "",
        countryCode = "",
        type = "",
        description = "",
        administrator = "",
        imageUrl = "",
        logoUrl = "";

  ///Converter from json to [Agency] object.
  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  ///Converter from  [Agency] object to json.
  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}
