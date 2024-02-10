import '../../data/models/agency_dto.dart';
import '../entities/agency.dart';

class AgencyConverter {
  static Agency fromDto(AgencyDTO dto) {
    return Agency(
      dto.id,
      dto.name,
      dto.abbrev,
      dto.countryCode,
      dto.type,
      dto.description,
      dto.administrator,
      dto.imageUrl,
      dto.logoUrl,
    );
  }
}
