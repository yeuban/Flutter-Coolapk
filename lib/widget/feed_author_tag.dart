import 'package:flutter/material.dart';

class FeedAuthorTag extends StatelessWidget {
  const FeedAuthorTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor.withAlpha(200),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "楼主",
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: Theme.of(context).textTheme.caption.fontSize,
        ),
      ),
    );
  }
}
