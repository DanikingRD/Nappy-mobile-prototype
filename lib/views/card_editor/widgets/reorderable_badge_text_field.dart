import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/models/badge_list_tile.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_grid.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_editor_text_field.dart';

class ReorderableBadgeTextField extends StatelessWidget {
  final BadgeListTileModel badge;
  final Color themeColor;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  const ReorderableBadgeTextField({
    super.key,
    required this.badge,
    required this.themeColor,
    required this.titleController,
    required this.subtitleController,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FloatingBadgeButton(
        onClick: () {},
        badge: Badge(badge.subtitle, badge.icon, const []),
        backgroundColor: themeColor,
      ),
      title: CardEditorTextField(
        controller: titleController,
        labelText: badge.title,
        themeColor: themeColor,
      ),
      subtitle: Column(
        children: [
          CardEditorTextField(
            controller: subtitleController,
            labelText: badge.subtitle,
            themeColor: themeColor,
          ),
        ],
      ),
    );
  }
}
