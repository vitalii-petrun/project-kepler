import '../../data/models/launch_service_provider_dto.dart';
import '../entities/launch_service_provider.dart';

class LaunchServiceProviderConverter {
  static LaunchServiceProvider fromDto(LaunchServiceProviderDTO dto) {
    return LaunchServiceProvider(
      dto.id,
      dto.name,
      dto.type,
    );
  }

  static LaunchServiceProviderDTO toDto(
      LaunchServiceProvider launchServiceProvider) {
    return LaunchServiceProviderDTO(
      launchServiceProvider.id,
      launchServiceProvider.name,
      launchServiceProvider.type,
    );
  }
}
