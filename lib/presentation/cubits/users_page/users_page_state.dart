import '../../../domain/entities/firestore_user.dart';

abstract class UsersPageState {}

class UsersInit extends UsersPageState {}

class UsersLoading extends UsersPageState {}

class UsersLoaded extends UsersPageState {
  final List<FirestoreUser> users;

  UsersLoaded(this.users);
}

class UsersError extends UsersPageState {
  final String message;

  UsersError(this.message);
}

class UsersEmpty extends UsersPageState {}
