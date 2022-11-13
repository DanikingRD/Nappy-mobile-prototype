import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/app_theme.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kMobileDefaultPadding,
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Create a card to get started!',
              style: AppTheme.headline3,
            ),
            vSpace(30),
            IntrinsicWidth(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CardEditorView.id, arguments: CardOp.create);
                },
                child: Row(
                  children: const [
                    Text('CREATE CARD'),
                    Icon(
                      Icons.add,
                    )
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
