import '../../../domain/entities/agency.dart';
import '../../../domain/entities/launch.dart';

abstract class LaunchDetailsPageState {}

class LaunchDetailsPageStateInit extends LaunchDetailsPageState {}

class LaunchDetailsPageStateLoaded extends LaunchDetailsPageState {
  final Launch launch;
  final Agency? agency;

  LaunchDetailsPageStateLoaded(this.launch, this.agency);
}

class LaunchDetailsPageStateError extends LaunchDetailsPageState {
  final String message;

  LaunchDetailsPageStateError(this.message);
}
