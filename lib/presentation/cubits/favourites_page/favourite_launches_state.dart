import 'package:project_kepler/domain/entities/launch.dart';

abstract class FavouriteLaunchesState {}

class FavouriteLaunchesInit extends FavouriteLaunchesState {}

class FavouriteLaunchesLoaded extends FavouriteLaunchesState {
  final List<Launch> launches;
  FavouriteLaunchesLoaded(this.launches);
}

class FavouriteLaunchesError extends FavouriteLaunchesState {
  final String message;

  FavouriteLaunchesError(this.message);
}
