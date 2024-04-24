import 'package:flutter_test/flutter_test.dart';
import 'package:project_kepler/data/models/launch_service_provider_dto.dart';
import 'package:project_kepler/data/models/launch_status_dto.dart';
import 'package:project_kepler/data/models/manufacturer_dto.dart';
import 'package:project_kepler/data/models/pad_dto.dart';
import 'package:project_kepler/data/models/pad_location_dto.dart';
import 'package:project_kepler/data/models/rocket_configuration_dto.dart';
import 'package:project_kepler/data/models/rocket_dto.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/entities/launch.dart';
import 'package:project_kepler/data/models/launch_dto.dart';
import 'package:project_kepler/domain/entities/launch_service_provider.dart';
import 'package:project_kepler/domain/entities/launch_status.dart';
import 'package:project_kepler/domain/entities/manufacturer.dart';
import 'package:project_kepler/domain/entities/pad.dart';
import 'package:project_kepler/domain/entities/pad_location.dart';
import 'package:project_kepler/domain/entities/rocket.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';

void main() {
  group('LaunchDtoToEntityConverter', () {
    test('should convert LaunchDTO to Launch entity correctly', () {
      // Arrange: Create a mock LaunchDTO object with sample data

      final mockLaunchDTO = LaunchDTO(
        // Provide necessary mock data for testing
        '1',
        'Launch Name',
        LaunchStatusDTO(1, 'Status Name', "asd"),
        '2022-01-01T00:00:00Z',
        LaunchServiceProviderDTO(1, 'Provider Name', 'Provider Type'),
        RocketDTO(
          1,
          RocketConfigurationDTO(
            1,
            'Configuration Name',
            'Type',
            'Family Name',
            'Version',
            ManufacturerDTO(
                1,
                'Manufacturer Name',
                'Manufacturer Type',
                'Manufacturer URL',
                'Manufacturer Wiki URL',
                'Manufacturer Description',
                'Manufacturer Country',
                'Manufacturer Founder',
                'Manufacturer Founded',
                'Manufacturer Launchers',
                'Manufacturer Spacecraft',
                'Manufacturer CEO'),
            null,
            null,
            null,
          ),
        ),
        null,
        PadDTO(
          1,
          2,
          'Pad Name',
          PadLocationDTO(1, 'Location Name', 1, 1),
        ),
        'image_url',
      );

      final converter = LaunchDtoToEntityConverter();

      // Act: Convert the mock LaunchDTO to a Launch entity
      final launchEntity = converter.convert(mockLaunchDTO);

      // Assert: Check if the launchEntity has the expected values
      expect(launchEntity, isA<Launch>());
      expect(launchEntity.id, mockLaunchDTO.id);
      expect(launchEntity.name, mockLaunchDTO.name);
    });
  });

  group('LaunchEntityToDtoConverter', () {
    test('should convert Launch entity to LaunchDTO correctly', () {
      // Arrange: Create a mock Launch entity with sample data
      final mockLaunch = Launch(
        "aaaaaaaaaa",
        "Launch Name",
        LaunchStatus(1, "Status Name", "Status Description"),
        "2022-01-01T00:00:00Z",
        LaunchServiceProvider(1, "Provider Name", "Provider Type"),
        Rocket(
          1,
          RocketConfiguration(
            1,
            "Configuration Name",
            "Type",
            "Family Name",
            "Version",
            Manufacturer(
              1,
              "Manufacturer Name",
              "Manufacturer Type",
              "Manufacturer URL",
              "Manufacturer Wiki URL",
              "Manufacturer Description",
              "Manufacturer Country",
              "Manufacturer Founder",
              "Manufacturer Founded",
              "Manufacturer Launchers",
              "Manufacturer Spacecraft",
              "Manufacturer CEO",
            ),
            null,
            null,
            null,
          ),
        ),
        null,
        Pad(
          1,
          2,
          "Pad Name",
          PadLocation(1, "Location Name", 1, 1),
        ),
        "image_url",
      );

      final converter = LaunchEntityToDtoConverter();

      // Act: Convert the mock Launch entity to a LaunchDTO
      final launchDTO = converter.convert(mockLaunch);

      // Assert: Check if the launchDTO has the expected values
      expect(launchDTO, isA<LaunchDTO>());
      expect(launchDTO.id, mockLaunch.id);
      expect(launchDTO.name, mockLaunch.name);
    });
  });
}
