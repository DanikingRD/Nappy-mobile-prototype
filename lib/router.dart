import 'package:flutter/material.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';
import 'package:nappy_mobile/views/home/home_view.dart';
import 'package:nappy_mobile/views/login_view.dart';
import 'package:nappy_mobile/views/registration_view.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
    case LoginView.id:
      return MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
    case RegistrationView.id:
      return MaterialPageRoute(
        builder: (context) => const RegistrationView(),
      );
    case HomeView.id:
      return MaterialPageRoute(
        builder: (_) => const HomeView(),
      );
    case CardEditorView.id:
      final CardOp op = settings.arguments as CardOp;
      return MaterialPageRoute(
        builder: (_) => CardEditorView(
          op: op,
        ),
      );
    default:
      throw ("Undefined Route ${settings.name}");
  }
}
