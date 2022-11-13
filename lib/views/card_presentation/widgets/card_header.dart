import 'package:flutter/material.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_background.dart';

class CardHeaderPresentation extends StatelessWidget {

  final ImageProvider<Object> backgroundImage;
  final ImageProvider<Object> avatarImage;
  const CardHeaderPresentation({
    super.key,
    required this.backgroundImage,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children:  [
        ProfileBackground(
          image: backgroundImage,
        ),
        Positioned(
          bottom: -20,
          child: CircleAvatar(
            radius: 64,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: avatarImage
            ),
          ),
        ),
      ],
    );
  }
}
