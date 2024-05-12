import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_state.dart';
part 'validation_event.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(Initial(validationModel: ValidationModel())) {
    on<EmailEvent>(_checkEmail);
    on<LoginEvent>(_checkLogin);
    on<PasswordEvent>(_checkPassword);
    on<RePasswordEvent>(_checkRePassword);
  }

  void _checkEmail(EmailEvent event, Emitter<ValidationState> emit) {
    final emailError = event.emailError;
    emit(
      ValidationState(
        validationModel: state.validationModel.copyWith(
          isEmailValid: emailError == null ? true : null,
        ),
      ),
    );
  }

  void _checkLogin(LoginEvent event, Emitter<ValidationState> emit) {
    final loginError = event.loginError;
    emit(
      ValidationState(
        validationModel: state.validationModel.copyWith(
          isLoginValid: loginError == null ? true : null,
        ),
      ),
    );
  }

  FutureOr<void> _checkPassword(
      PasswordEvent event, Emitter<ValidationState> emit) {
    final password = event.password;
    bool? isLenght, isLowerAndUpperLetter, isMinOneDigit, isMinOneSpecSymbol;
    if (password.length >= 8 && event.password.length <= 15) {
      isLenght = true;
    }
    if (RegExp('[a-z]').hasMatch(password) &&
        RegExp('[A-Z]').hasMatch(password)) {
      isLowerAndUpperLetter = true;
    }
    if (RegExp('[1-9]').hasMatch(password)) {
      isMinOneDigit = true;
    }
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      isMinOneSpecSymbol = true;
    }

    emit(ValidationState(
      validationModel: state.validationModel.copyWith(
        hasDigit: isMinOneDigit,
        hasLenght: isLenght,
        hasSpecialSymb: isMinOneSpecSymbol,
        hasUpperLetters: isLowerAndUpperLetter,
      ),
    ));
  }

  FutureOr<void> _checkRePassword(
      RePasswordEvent event, Emitter<ValidationState> emit) {
    final rePasswordError = event.repeatedPasswordError;
    emit(
      ValidationState(
        validationModel: state.validationModel
            .copyWith(isPasswordSimilar: rePasswordError == null ? true : null),
      ),
    );
  }
}
