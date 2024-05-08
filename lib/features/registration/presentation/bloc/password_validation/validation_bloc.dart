import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_state.dart';
part 'validation_event.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(Initial(validationModel: ValidationModel())) {
    on<EmailEvent>(_checkEmail);
    on<LoginEvent>(_checkLogin);
  }

  /*  FutureOr<void> _checkPassword(
      EmailEvent event, Emitter<ValidationState> emit) {
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
 */
  /* FutureOr<void> _confirmValidation(ConfrimValidation event, Emitter<PasswordState> emit) {
    emit(ValidationResults(isValid: event.isValid));
  } */

  void _checkEmail(EmailEvent event, Emitter<ValidationState> emit) {
    final emailError = event.emailError;
    emit(
      ValidationState(
        validationModel: state.validationModel.copyWith(
          isEmailValid: emailError == null ? true : false,
        ),
      ),
    );
  }

  void _checkLogin(LoginEvent event, Emitter<ValidationState> emit) {
    final loginError = event.loginError;
    emit(
      ValidationState(
        validationModel: state.validationModel.copyWith(
          isEmailValid: loginError == null ? true : false,
        ),
      ),
    );
  }
}
