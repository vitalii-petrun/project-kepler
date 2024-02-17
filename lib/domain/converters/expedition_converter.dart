import 'dart:convert';

import 'package:project_kepler/domain/converters/spacestation_converter.dart';

import '../../data/models/expedition_dto.dart';
import '../entities/expedition.dart';

class ExpeditionDTOtoEntityConverter
    extends Converter<ExpeditionDTO, Expedition> {
  @override
  Expedition convert(ExpeditionDTO input) {
    return Expedition(
      id: input.id,
      url: input.url,
      name: input.name,
      start: input.start,
      end: input.end,
      spacestation:
          SpaceStationDTOToEntityConverter().convert(input.spacestation),
      missionPatches: input.missionPatches,
      spacewalks: input.spacewalks,
    );
  }
}

class ExpeditionEntitytoDTOConverter
    extends Converter<Expedition, ExpeditionDTO> {
  @override
  ExpeditionDTO convert(Expedition input) {
    return ExpeditionDTO(
      id: input.id,
      url: input.url,
      name: input.name,
      start: input.start,
      end: input.end,
      spacestation:
          SpaceStationEntityToDTOConverter().convert(input.spacestation),
      missionPatches: input.missionPatches,
      spacewalks: input.spacewalks,
    );
  }
}
