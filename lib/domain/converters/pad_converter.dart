import 'dart:convert';

import 'package:project_kepler/domain/converters/pad_location_converter.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/data/models/pad_dto.dart';

class PadDtoToEntityConverter extends Converter<PadDTO, Pad> {
  @override
  Pad convert(PadDTO input) {
    return Pad(
      input.id,
      input.agencyID,
      input.name,
      PadLocationDtoToEntityConverter().convert(input.location),
    );
  }
}

class PadEntityToDtoConverter extends Converter<Pad, PadDTO> {
  @override
  PadDTO convert(Pad input) {
    return PadDTO(
      input.id,
      input.agencyID,
      input.name,
      PadLocationEntityToDtoConverter().convert(input.location),
    );
  }
}
