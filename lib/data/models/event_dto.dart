import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDTO {
  @JsonKey(name: 'event_id')
  final String eventID;
  final String provider;

  EventDTO({
    required this.eventID,
    required this.provider,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) =>
      _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);
}
