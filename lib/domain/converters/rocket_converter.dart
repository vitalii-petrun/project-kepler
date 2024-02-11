import 'package:project_kepler/domain/entities/rocket.dart';
import 'package:project_kepler/data/models/rocket_dto.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';

import '../../data/models/rocket_configuration_dto.dart';
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

  static RocketDTO toDto(Rocket rocket) {
    return RocketDTO(
      rocket.id,
      RocketConfigurationDTO(
        rocket.configuration.id,
        rocket.configuration.name,
        rocket.configuration.family,
        rocket.configuration.fullName,
        rocket.configuration.variant,
        rocket.configuration.manufacturer != null
            ? ManufacturerConverter.toDto(rocket.configuration.manufacturer!)
            : null,
        rocket.configuration.infoUrl,
        rocket.configuration.wikiUrl,
        rocket.configuration.imageURL,
      ),
    );
  }
}
