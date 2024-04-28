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
  String? emailError = '';
  String? loginError = '';
  bool isValidation = false;
  bool isObcsure = true;
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
            //  _buildRepeatPasswordField(),
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
        if (emailController.text.contains('@') &&
            emailController.text.contains('.')) {
          setState(() {
            emailError = null;
          });
        } else if (emailController.text.isEmpty) {
          setState(() {
            emailError = 'Обязательное поле';
          });
        } else {
          setState(() {
            emailError = 'Неверный формат email';
          });
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
          if (RegExp('[a-zA-Z]').hasMatch(loginController.text)) {
            setState(() {
              loginError = null;
            });
          } else if (loginController.text.isEmpty) {
            setState(() {
              loginError = 'Обязательное поле';
            });
          } else {
            setState(() {
              loginError = 'Недопустимые символы';
            });
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
          passwordController.text.isNotEmpty;
    });
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: passwordController,
      text: 'Создай пароль',
      onChanged: (value) {
        BlocProvider.of<PasswordValidation>(context)
            .add(CheckValidationPassword(password: passwordController.text));
        isValidationEdit();
      },
      isObcsure: isObcsure,
      suffixIcon: IconButton(
        icon: Icon(
          !isObcsure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
          color: AppColors.darkGrey,
        ),
        onPressed: () {
          setState(() {
            isObcsure = !isObcsure;
          });
        },
      ),
    );
  }

  Widget _buildValidationRule() {
    return BlocBuilder<PasswordValidation, PasswordState>(
      builder: (context, state) {
        if (state is PasswordValidationState) {
          final rules = state.validRules;
          /*   setState(() {
            isPasswordValid = rules.every((element) => element == true);
          }); */
          //  isValidationEdit();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(AppText.validationRule.length, (index) {
              return Row(
                children: [
                  Icon(Icons.circle,
                      size: 3,
                      color: rules[index] ? Colors.green : AppColors.darkGrey),
                  const SizedBox(width: 7),
                  Text(
                      '${AppText.validationRule[index]}${rules[index] ? ' ✅' : ''}',
                      style: AppFonts.s12w500.copyWith(
                          color: rules[index]
                              ? Colors.green
                              : AppColors.darkGrey)),
                ],
              );
            }),
          );
        }
        return Column(
          children: List.generate(AppText.validationRule.length, (index) {
            return Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 3,
                  color: AppColors.darkGrey,
                ),
                const SizedBox(width: 7),
                Text(AppText.validationRule[index],
                    style:
                        AppFonts.s12w500.copyWith(color: AppColors.darkGrey)),
              ],
            );
          }),
        );
      },
    );
  }

/* 
  _buildLoginTextField() {}

  _buildValidationRule() {}

  _buildPasswordField() {}

  _buildRepeatPasswordField() {}

  _buildButtonFurther() {} */
}
