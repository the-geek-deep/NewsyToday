import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class UnauthenticatedState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticatedState({required this.user});
}
