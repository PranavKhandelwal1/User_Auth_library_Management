import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color dividerColor;

  const DividerWithText({
    super.key,
    required this.text,
    this.textColor = Colors.red,
    this.dividerColor = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text, style: TextStyle(color: textColor)),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}