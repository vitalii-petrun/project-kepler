import '../../../domain/entities/launch.dart';

abstract class LaunchDetailsPageState {}

class LaunchDetailsPageStateInit extends LaunchDetailsPageState {}

class LaunchDetailsPageStateLoaded extends LaunchDetailsPageState {
  final Launch launch;

  LaunchDetailsPageStateLoaded(this.launch);
}

class LaunchDetailsPageStateError extends LaunchDetailsPageState {
  final String message;

  LaunchDetailsPageStateError(this.message);
}
