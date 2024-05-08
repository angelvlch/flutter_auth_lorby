part of 'validation_bloc.dart';

abstract class ValidationEvent {}

class EmailEvent extends ValidationEvent {
  final String? emailError;

  EmailEvent({required this.emailError});
}

class LoginEvent extends ValidationEvent {
  final String? loginError;

  LoginEvent({required this.loginError});
}

class PasswordEvent extends ValidationEvent {
  final String password;

  PasswordEvent({required this.password});
}

class RepeatedPasswordEvent extends ValidationEvent {
  final String repeatedPassword;

  RepeatedPasswordEvent({required this.repeatedPassword});
}
