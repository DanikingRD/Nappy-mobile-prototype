import 'package:flutter/material.dart';
import 'package:nappy_mobile/utils.dart';

class CardEditorLabel extends StatelessWidget {
  final String label;
  final IconData? suffixIcon;
  const CardEditorLabel({
    Key? key,
    required this.label,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Card(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (suffixIcon != null) ...{
                  hSpace(20),
                  Icon(
                    suffixIcon,
                    color: Colors.black,
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
