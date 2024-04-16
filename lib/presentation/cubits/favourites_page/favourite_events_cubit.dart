import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/use_cases/fetch_favourite_events_use_case.dart';
import 'package:project_kepler/domain/use_cases/remove_favourite_event_use_case.dart';
import 'package:project_kepler/domain/use_cases/set_favourite_event_use_case.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_state.dart';

class FavouriteEventsCubit extends Cubit<FavouriteEventsState> {
  final FetchFavouriteEventsUseCase fetchFavouriteEventsUseCase;
  final SetFavouriteEventUseCase setFavouriteEventUseCase;
  final RemoveFavouriteEventUseCase removeFavouriteEventUseCase;
  final AuthenticationCubit authenticationCubit;

  FavouriteEventsCubit({
    required this.fetchFavouriteEventsUseCase,
    required this.setFavouriteEventUseCase,
    required this.removeFavouriteEventUseCase,
    required this.authenticationCubit,
  }) : super(FavouriteEventsInit()) {
    setUserId();
    fetchFavouriteEvents();
  }

  void setUserId() {
    final userId = authenticationCubit.getUid();
    logger.d('User id: $userId');
    setFavouriteEventUseCase.userId = userId;
    fetchFavouriteEventsUseCase.userId = userId;
    removeFavouriteEventUseCase.userId = userId;
  }

  void clearUserId() {
    setFavouriteEventUseCase.userId = null;
    removeFavouriteEventUseCase.userId = null;
    fetchFavouriteEventsUseCase.userId = null;
  }

  void fetchFavouriteEvents() async {
    try {
      final events = await fetchFavouriteEventsUseCase();
      emit(FavouriteEventsLoaded(events));
    } catch (e) {
      emit(FavouriteEventsError(e.toString()));
    }
  }

  void setFavouriteEvent(Event event) async {
    try {
      logger.d('Setting favourite event: ${event.id}');
      await setFavouriteEventUseCase(event);
      fetchFavouriteEvents();
    } catch (e) {
      emit(FavouriteEventsError(e.toString()));
    }
  }

  void removeFavouriteEvent(String eventId) async {
    try {
      await removeFavouriteEventUseCase(eventId);
      fetchFavouriteEvents();
    } catch (e) {
      emit(FavouriteEventsError(e.toString()));
    }
  }
}
