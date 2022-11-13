import 'package:flutter/material.dart';

@immutable
class Badge {
  final String label;
  final IconData icon;
  final List<String> subtitleSuggestions;

  const Badge(this.label, this.icon, this.subtitleSuggestions);
}
