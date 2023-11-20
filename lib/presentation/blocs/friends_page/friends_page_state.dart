import 'package:project_kepler/domain/entities/launch.dart';

abstract class FriendsPageState {}

class FriendsInit extends FriendsPageState {}

class FriendsLoading extends FriendsPageState {}

class FriendsLoaded extends FriendsPageState {
  final List<Launch> launches;

  FriendsLoaded(this.launches);
}

class FriendsError extends FriendsPageState {
  final String message;

  FriendsError(this.message);
}

class FriendsEmpty extends FriendsPageState {}
