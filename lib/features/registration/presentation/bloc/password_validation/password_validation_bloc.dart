import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_validation_state.dart';
part 'password_validation_event.dart';

class PasswordValidation extends Bloc<PasswordEvent, PasswordState> {
  PasswordValidation() : super(Initial()) {
    on<CheckValidationPassword>(_checkPassword);
    // on<ConfrimValidation>(_confirmValidation);
  }

  FutureOr<void> _checkPassword(
      CheckValidationPassword event, Emitter<PasswordState> emit) {
    final password = event.password;
    bool isLenght = false,
        isLowerAndUpperCase = false,
        isMinOneDigit = false,
        isMinOneSpecSymbol = false;
    if (password.length >= 8 && event.password.length <= 15) {
      isLenght = true;
    }
    if (RegExp('[a-z]').hasMatch(password) &&
        RegExp('[A-Z]').hasMatch(password)) {
      isLowerAndUpperCase = true;
    }
    if (RegExp('[1-9]').hasMatch(password)) {
      isMinOneDigit = true;
    }
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      isMinOneSpecSymbol = true;
    }

    emit(PasswordValidationState(validRules: [
      isLenght,
      isLowerAndUpperCase,
      isMinOneDigit,
      isMinOneSpecSymbol,
    ]));
  }

  /* FutureOr<void> _confirmValidation(ConfrimValidation event, Emitter<PasswordState> emit) {
    emit(ValidationResults(isValid: event.isValid));
  } */
}
