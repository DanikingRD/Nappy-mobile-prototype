import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class EditAvatarIcon extends StatelessWidget {
  const EditAvatarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: kPrimaryFillColor,
          ),
          color: kPrimaryColor,
        ),
        child: Icon(
          Icons.edit_outlined,
          color: theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
