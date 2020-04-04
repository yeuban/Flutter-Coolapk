import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension StringExt on String {
  Text get textWidget => Text(this);

  Text textWidgetPrimary(context) => Text(
        this,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      );
}

extension DoubleExt on double {
  EdgeInsets get edgeInsets => EdgeInsets.all(this);
  EdgeInsets get edgeInsetsLeft => EdgeInsets.only(left: this);
  EdgeInsets get edgeInsetsTop => EdgeInsets.only(top: this);
  EdgeInsets get edgeInsetsRight => EdgeInsets.only(right: this);
  EdgeInsets get edgeInsetsBottom => EdgeInsets.only(bottom: this);
  EdgeInsets get edgeInsetsTB => EdgeInsets.only(bottom: this, top: this);
  EdgeInsets get edgeInsetsLR => EdgeInsets.only(left: this, right: this);

  Divider get spaceWidget => Divider(height: this, color: Colors.transparent);
}

extension IntExt on int {
  EdgeInsets get edgeInsets => EdgeInsets.all(this.toDouble());
  EdgeInsets get edgeInsetsLeft => EdgeInsets.only(left: this.toDouble());
  EdgeInsets get edgeInsetsTop => EdgeInsets.only(top: this.toDouble());
  EdgeInsets get edgeInsetsRight => EdgeInsets.only(right: this.toDouble());
  EdgeInsets get edgeInsetsBottom => EdgeInsets.only(bottom: this.toDouble());
  EdgeInsets get edgeInsetsTB =>
      EdgeInsets.only(bottom: this.toDouble(), top: this.toDouble());
  EdgeInsets get edgeInsetsLR =>
      EdgeInsets.only(left: this.toDouble(), right: this.toDouble());

  Divider get spaceWidget =>
      Divider(height: this.toDouble(), color: Colors.transparent);
}
