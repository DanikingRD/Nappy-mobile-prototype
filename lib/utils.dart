import 'package:flutter/material.dart';

SizedBox vSpace(double vSpace) {
  return SizedBox(
    height: vSpace,
  );
}

SizedBox hSpace(double hSpace) {
  return SizedBox(
    width: hSpace,
  );
}

void showSnackBar(BuildContext context, String text) {
  return showSnackBarFrom(ScaffoldMessenger.of(context), text);
}

void showSnackBarFrom(ScaffoldMessengerState context, String text) {
  context
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(text)),
    );
}
