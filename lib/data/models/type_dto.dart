import 'package:json_annotation/json_annotation.dart';

part 'type_dto.g.dart';

@JsonSerializable()
class TypeDTO {
  final int id;
  final String name;

  TypeDTO({
    required this.id,
    required this.name,
  });

  factory TypeDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDTOToJson(this);
}
