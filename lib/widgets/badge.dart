import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class BadgeButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  const BadgeButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // override default
      iconColor: Colors.white,
      leading: FloatingActionButton(
        heroTag: Text(title),
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
