import 'package:auth_lorby/core/constants/app_colors.dart';
import 'package:auth_lorby/core/constants/app_fonts.dart';
import 'package:auth_lorby/core/constants/app_text.dart';
import 'package:auth_lorby/features/registration/presentation/bloc/password_validation/password_validation_bloc.dart';
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
            const SizedBox(height: 24),
            _buildButtonFurther(),
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
      onChanged: (value) {
        if (value.contains('@') && value.contains('.')) {
          emailError = null;
        } else {
          emailError = 'Неверный формат email';
        }
        isValidationEdit();
      },
      error: emailError,
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
            loginError = null;
          } else {
            loginError = 'Недопустимые символы';
          }
          isValidationEdit();
        });
  }

  Widget _buildButtonFurther() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Далее',
        onTap: isValidation ? () {} : null,
      ),
    );
  }

  void isValidationEdit() {
    setState(() {
      isValidation = emailError == null &&
          loginError == null &&
          passwordController.text.isNotEmpty &&
          isPasswordValid &&
          repeatedPasswordError == null;
    });
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: passwordController,
      text: 'Создай пароль',
      onChanged: (value) {
        BlocProvider.of<PasswordValidation>(context)
            .add(CheckValidationPassword(password: value));
        isValidationEdit();
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
    return BlocBuilder<PasswordValidation, PasswordState>(
      builder: (context, state) {
        if (state is PasswordValidationState || state is Initial) {
          final rules =
              state is PasswordValidationState ? state.validRules : null;
          Future.delayed(Duration.zero, () {
            if (rules != null) {
              setState(() {
                isPasswordValid = rules.every((element) => element == true);
              });
            }
            isValidationEdit();
          });
          return _buildValidationItems(rules);
        }
        return const SizedBox();
      },
    );
  }

  Column _buildValidationItems(List<bool>? rules) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(AppText.validationRule.length, (index) {
        return Row(
          children: [
            Icon(
              Icons.circle,
              size: 3,
              color: _createItemColor(rules, index),
            ),
            const SizedBox(width: 7),
            Text(
              _createItemsText(index, rules),
              style: AppFonts.s12w500.copyWith(
                color: _createItemColor(rules, index),
              ),
            ),
          ],
        );
      }),
    );
  }

  Color _createItemColor(List<bool>? rules, int index) {
    return rules is List<bool>
        ? (rules[index] ? Colors.green : AppColors.red)
        : AppColors.darkGrey;
  }

  String _createItemsText(int index, List<bool>? rules) =>
      '${AppText.validationRule[index]}${rules is List<bool> ? (rules[index] ? ' ✅' : '❌') : ''}';

  Widget _buildRepeatPasswordField() {
    return CustomTextField(
      controller: repeatedPasswordController,
      text: 'Повтори пароль',
      isObcsure: true,
      suffixIcon: _buildSuffixIcon(),
      onChanged: (value) {
        if (value != passwordController.text) {
          repeatedPasswordError = 'Пароли не совпадают!';
        } else {
          repeatedPasswordError = null;
        }
      },
      error: repeatedPasswordError,
    );
  }
}
