part of 'authorization_bloc.dart';

class AuthorizationState {}

class AuthorizationInitial extends AuthorizationState {}

class AuthorizationDone extends AuthorizationState {}

class AuthorizationFailure extends AuthorizationState {
  final Object? error;

  AuthorizationFailure({required this.error});
}
