import 'dart:convert';

import '../../data/models/mission_dto.dart';
import '../entities/mission.dart';
import 'orbit_converter.dart';

class MissionDtoToEntityConverter extends Converter<MissionDTO, Mission> {
  @override
  Mission convert(MissionDTO input) {
    return Mission(
      input.id,
      input.name,
      input.description,
      input.type,
      OrbitDtoToEntityConverter().convert(input.orbit),
    );
  }
}

class MissionEntityToDtoConverter extends Converter<Mission, MissionDTO> {
  @override
  MissionDTO convert(Mission input) {
    return MissionDTO(
      input.id,
      input.name,
      input.description,
      input.type,
      OrbitEntityToDtoConverter().convert(input.orbit),
    );
  }
}
