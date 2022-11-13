// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CardEditorTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(String?)? onChanged;
  final TextAlign textAlign;
  final FloatingLabelAlignment? floatingLabelAlign;
  final bool centeredLabel;
  final Color themeColor;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? action;
  final Function(String)? onSubmit;
  final Widget? prefixIcon;
  const CardEditorTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.floatingLabelAlign,
    this.centeredLabel = false,
    required this.themeColor,
    this.autofocus = false,
    this.keyboardType,
    this.action,
    this.onSubmit,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      onChanged: onChanged,
      textAlign: textAlign,
      controller: controller,
      cursorColor: themeColor,
      keyboardType: keyboardType,
      textInputAction: action,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: false,
        border: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeColor, width: 2.0),
        ),
        floatingLabelStyle: TextStyle(color: themeColor),
        alignLabelWithHint: true,
        label: centeredLabel
            ? Center(
                child: Text(labelText),
              )
            : Text(labelText),
        floatingLabelAlignment: floatingLabelAlign,
      ),
    );
  }
}
