// import '../../data/models/launch_status_dto.dart';
// import '../entities/launch_status.dart';

import 'dart:convert';

import '../../data/models/launch_status_dto.dart';
import '../entities/launch_status.dart';

class LaunchStatusDtoToEntityConverter
    extends Converter<LaunchStatusDTO, LaunchStatus> {
  @override
  LaunchStatus convert(LaunchStatusDTO input) {
    return LaunchStatus(
      input.id,
      input.name,
      input.description,
    );
  }
}

class LaunchStatusEntityToDtoConverter
    extends Converter<LaunchStatus, LaunchStatusDTO> {
  @override
  LaunchStatusDTO convert(LaunchStatus input) {
    return LaunchStatusDTO(
      input.id,
      input.name,
      input.description,
    );
  }
}
