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

  void toggleFavouriteEvent(Event event) {
    var currentState = state;
    if (currentState is FavouriteEventsLoaded) {
      var currentEvents = List<Event>.from(currentState.events);
      bool isFavourite = currentEvents.any((e) => e.id == event.id);

      // Update the state optimistically
      if (isFavourite) {
        currentEvents.removeWhere((e) => e.id == event.id);
      } else {
        currentEvents.add(event);
      }
      emit(FavouriteEventsLoaded(currentEvents));

      // Perform the actual update asynchronously
      if (isFavourite) {
        removeFavouriteEvent(event.id.toString());
      } else {
        setFavouriteEvent(event);
      }
    }
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
      await setFavouriteEventUseCase(event);
    } catch (e) {
      logger.e('Failed to set favourite event: ${e.toString()}');
      // Optionally handle errors by reverting the optimistic update
    }
  }

  void removeFavouriteEvent(String eventId) async {
    try {
      await removeFavouriteEventUseCase(eventId);
    } catch (e) {
      logger.e('Failed to remove favourite event: ${e.toString()}');
      // Optionally handle errors by reverting the optimistic update
    }
  }
}
