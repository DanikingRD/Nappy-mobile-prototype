import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utils.dart';

class ImagePickDialog extends StatelessWidget {
  final VoidCallback pickHandler;
  final VoidCallback removeHandler;
  final bool imageExits;
  const ImagePickDialog({
    super.key,
    required this.pickHandler,
    required this.removeHandler,
    required this.imageExits,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Card Background",
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: kCardBorderRadius),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: pickHandler,
            child: const Text("SELECT IMAGE FROM DEVICE"),
          ),
          vSpace(20),
          if (imageExits)
            TextButton(
              onPressed: removeHandler,
              child: const Text("REMOVE IMAGE"),
            )
        ],
      ),
    );
  }
}
