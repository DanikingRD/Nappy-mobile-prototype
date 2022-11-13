import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class DeleteCardDialog extends StatelessWidget {
  final VoidCallback deleteClickHandler;
  const DeleteCardDialog({
    super.key,
    required this.deleteClickHandler,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Are you sure you want to delete this card? ",
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: kCardBorderRadius),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("NO"),
        ),
        TextButton(
          onPressed: deleteClickHandler,
          child: const Text("YES"),
        )
      ],
    );
  }
}
