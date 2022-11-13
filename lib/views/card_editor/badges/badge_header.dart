import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_grid.dart';

class BadgeHeader extends StatelessWidget {
  final Badge badge;
  final Color themeColor;
  final String title;
  final String subtitle;
  final String? titleSuffixLabel;
  const BadgeHeader({
    super.key,
    required this.badge,
    required this.themeColor,
    required this.title,
    required this.subtitle,
    this.titleSuffixLabel,
  });

  String getTitle() {
    if (titleSuffixLabel == null) {
      return title;
    } else {
      return '$title${titleSuffixLabel!}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 6.0,
          color: themeColor.withOpacity(0.5),
        ),
        ListTile(
          title: Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: AppTheme.paragraphBlack.copyWith(fontSize: 16),
                    ),
                    if (titleSuffixLabel != null) ...{
                      TextSpan(
                        text: titleSuffixLabel,
                        style: AppTheme.textMuted.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
          leading: AbsorbPointer(
            child: FloatingBadgeButton(
              onClick: () {},
              elevation: 1.0,
              badge: badge,
              backgroundColor: themeColor,
            ),
          ),
          subtitle: subtitle.isEmpty ? null : Text(subtitle),
        ),
        Divider(
          thickness: 6.0,
          color: themeColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
