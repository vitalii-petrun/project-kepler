// import '../../data/models/launch_service_provider_dto.dart';
// import '../entities/launch_service_provider.dart';

// class LaunchServiceProviderConverter {
//   static LaunchServiceProvider fromDto(LaunchServiceProviderDTO dto) {
//     return LaunchServiceProvider(
//       dto.id,
//       dto.name,
//       dto.type,
//     );
//   }

//   static LaunchServiceProviderDTO toDto(
//       LaunchServiceProvider launchServiceProvider) {
//     return LaunchServiceProviderDTO(
//       launchServiceProvider.id,
//       launchServiceProvider.name,
//       launchServiceProvider.type,
//     );
//   }
// }

import 'dart:convert';

import '../../data/models/launch_service_provider_dto.dart';
import '../entities/launch_service_provider.dart';

class LaunchServiceProviderDtoToEntityConverter
    extends Converter<LaunchServiceProviderDTO, LaunchServiceProvider> {
  @override
  LaunchServiceProvider convert(LaunchServiceProviderDTO input) {
    return LaunchServiceProvider(
      input.id,
      input.name,
      input.type,
    );
  }
}

class LaunchServiceProviderEntityToDtoConverter
    extends Converter<LaunchServiceProvider, LaunchServiceProviderDTO> {
  @override
  LaunchServiceProviderDTO convert(LaunchServiceProvider input) {
    return LaunchServiceProviderDTO(
      input.id,
      input.name,
      input.type,
    );
  }
}
