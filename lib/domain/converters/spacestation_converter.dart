import 'dart:convert';

import 'package:project_kepler/domain/converters/type_converter.dart';

import '../../data/models/space_station_dto.dart';
import '../entities/spacestation.dart';

class SpaceStationDTOToEntityConverter
    extends Converter<SpaceStationDTO, SpaceStation> {
  @override
  SpaceStation convert(SpaceStationDTO input) {
    return SpaceStation(
      id: input.id,
      url: input.url,
      name: input.name,
      status: TypeDTOToEntityConverter().convert(input.status),
      founded: input.founded ?? "",
      description: input.description ?? "",
      orbit: input.orbit,
      imageUrl: input.imageUrl ?? "",
    );
  }
}

class SpaceStationEntityToDTOConverter
    extends Converter<SpaceStation, SpaceStationDTO> {
  @override
  SpaceStationDTO convert(SpaceStation input) {
    return SpaceStationDTO(
      id: input.id,
      url: input.url,
      name: input.name,
      status: TypeEntityToDTOConverter().convert(input.status),
      founded: input.founded,
      description: input.description,
      orbit: input.orbit,
      imageUrl: input.imageUrl,
    );
  }
}
