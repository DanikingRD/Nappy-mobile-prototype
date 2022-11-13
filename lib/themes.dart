import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nappy_mobile/utilities/constants.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme(),
  primaryColor: kPrimaryColor,
  errorColor: kDangerColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white.withOpacity(0.5),
    elevation: 0.0,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kPrimaryColor,
    selectionColor: kPrimaryColor,
    selectionHandleColor: kPrimaryVariantColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: kPrimaryFillColor,
    isDense: true,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: kPrimaryColor,
        width: 3.0,
      ),
    ),
  ),
  iconTheme: const IconThemeData(color: kPrimaryVariantColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      minimumSize: const Size(double.infinity, 40),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme(),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA5C8FF),
  onPrimary: Color(0xFF00315E),
  primaryContainer: Color(0xFF004785),
  onPrimaryContainer: Color(0xFFD4E3FF),
  secondary: Color(0xFF5BD5FA),
  onSecondary: Color(0xFF003543),
  secondaryContainer: Color(0xFF004E60),
  onSecondaryContainer: Color(0xFFB5EBFF),
  tertiary: Color(0xFF4FD8EC),
  onTertiary: Color(0xFF00363D),
  tertiaryContainer: Color(0xFF004F58),
  onTertiaryContainer: Color(0xFF99F0FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F24),
  onBackground: Color(0xFF97F0FF),
  surface: Color(0xFF001F24),
  onSurface: Color(0xFF97F0FF),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF001F24),
  inverseSurface: Color(0xFF97F0FF),
  inversePrimary: Color(0xFF005FAE),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA5C8FF),
);
