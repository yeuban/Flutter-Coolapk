import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlText extends StatelessWidget {
  final String html;
  final TextStyle textStyle;
  const HtmlText({Key key, this.html, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      defaultTextStyle: textStyle ?? TextStyle(),
      linkStyle: TextStyle(
        decoration: TextDecoration.none,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
