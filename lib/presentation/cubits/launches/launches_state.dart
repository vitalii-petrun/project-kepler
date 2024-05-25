import 'package:equatable/equatable.dart';
import 'package:project_kepler/domain/entities/launch.dart';

abstract class LaunchesState extends Equatable {
  const LaunchesState();

  @override
  List<Object> get props => [];
}

class LaunchesInit extends LaunchesState {}

class LaunchesLoading extends LaunchesState {}

class LaunchesLoaded extends LaunchesState {
  final List<Launch> launches;
  const LaunchesLoaded(this.launches);
}

class LaunchesError extends LaunchesState {
  final String message;

  const LaunchesError(this.message);
}
