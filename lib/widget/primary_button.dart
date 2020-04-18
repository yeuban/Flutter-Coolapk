import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final String text;
  const PrimaryButton({Key key, this.child, this.onPressed, this.text = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      color: Theme.of(context).accentColor.withAlpha(40),
      textColor: Theme.of(context).accentColor,
      elevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      child: child ?? Text(text),
      onPressed: onPressed,
    );
  }
}
