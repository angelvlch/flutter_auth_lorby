part of 'password_validation_bloc.dart';

abstract class PasswordState {}

class Initial extends PasswordState {}

class PasswordValidationState extends PasswordState {
  final List<bool> validRules;

  PasswordValidationState({required this.validRules});
}

/* class ValidationResults extends PasswordState{
  final bool isValid;

  ValidationResults({required this.isValid});
} */