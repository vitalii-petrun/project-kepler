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
}
