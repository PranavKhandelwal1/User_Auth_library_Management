import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_management/constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        floatingLabelStyle: TextStyle(color: AppColors.primary),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
