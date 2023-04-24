import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);
}
