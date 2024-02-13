import 'dart:convert';

import '../../data/models/pad_location_dto.dart';
import '../entities/pad_location.dart';

class PadLocationDtoToEntityConverter
    extends Converter<PadLocationDTO, PadLocation> {
  @override
  PadLocation convert(PadLocationDTO input) {
    return PadLocation(
      input.id,
      input.name,
      input.totalLaunchCount,
      input.totalLandingCount,
    );
  }
}

class PadLocationEntityToDtoConverter
    extends Converter<PadLocation, PadLocationDTO> {
  @override
  PadLocationDTO convert(PadLocation input) {
    return PadLocationDTO(
      input.id,
      input.name,
      input.totalLaunchCount,
      input.totalLandingCount,
    );
  }
}
