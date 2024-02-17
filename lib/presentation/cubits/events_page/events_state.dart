import '../../../domain/entities/event.dart';

class EventsPageState {}

class EventsInit extends EventsPageState {}

class EventsLoading extends EventsPageState {}

class EventsLoaded extends EventsPageState {
  final List<Event> events;

  EventsLoaded(this.events);
}

class EventsError extends EventsPageState {
  final String message;

  EventsError(this.message);
}
