import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color dividerColor;

  const DividerWithText({
    super.key,
    required this.text,
    this.textColor = Colors.black54,
    this.dividerColor = Colors.black12,
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