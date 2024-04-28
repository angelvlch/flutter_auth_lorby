part of 'password_validation_bloc.dart';

abstract class PasswordEvent {}

class CheckValidationPassword extends PasswordEvent {
  final String password;

  CheckValidationPassword({required this.password});
}
/* class ConfrimValidation extends PasswordEvent{
   final bool isValid;

  ConfrimValidation({required this.isValid});
}
 */