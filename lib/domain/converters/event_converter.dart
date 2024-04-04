import 'dart:convert';

import 'package:project_kepler/data/models/event2_dto.dart';
import 'package:project_kepler/domain/converters/expedition_converter.dart';

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
      expeditions: input.expeditions == null
          ? []
          : input.expeditions!
              .map((expedition) =>
                  ExpeditionDTOtoEntityConverter().convert(expedition))
              .toList(),
      spaceStations: input.spaceStations == null
          ? []
          : input.spaceStations!
              .map((spaceStation) =>
                  SpaceStationDTOToEntityConverter().convert(spaceStation))
              .toList(),
    );
  }
}

class EventEntityToDtoConverter extends Converter<Event, EventDTO> {
  @override
  EventDTO convert(Event input) {
    return EventDTO(
      id: input.id,
      url: input.url,
      slug: 'slug',
      name: input.name,
      type: TypeEntityToDTOConverter().convert(input.type),
      description: input.description,
      webcastLive: input.webcastLive,
      location: input.location,
      newsUrl: input.newsUrl,
      videoUrl: input.videoUrl,
      featureImage: input.featureImage,
      date: input.date.toIso8601String(),
      expeditions: input.expeditions
          .map((expedition) =>
              ExpeditionEntityToDTOConverter().convert(expedition))
          .toList(),
      spaceStations: input.spaceStations
          .map((spaceStation) =>
              SpaceStationEntityToDTOConverter().convert(spaceStation))
          .toList(),
      lastUpdated: '',
      duration: '',
      agencies: [],
      launches: [],
      programs: [],
    );
  }
}
