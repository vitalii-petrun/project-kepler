import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:project_kepler/domain/converters/pad_converter.dart';
import 'package:project_kepler/domain/converters/rocket_converter.dart';
import 'package:project_kepler/domain/entities/launch.dart';
import 'package:project_kepler/data/models/launch_dto.dart';

import 'launch_service_provider_converter.dart';
import 'launch_status_converter.dart';
import 'mission_converter.dart';

@injectable
class LaunchDtoToEntityConverter extends Converter<LaunchDTO, Launch> {
  @override
  Launch convert(LaunchDTO input) {
    return Launch(
      input.id,
      input.name,
      LaunchStatusDtoToEntityConverter().convert(input.status),
      input.net,
      LaunchServiceProviderDtoToEntityConverter()
          .convert(input.launchServiceProvider),
      RocketDtoToEntityConverter().convert(input.rocket),
      input.mission != null
          ? MissionDtoToEntityConverter().convert(input.mission!)
          : null,
      PadDtoToEntityConverter().convert(input.pad),
      input.image,
    );
  }
}

class LaunchEntityToDtoConverter extends Converter<Launch, LaunchDTO> {
  @override
  LaunchDTO convert(Launch input) {
    return LaunchDTO(
      input.id,
      input.name,
      LaunchStatusEntityToDtoConverter().convert(input.status),
      input.net,
      LaunchServiceProviderEntityToDtoConverter()
          .convert(input.launchServiceProvider),
      RocketEntityToDtoConverter().convert(input.rocket),
      input.mission != null
          ? MissionEntityToDtoConverter().convert(input.mission!)
          : null,
      PadEntityToDtoConverter().convert(input.pad),
      input.image,
    );
  }
}
