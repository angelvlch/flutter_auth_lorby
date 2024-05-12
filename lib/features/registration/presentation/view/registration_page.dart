import 'dart:math';

import 'package:auth_lorby/core/constants/app_colors.dart';
import 'package:auth_lorby/core/constants/app_fonts.dart';
import 'package:auth_lorby/core/constants/app_text.dart';
import 'package:auth_lorby/features/registration/presentation/bloc/password_validation/validation_bloc.dart';
import 'package:auth_lorby/features/widgets/custom_button.dart';
import 'package:auth_lorby/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatedPasswordController = TextEditingController();
  String? emailError;
  String? loginError;
  String? repeatedPasswordError;
  bool isValidation = false;
  bool isObcsure = true;
  bool isObscureRepeatedPassword = true;
  bool isPasswordValid = false;

  @override
  void dispose() {
    emailController.dispose();
    loginController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Регистрация', style: AppFonts.s16w500),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const SizedBox(height: 40),
            _buildMainText(),
            const SizedBox(height: 40),
            _buildEmailTextField(),
            const SizedBox(height: 14),
            _buildLoginTextField(),
            const SizedBox(height: 14),
            _buildPasswordField(),
            const SizedBox(height: 6),
            _buildValidationRule(),
            const SizedBox(height: 14),
            _buildRepeatPasswordField(),
            //  const SizedBox(height: 24),
            _buildButton(),
          ]),
        ),
      ),
    );
  }

  Widget _buildMainText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 34),
      child: Text(
        'Создать аккаунт\nLorby',
        style: AppFonts.s24w500,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return CustomTextField(
      controller: emailController,
      text: 'Введи адрес почты',
      error: emailError,
      onChanged: (value) {
        if (value.contains('@') && value.contains('.')) {
          setState(() {
            emailError = null;
          });
        } else {
          setState(() {
            emailError = 'Неверный формат email';
          });
        }
        context.read<ValidationBloc>().add(EmailEvent(emailError: emailError));
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildLoginTextField() {
    return CustomTextField(
        controller: loginController,
        text: 'Придумай логин',
        error: loginError,
        onChanged: (value) {
          if (RegExp('^[a-zA-Z]+\$').hasMatch(value)) {
            setState(() {});
            loginError = null;
          } else if (value == '') {
            setState(() {
              loginError = 'Обязательно поле!';
            });
          } else {
            setState(() {
              loginError = 'Недопустимые символы';
            });
          }
          context
              .read<ValidationBloc>()
              .add(LoginEvent(loginError: loginError));
        });
  }

  Widget _buildButton() {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Далее',
            onTap: state.validationModel.isAllFieldsValid
                ? () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                : null,
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: passwordController,
      text: 'Создай пароль',
      onChanged: (value) {
        BlocProvider.of<ValidationBloc>(context)
            .add(PasswordEvent(password: value));
      },
      isObcsure: isObcsure,
      suffixIcon: _buildSuffixIcon(),
    );
  }

  IconButton _buildSuffixIcon() {
    return IconButton(
      icon: Icon(
        !isObcsure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
        color: AppColors.darkGrey,
      ),
      onPressed: () {
        setState(() {
          isObcsure = !isObcsure;
        });
      },
    );
  }

  Widget _buildValidationRule() {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        final rules = [
          state.validationModel.hasLenght,
          state.validationModel.hasUpperLetters,
          state.validationModel.hasDigit,
          state.validationModel.hasSpecialSymb,
        ];
        return _buildValidationItems(rules);
      },
    );
  }

  Column _buildValidationItems(List<bool?> rules) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(AppText.validationRule.length, (index) {
        return Row(
          children: [
            Icon(
              Icons.circle,
              size: 3,
              color: _createItemColor(rules[index]),
            ),
            const SizedBox(width: 7),
            Text(
              _createItemsText(index, rules[index]),
              style: AppFonts.s12w500.copyWith(
                color: _createItemColor(rules[index]),
              ),
            ),
          ],
        );
      }),
    );
  }

  Color _createItemColor(bool? isTrue) {
    return isTrue != null ? Colors.green : AppColors.darkGrey;
  }

  String _createItemsText(int index, bool? isTrue) =>
      '${AppText.validationRule[index]}${isTrue != null ? ' ✅' : ''}';

  Widget _buildRepeatPasswordField() {
    return CustomTextField(
      controller: repeatedPasswordController,
      text: 'Повтори пароль',
      isObcsure: true,
      suffixIcon: _buildSuffixIcon(),
      onChanged: (value) {
        if (value != passwordController.text) {
          setState(() {
            repeatedPasswordError = 'Пароли не совпадают!';
          });
        } else {
          setState(() {
            repeatedPasswordError = null;
          });
        }
        BlocProvider.of<ValidationBloc>(context)
            .add(RePasswordEvent(repeatedPasswordError: repeatedPasswordError));
      },
      error: repeatedPasswordError,
    );
  }
}
