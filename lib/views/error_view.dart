import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';
import 'package:nappy_mobile/utils.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            errorMessage,
            style: AppTheme.headline1,
          ),
        ),
      ),
    );
  }
}
