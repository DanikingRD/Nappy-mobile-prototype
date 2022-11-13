import 'package:flutter/material.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class CardPageIndicator extends StatelessWidget {
  final bool active;
  const CardPageIndicator({
    Key? key,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: active ? 32.0 : 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.grey,
        borderRadius: kCardBorderRadius,
      ),
    );
  }
}
