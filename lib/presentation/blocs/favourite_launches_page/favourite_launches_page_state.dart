import 'package:project_kepler/domain/entities/launch.dart';

abstract class FavouriteLaunchesPageState {}

class FavouriteLaunchesInit extends FavouriteLaunchesPageState {}

class FavouriteLaunchesLoaded extends FavouriteLaunchesPageState {
  final List<Launch> launches;
  FavouriteLaunchesLoaded(this.launches);
}

class FavouriteLaunchesError extends FavouriteLaunchesPageState {
  final String message;

  FavouriteLaunchesError(this.message);
}
