import 'package:equatable/equatable.dart';
import 'package:project_kepler/domain/entities/launch.dart';

abstract class LaunchesPageState extends Equatable {
  const LaunchesPageState();

  @override
  List<Object> get props => [];
}

class LaunchesInit extends LaunchesPageState {}

class LaunchesLoading extends LaunchesPageState {}

class LaunchesLoaded extends LaunchesPageState {
  final List<Launch> launches;
  const LaunchesLoaded(this.launches);
}

class LaunchesError extends LaunchesPageState {
  final String message;

  const LaunchesError(this.message);
}
