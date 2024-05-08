import 'package:auth_lorby/core/route/routes.dart';
import 'package:auth_lorby/features/authorization/presentation/view/authorization.dart';
import 'package:auth_lorby/features/registration/presentation/bloc/password_validation/validation_bloc.dart';
import 'package:auth_lorby/features/registration/presentation/view/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  Map<String, WidgetBuilder> get _routes {
    return {
      Routes.authPage: (context) => const AuthorizationPage(),
      Routes.registrationPage: (context) => const RegistrationPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ValidationBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // Измените цвет текста кнопки
              backgroundColor: Colors.red, // Измените цвет фона кнопки
            ),
          ),
        ),
        routes: _routes,
      ),
    );
  }
}
