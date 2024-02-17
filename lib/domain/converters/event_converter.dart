import 'dart:convert';

import 'package:project_kepler/data/models/event2_dto.dart';
import 'package:project_kepler/domain/converters/expedition_converter.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/converters/spacestation_converter.dart';
import 'package:project_kepler/domain/converters/type_converter.dart';

import '../entities/event.dart';

class EventDtoToEntityConverter extends Converter<EventDTO, Event> {
  @override
  Event convert(EventDTO input) {
    return Event(
      id: input.id,
      url: input.url,
      name: input.name,
      type: TypeDTOToEntityConverter().convert(input.type),
      description: input.description,
      webcastLive: input.webcastLive,
      location: input.location,
      newsUrl: input.newsUrl,
      videoUrl: input.videoUrl,
      featureImage: input.featureImage,
      date: DateTime.parse(input.date),
      launches: input.launches
          .map((launch) =>
              LaunchDtoToEntityConverter().convert(launch as dynamic))
          .toList(),
      expeditions: input.expeditions
          .map((expedition) =>
              ExpeditionDTOtoEntityConverter().convert(expedition))
          .toList(),
      spaceStations: input.spaceStations
          .map((spaceStation) =>
              SpaceStationDTOToEntityConverter().convert(spaceStation))
          .toList(),
    );
  }
}
