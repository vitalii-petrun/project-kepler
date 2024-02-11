import '../../data/models/orbit_dto.dart';
import '../entities/orbit.dart';

class OrbitConverter {
  static Orbit fromDto(OrbitDTO dto) {
    return Orbit(
      dto.id,
      dto.name,
      dto.abbrev,
    );
  }

  static OrbitDTO toDto(Orbit orbit) {
    return OrbitDTO(
      orbit.id,
      orbit.name,
      orbit.abbrev,
    );
  }
}
