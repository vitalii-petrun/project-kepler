import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/presentation/cubits/events_page/events_state.dart';

import '../../../domain/use_cases/get_all_events_use_case.dart';

class EventsPageCubit extends Cubit<EventsPageState> {
  final GetAllEventsUseCase getAllEventsUseCase;

  EventsPageCubit(this.getAllEventsUseCase) : super(EventsInit());

  void fetch() async {
    emit(EventsLoading());
    try {
      final events = await getAllEventsUseCase();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
