import 'package:auth_lorby/core/constants/app_colors.dart';
import 'package:auth_lorby/core/constants/app_fonts.dart';
import 'package:auth_lorby/core/constants/app_images.dart';
import 'package:auth_lorby/core/constants/app_text.dart';
import 'package:auth_lorby/core/routes/routes.dart';
import 'package:auth_lorby/features/authorization/presentation/bloc/authorization_bloc.dart';
import 'package:auth_lorby/features/widgets/custom_button.dart';
import 'package:auth_lorby/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage();

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObcsure = true;
  bool isLogIn = true;
  @override
  void initState() {
    super.initState();
    //  FlutterNativeSplash.remove();
    /*  Future.delayed(const Duration(seconds: 11)).then(
      (value) => FlutterNativeSplash.remove(),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                SvgPicture.asset(AppImages.login),
                const SizedBox(height: 32),
                const Text(AppText.login, style: AppFonts.s24w500),
                const SizedBox(height: 28),
                CustomTextField(
                  controller: loginController,
                  text: 'Введи туда-сюда логин',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: passwordController,
                  text: 'Пароль (тоже введи)',
                  onChanged: (value) {},
                  isObcsure: isObcsure,
                  suffixIcon: _buildSuffixIcon(),
                ),
                const SizedBox(height: 24),
                _listenErrorMessage(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.registrationPage),
                    child: const Text(AppText.account, style: AppFonts.s16w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  void _showErrorMessage() {
    final snackBar = SnackBar(
      content: Text(
        AppText.error,
        style: AppFonts.s16w500.copyWith(color: AppColors.red),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.sizeOf(context).height * 0.9,
        left: 10,
        right: 10,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  void _onTap() {
    BlocProvider.of<AuthorizationBloc>(context).add(
      AuthorizationSubmit(
        email: loginController.text,
        password: passwordController.text,
      ),
    );
  }

  Widget _listenErrorMessage() {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationDone) {
        }
        // дописать переход на главную страницу
        else {
          _showErrorMessage();
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: 'Войти',
          onTap: _onTap,
        ),
      ),
    );
  }
}
