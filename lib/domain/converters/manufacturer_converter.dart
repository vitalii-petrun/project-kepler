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

  static ManufacturerDTO toDto(Manufacturer manufacturer) {
    return ManufacturerDTO(
      manufacturer.id,
      manufacturer.url,
      manufacturer.name,
      manufacturer.type,
      manufacturer.countryCode,
      manufacturer.abbrev,
      manufacturer.description,
      manufacturer.administrator,
      manufacturer.foundingYear,
      manufacturer.spacecraft,
      manufacturer.imageUrl,
      manufacturer.logoUrl,
    );
  }
}
