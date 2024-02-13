import 'dart:convert';

import '../../data/models/orbit_dto.dart';
import '../entities/orbit.dart';

class OrbitDtoToEntityConverter extends Converter<OrbitDTO, Orbit> {
  @override
  Orbit convert(OrbitDTO input) {
    return Orbit(
      input.id,
      input.name,
      input.abbrev,
    );
  }
}

class OrbitEntityToDtoConverter extends Converter<Orbit, OrbitDTO> {
  @override
  OrbitDTO convert(Orbit input) {
    return OrbitDTO(
      input.id,
      input.name,
      input.abbrev,
    );
  }
}
