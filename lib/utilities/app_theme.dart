import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class AppTheme {
  static const TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.w800,
    color: kPrimaryVariantColor,
    fontSize: 28,
  );
  static const TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 18,
  );
  static const TextStyle paragraph = TextStyle(
    fontSize: 15,
    color: kPrimaryColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle paragraphBlack = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textMuted = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: kInfoDarkColor,
  );
  static const TextStyle kLabelStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}
