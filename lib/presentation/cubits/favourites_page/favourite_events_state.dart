import 'package:project_kepler/domain/entities/event.dart';

abstract class FavouriteEventsState {}

class FavouriteEventsInit extends FavouriteEventsState {}

class FavouriteEventsLoaded extends FavouriteEventsState {
  final List<Event> events;
  FavouriteEventsLoaded(this.events);
}

class FavouriteEventsError extends FavouriteEventsState {
  final String message;

  FavouriteEventsError(this.message);
}
