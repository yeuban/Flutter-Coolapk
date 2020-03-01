import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlText extends StatelessWidget {
  final String html;
  final TextStyle defaultTextStyle;
  final bool shrinkToFit;
  const HtmlText({Key key, this.html, this.defaultTextStyle, this.shrinkToFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      defaultTextStyle: defaultTextStyle,
      linkStyle: TextStyle(
        decoration: TextDecoration.none,
        color: Theme.of(context).primaryColor,
      ),
      shrinkToFit: shrinkToFit,
    );
  }
}
