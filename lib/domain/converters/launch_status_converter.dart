import '../../data/models/launch_status_dto.dart';
import '../entities/launch_status.dart';

class LaunchStatusConverter {
  static LaunchStatus fromDto(LaunchStatusDTO dto) {
    return LaunchStatus(
      dto.id,
      dto.name,
      dto.description,
    );
  }

  static LaunchStatusDTO toDto(LaunchStatus launchStatus) {
    return LaunchStatusDTO(
      launchStatus.id,
      launchStatus.name,
      launchStatus.description,
    );
  }
}
