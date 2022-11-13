import 'dart:ui';

import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final TextInputAction? action;
  final Function()? onEditingComplete;
  const PasswordTextField({
    this.prefixIcon,
    this.controller,
    this.action,
    this.onEditingComplete,
    super.key,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextField> {
  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hideText,
      controller: widget.controller,
      textInputAction: widget.action,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        suffixIcon: visibilityToggler(context),
        prefixIcon: widget.prefixIcon,
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget visibilityToggler(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        setState(() {
          hideText = !hideText;
        });
      },
      icon: Icon(
        hideText ? Icons.visibility : Icons.visibility_off,
        color: iconTheme.color,
      ),
    );
  }
}
