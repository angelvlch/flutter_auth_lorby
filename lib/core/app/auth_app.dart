import 'package:auth_lorby/core/route/routes.dart';
import 'package:auth_lorby/features/registration/presentation/bloc/password_validation/password_validation_bloc.dart';
import 'package:auth_lorby/features/registration/presentation/view/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  Map<String, WidgetBuilder> get _routes {
    return {
      //  Routes.authPage: (context) =>
      Routes.registrationPage: (context) => const RegistrationPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordValidation>(
      create: (context) => PasswordValidation(),
      child: MaterialApp(
        routes: _routes,
      ),
    );
  }
}
