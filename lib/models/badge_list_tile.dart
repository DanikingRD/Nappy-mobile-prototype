import 'package:flutter/material.dart';

@immutable
class BadgeListTileModel {
  final String title;
  final String subtitle;
  final IconData icon;

  const BadgeListTileModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
