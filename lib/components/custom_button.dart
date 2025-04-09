import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final ButtonStyle? style;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 50.0,
    this.backgroundColor = Colors.teal,
    this.textColor = Colors.white,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child:
            isLoading
                ? CircularProgressIndicator(color: Colors.white,backgroundColor: AppColors.primary,strokeWidth: 3,)
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double width;
  final double height;
  final Color textColor;
  final ButtonStyle? style;

  //for google sign-up
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width = double.infinity,
    this.height = 50.0,
    this.textColor = Colors.black87,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:
          icon != null
              ? OutlinedButton.icon(
                icon: icon!,
                label: Text(text, style: TextStyle(color: textColor)),
                onPressed: onPressed,
                style: style,
              )
              : OutlinedButton(
                onPressed: onPressed,
                style: style,
                child: Text(text, style: TextStyle(color: textColor)),
              ),
    );
  }
}
