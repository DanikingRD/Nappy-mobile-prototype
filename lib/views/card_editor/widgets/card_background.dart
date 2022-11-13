import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class ProfileBackground extends StatelessWidget {
  final VoidCallback? onTap;
  final ImageProvider<Object> image;

  const ProfileBackground({
    super.key,
    this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: kCardBorderRadius,
      child: ClipRRect(
        borderRadius: kCardBorderRadius,
        child: Ink(
          width: 400,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: kCardBorderRadius,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: image,
            ),
          ),
          child: InkWell(
            borderRadius: kCardBorderRadius,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
