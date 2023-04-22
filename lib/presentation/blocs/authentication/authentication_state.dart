import 'package:firebase_auth/firebase_auth.dart';

class AutheticationState {}

class Unauthenticated extends AutheticationState {}

class Authenticated extends AutheticationState {
  final User user;

  Authenticated(this.user);
}
