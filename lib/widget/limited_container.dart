import 'package:flutter/material.dart';

enum LimiteType {
  SingleColumn,
  TwoColumn,
}

class LimitedContainer extends StatelessWidget {
  final Widget child;

  // final double maxWidth;
  final LimiteType limiteType;
  final BoxDecoration boxDecoration;

  const LimitedContainer(
      {Key key,
      this.child,
      this.limiteType = LimiteType.SingleColumn,
      this.boxDecoration})
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
      child: Container(
        width: double.infinity,
        decoration: boxDecoration,
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
