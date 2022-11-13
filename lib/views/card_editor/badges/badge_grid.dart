// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';

class BadgeGridView extends StatelessWidget {
  final List<Badge> badgeList;
  final Color color;
  final Function(Badge badge) onClick;

  const BadgeGridView({
    Key? key,
    required this.badgeList,
    required this.color,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color.withOpacity(0.6),
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: const EdgeInsets.only(top: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        children: badgeList.map((badge) {
          return Column(
            children: [
              FloatingBadgeButton(
                onClick: () => onClick(badge),
                key: Key(badge.icon.toString()),
                backgroundColor: color,
                badge: badge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  badge.label,
                  style: AppTheme.paragraph.copyWith(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class FloatingBadgeButton extends StatelessWidget {
  final VoidCallback onClick;
  final Badge badge;
  final Color backgroundColor;
  final double elevation;
  const FloatingBadgeButton({
    super.key,
    required this.onClick,
    required this.badge,
    required this.backgroundColor,
    this.elevation = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onClick,
      elevation: elevation,
      heroTag: Key(badge.icon.toString()),
      backgroundColor: backgroundColor,
      child: Icon(
        badge.icon,
        size: 32,
      ),
    );
  }
}
