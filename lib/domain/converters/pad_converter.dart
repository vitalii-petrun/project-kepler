import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/data/models/pad_dto.dart';
import 'package:project_kepler/domain/entities/pad_location.dart';

import '../../data/models/pad_location_dto.dart';

class PadConverter {
  static Pad fromDto(PadDTO dto) {
    final location = PadLocation(
      dto.location.id,
      dto.location.name,
      dto.location.totalLaunchCount,
      dto.location.totalLandingCount,
    );

    return Pad(
      dto.id,
      dto.agencyID,
      dto.name,
      location,
    );
  }

  static PadDTO toDto(Pad pad) {
    return PadDTO(
      pad.id,
      pad.agencyID,
      pad.name,
      PadLocationDTO(
        pad.location.id,
        pad.location.name,
        pad.location.totalLaunchCount,
        pad.location.totalLandingCount,
      ),
    );
  }
}
