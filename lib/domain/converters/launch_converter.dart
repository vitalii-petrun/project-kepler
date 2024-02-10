import 'package:project_kepler/domain/converters/pad_converter.dart';
import 'package:project_kepler/domain/converters/rocket_converter.dart';

import '../../data/models/launch_dto.dart';
import '../entities/launch.dart';
import 'launch_service_provider_converter.dart';
import 'launch_status_converter.dart';
import 'mission_converter.dart';

class LaunchConverter {
  static Launch fromDto(LaunchDTO dto) {
    final rocket = RocketConverter.fromDto(dto.rocket);
    final pad = PadConverter.fromDto(dto.pad);
    final mission =
        dto.mission != null ? MissionConverter.fromDto(dto.mission!) : null;
    final status = LaunchStatusConverter.fromDto(dto.status);
    final provider =
        LaunchServiceProviderConverter.fromDto(dto.launchServiceProvider);

    return Launch(
      dto.id,
      dto.name,
      status,
      dto.net,
      provider,
      rocket,
      mission,
      pad,
      dto.image,
    );
  }
}
