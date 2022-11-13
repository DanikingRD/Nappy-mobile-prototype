import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:nappy_mobile/models/badge_list_tile.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';

@immutable
class CardEditor {
  final File? backgroundImage;
  final File? avatarImage;
  final CardEditorField cardTitleField;
  final List<CardEditorField> fields;
  final List<BadgeListTileModel> badgeModels;
  final Color activeColor;
  const CardEditor({
    this.backgroundImage,
    this.avatarImage,
    required this.cardTitleField,
    required this.fields,
    required this.badgeModels,
    required this.activeColor,
  });

  CardEditor copyWith({
    File? backgroundImage,
    File? avatarImage,
    CardEditorField? cardTitleField,
    List<CardEditorField>? fields,
    List<BadgeListTileModel>? badgeModels,
    Color? activeColor,
  }) {
    return CardEditor(
      backgroundImage: backgroundImage ?? this.backgroundImage,
      avatarImage: avatarImage ?? this.avatarImage,
      cardTitleField: cardTitleField ?? this.cardTitleField,
      fields: fields ?? this.fields,
      badgeModels: badgeModels ?? this.badgeModels,
      activeColor: activeColor ?? this.activeColor,
    );
  }

  @override
  String toString() {
    return 'CardEditor(backgroundImage: $backgroundImage, avatarImage: $avatarImage, cardTitleField: $cardTitleField, fields: $fields, badgeModels: $badgeModels, activeColor: $activeColor)';
  }

  @override
  bool operator ==(covariant CardEditor other) {
    if (identical(this, other)) return true;

    return other.backgroundImage == backgroundImage &&
        other.avatarImage == avatarImage &&
        other.cardTitleField == cardTitleField &&
        listEquals(other.fields, fields) &&
        listEquals(other.badgeModels, badgeModels) &&
        other.activeColor == activeColor;
  }

  @override
  int get hashCode {
    return backgroundImage.hashCode ^ avatarImage.hashCode ^ cardTitleField.hashCode ^ fields.hashCode ^ badgeModels.hashCode ^ activeColor.hashCode;
  }
}
