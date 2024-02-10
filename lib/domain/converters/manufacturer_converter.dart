import '../../data/models/manufacturer_dto.dart';
import '../entities/manufacturer.dart';

class ManufacturerConverter {
  static Manufacturer fromDto(ManufacturerDTO dto) {
    return Manufacturer(
      dto.id,
      dto.url,
      dto.name,
      dto.type,
      dto.countryCode,
      dto.abbrev,
      dto.description,
      dto.administrator,
      dto.foundingYear,
      dto.spacecraft,
      dto.imageUrl,
      dto.logoUrl,
    );
  }
}
