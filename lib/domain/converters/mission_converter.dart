import '../../data/models/mission_dto.dart';
import '../entities/mission.dart';
import '../entities/orbit.dart';

class MissionConverter {
  static Mission fromDto(MissionDTO dto) {
    return Mission(
      dto.id,
      dto.name,
      dto.description,
      dto.type,
      Orbit(dto.orbit.id, dto.orbit.name, dto.orbit.abbrev),
    );
  }
}
