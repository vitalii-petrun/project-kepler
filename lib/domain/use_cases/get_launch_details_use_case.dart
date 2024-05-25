import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../../../domain/entities/launch.dart';
import '../../../domain/entities/agency.dart';

class GetLaunchDetailsUseCase {
  final LaunchLibraryRepository repository;

  GetLaunchDetailsUseCase(this.repository);

  Future<LaunchDetailsResult> call(String id) async {
    final launch = await repository.getLaunchDetailsById(id);
    final translatedLaunch =
        await locator<LocaleTranslationService>().translateIfNecessary(launch);
    final agency = await repository.getAgencyById(launch.pad.agencyID);
    return LaunchDetailsResult(translatedLaunch as Launch, agency);
  }
}

class LaunchDetailsResult {
  final Launch launch;
  final Agency? agency;

  LaunchDetailsResult(this.launch, this.agency);
}
