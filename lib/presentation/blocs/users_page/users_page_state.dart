import '../../../domain/entities/user.dart';

abstract class UsersPageState {}

class UsersInit extends UsersPageState {}

class UsersLoading extends UsersPageState {}

class UsersLoaded extends UsersPageState {
  final List<User> users;

  UsersLoaded(this.users);
}

class UsersError extends UsersPageState {
  final String message;

  UsersError(this.message);
}

class UsersEmpty extends UsersPageState {}
