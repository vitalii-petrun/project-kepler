import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/domain/use_cases/locale_aware_use_case.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

import '../../../domain/entities/launch.dart';
import '../../../domain/entities/agency.dart';

class GetLaunchDetailsUseCase extends LocaleAwareUseCase {
  final SpaceDevsRepository repository;

  GetLaunchDetailsUseCase(
      this.repository, LocaleTranslationService localeTranslationService)
      : super(localeTranslationService);

  Future<LaunchDetailsResult> call(String id) async {
    final launch = await repository.getLaunchDetailsById(id);
    final translatedLaunch =
        await localeTranslationService.translateIfNecessary(launch);
    final agency = await repository.getAgencyById(launch.pad.agencyID);
    return LaunchDetailsResult(translatedLaunch as Launch, agency);
  }

  @override
  void onLocaleChanged() {
    // Implement the logic that needs to be executed when the locale changes
    call(''); // TODO: pass id.
  }
}

class LaunchDetailsResult {
  final Launch launch;
  final Agency? agency;

  LaunchDetailsResult(this.launch, this.agency);
}
