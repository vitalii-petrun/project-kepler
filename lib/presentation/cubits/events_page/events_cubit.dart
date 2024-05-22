import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/l10n/locale_translation_service.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_state.dart';

import '../../../domain/use_cases/get_all_events_use_case.dart';

class EventsCubit extends Cubit<EventsPageState> {
  final GetAllEventsUseCase getAllEventsUseCase;
  final LocaleTranslationService localeTranslationService;

  EventsCubit(this.getAllEventsUseCase, this.localeTranslationService)
      : super(EventsInit()) {
    localeTranslationService.addListener(_onLocaleChanged);
  }

  Future<void> fetch() async {
    emit(EventsLoading());
    try {
      final events = await getAllEventsUseCase();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  void _onLocaleChanged() {
    fetch();
  }
}
