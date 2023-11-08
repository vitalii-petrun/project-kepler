import 'package:project_kepler/domain/entities/launch.dart';

abstract class LaunchesPageState {}

class LaunchesInit extends LaunchesPageState {}

class LaunchesLoaded extends LaunchesPageState {
  final List<Launch> launches;
  LaunchesLoaded(this.launches);
}

class LaunchesError extends LaunchesPageState {
  final String message;

  LaunchesError(this.message);
}
