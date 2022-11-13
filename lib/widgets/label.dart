import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';

class Label extends StatelessWidget {
  final String text;
  final Color? textColor;
  const Label(this.text, {this.textColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: AppTheme.kLabelStyle.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
