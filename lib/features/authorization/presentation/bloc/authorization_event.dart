part of 'authorization_bloc.dart';

class AuthorizationEvent {}

class AuthorizationSubmit extends AuthorizationEvent {
  final String email;
  final String password;

  AuthorizationSubmit({required this.email, required this.password});
}
