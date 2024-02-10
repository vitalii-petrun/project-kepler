import 'package:project_kepler/domain/entities/rocket.dart';
import 'package:project_kepler/data/models/rocket_dto.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';

import 'manufacturer_converter.dart';
// Import other necessary files

class RocketConverter {
  static Rocket fromDto(RocketDTO dto) {
    final configuration = RocketConfiguration(
      dto.configuration.id,
      dto.configuration.name,
      dto.configuration.family,
      dto.configuration.fullName,
      dto.configuration.variant,
      dto.configuration.manufacturer != null
          ? ManufacturerConverter.fromDto(dto.configuration.manufacturer!)
          : null,
      dto.configuration.infoUrl,
      dto.configuration.wikiUrl,
      dto.configuration.imageURL,
    );

    return Rocket(
      dto.id,
      configuration,
    );
  }

  // Add a toDto method if necessary
}
