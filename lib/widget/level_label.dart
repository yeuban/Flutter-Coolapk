import 'package:flutter/material.dart';

/// 等有时间按等级分颜色
/// pandecheng的颜色表图不太对...
class LevelLabel extends StatelessWidget {
  final dynamic level;
  const LevelLabel(this.level, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        shape: BoxShape.rectangle,
      ),
      child: Text(
        "Lv.${level.toString()}",
        style: TextStyle(
          color: Theme.of(context).primaryTextTheme.bodyText1.color,
          fontSize: 10,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
