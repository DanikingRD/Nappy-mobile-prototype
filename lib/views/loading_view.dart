import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nappy_mobile/utilities/constants.dart';

class LoadingView extends StatelessWidget {
  final Color? color;
  const LoadingView({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: color ?? kPrimaryVariantColor,
          lineWidth: 4,
          size: 120,
        ),
      ),
    );
  }
}
