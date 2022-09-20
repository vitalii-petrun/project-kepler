import 'package:project_kepler/domain/entities/launch.dart';

abstract class HomePageState {}

class LaunchesInit extends HomePageState {}

class LaunchesLoaded extends HomePageState {
  final List<Launch> launches;
  LaunchesLoaded(this.launches);
}
