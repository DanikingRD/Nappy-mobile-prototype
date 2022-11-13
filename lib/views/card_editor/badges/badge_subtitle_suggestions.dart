import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';

class BadgeSubtitleSuggestions extends StatelessWidget {
  final List<String> suggestions;
  final Function(String suggestion) onSuggestionClicked;
  final Color themeColor;
  const BadgeSubtitleSuggestions({
    super.key,
    required this.suggestions,
    required this.onSuggestionClicked,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            'Suggestions for your label: ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Wrap(
            spacing: 10.0,
            children: [
              ...suggestions.map((String suggestion) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(width: 2.0, color: themeColor.withOpacity(0.4)),
                  ),
                  onPressed: () => onSuggestionClicked(suggestion),
                  child: Text(
                    suggestion,
                    style: AppTheme.paragraph.copyWith(color: themeColor),
                  ),
                );
              }).toList()
            ],
          ),
        )
      ],
    );
  }
}
