import 'package:auth_lorby/core/constants/app_colors.dart';
import 'package:auth_lorby/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Function(String) onChanged;

  final TextInputType? keyboardType;
  final String? error;
  final bool isObcsure;
  final IconButton? suffixIcon;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.onChanged,
    this.error,
    this.keyboardType,
    this.isObcsure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: ,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObcsure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorText: error,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: text,
        hintStyle: AppFonts.s16w500.copyWith(color: AppColors.darkGrey),
      ),
    );
  }
}
