import 'package:flutter/material.dart';

enum LimiteType {
  SingleColumn,
  TwoColumn,
}

class LimitedContainer extends StatelessWidget {
  final Widget child;
  // final double maxWidth;
  final LimiteType limiteType;
  const LimitedContainer(
      {Key key, this.child, this.limiteType = LimiteType.SingleColumn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = 1280;
    switch (limiteType) {
      case LimiteType.SingleColumn:
        maxWidth = 880;
        break;
      case LimiteType.TwoColumn:
        maxWidth = 1280;
        break;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
