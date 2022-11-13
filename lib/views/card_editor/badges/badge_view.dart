import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_header.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_subtitle_suggestions.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_editor_text_field.dart';

class BadgeView extends StatefulWidget {
  final Badge badge;
  final Color themeColor;
  const BadgeView({
    super.key,
    required this.badge,
    required this.themeColor,
  });

  @override
  State<BadgeView> createState() => _BadgeViewState();
}

class _BadgeViewState extends State<BadgeView> {
  late final CardEditorField titleField;
  late final CardEditorField subtitleField;

  @override
  void initState() {
    super.initState();
    titleField = CardEditorField(widget.badge.label);
    subtitleField = CardEditorField("Label (Optional)");
  }

  @override
  void dispose() {
    super.dispose();
    titleField.controller.dispose();
    subtitleField.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeColor,
        title: Text("Insert ${widget.badge.label}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text("SAVE"),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BadgeHeader(
            badge: widget.badge,
            themeColor: widget.themeColor,
            title: titleField.text,
            subtitle: subtitleField.text,
          ),
          vSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CardEditorTextField(
              autofocus: true,
              action: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              themeColor: widget.themeColor,
              onChanged: (_) => setState(() {}),
              controller: titleField.controller,
              labelText: titleField.title,
            ),
          ),
          vSpace(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CardEditorTextField(
              themeColor: widget.themeColor,
              onChanged: (_) => setState(() {}),
              controller: subtitleField.controller,
              labelText: subtitleField.title,
              action: TextInputAction.done,
              onSubmit: ((String subtitle) {}),
            ),
          ),
          if (widget.badge.subtitleSuggestions.isNotEmpty) ...{
            BadgeSubtitleSuggestions(
              suggestions: widget.badge.subtitleSuggestions,
              onSuggestionClicked: (suggestion) {
                setState(() {
                  subtitleField.setText(suggestion);
                });
              },
              themeColor: widget.themeColor,
            )
          },
        ],
      ),
    );
  }
}
