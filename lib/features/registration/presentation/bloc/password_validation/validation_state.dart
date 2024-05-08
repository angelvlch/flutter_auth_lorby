part of 'validation_bloc.dart';

class ValidationState {
  final ValidationModel validationModel;

  ValidationState({required this.validationModel});
}

class Initial extends ValidationState {
  Initial({required super.validationModel});
}

class ValidationModel {
  final bool? isEmailValid;
  final bool? isLoginValid;
  final bool? isPasswordSimilar;
  final String? passwod;
  final bool? hasLenght;
  final bool? hasDigit;
  final bool? hasUpperLetters;
  final bool? hasSpecialSymb;

  ValidationModel({
    this.isEmailValid,
    this.isLoginValid,
    this.isPasswordSimilar,
    this.passwod,
    this.hasLenght,
    this.hasDigit,
    this.hasUpperLetters,
    this.hasSpecialSymb,
  });

/* bool get isPasswordValid {
  return hasLenght >=
}
 */
  ValidationModel copyWith({
    bool? isEmailValid,
    bool? isLoginValid,
    bool? isPasswordSimilar,
    String? passwod,
    bool? hasLenght,
    bool? hasDigit,
    bool? hasUpperLetters,
    bool? hasSpecialSymb,
  }) {
    return ValidationModel(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isLoginValid: isLoginValid ?? this.isLoginValid,
        isPasswordSimilar: isPasswordSimilar ?? this.isPasswordSimilar,
        passwod: passwod ?? this.passwod,
        hasDigit: hasDigit ?? this.hasDigit,
        hasLenght: hasLenght ?? this.hasLenght,
        hasUpperLetters: hasUpperLetters ?? this.hasUpperLetters,
        hasSpecialSymb: hasSpecialSymb ?? this.hasSpecialSymb);
  }
}
