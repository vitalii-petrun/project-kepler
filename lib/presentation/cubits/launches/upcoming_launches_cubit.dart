import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/domain/use_cases/get_upcoming_launches_use_case.dart';
import 'launches_state.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';

class UpcomingLaunchesCubit extends Cubit<LaunchesState> {
  final GetUpcomingLaunchesUseCase getUpcomingLaunchesUseCase;
  final LocaleTranslationService localeTranslationService;

  UpcomingLaunchesCubit(
      this.getUpcomingLaunchesUseCase, this.localeTranslationService)
      : super(LaunchesInit()) {
    localeTranslationService.addListener(_onLocaleChanged);
  }

  Future<void> fetch() async {
    emit(LaunchesLoading());

    try {
      final launches = await getUpcomingLaunchesUseCase();
      emit(LaunchesLoaded(launches));
    } catch (e) {
      emit(LaunchesError(e.toString()));
    }
  }

  void _onLocaleChanged() {
    fetch();
  }

  @override
  Future<void> close() {
    localeTranslationService.removeListener(_onLocaleChanged);
    return super.close();
  }
}
