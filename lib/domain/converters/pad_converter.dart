import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/data/models/pad_dto.dart';
import 'package:project_kepler/domain/entities/pad_location.dart';
// Import other necessary files

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

  // Add a toDto method if necessary
}
