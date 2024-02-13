import '../../../domain/entities/firestore_user.dart';

abstract class FriendsPageState {}

class FriendsInit extends FriendsPageState {}

class FriendsLoading extends FriendsPageState {}

class FriendsLoaded extends FriendsPageState {
  final List<FirestoreUser> users;

  FriendsLoaded(this.users);
}

class FriendsError extends FriendsPageState {
  final String message;

  FriendsError(this.message);
}

class FriendsEmpty extends FriendsPageState {}
