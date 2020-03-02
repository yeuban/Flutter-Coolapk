import 'package:coolapk_flutter/util/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class HtmlText extends StatelessWidget {
  final String html;
  final TextStyle defaultTextStyle;
  final bool shrinkToFit;
  const HtmlText({Key key, this.html, this.defaultTextStyle, this.shrinkToFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      useRichText: false,
      data: parseEmoji(html),
      showImages: true,
      shrinkToFit: shrinkToFit,
      linkStyle: TextStyle(color: Theme.of(context).accentColor),
      defaultTextStyle: defaultTextStyle ?? const TextStyle(fontSize: 15),
      customRender: (node, child) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "emoji":
              final img = node.attributes["path"];
              try {
                return Image.asset(
                  img,
                  width: 22,
                  height: 22,
                  cacheWidth: 22,
                  cacheHeight: 22,
                  filterQuality: FilterQuality.medium,
                );
              } catch (err) {}
              break;
          }
        }
        return null;
      },
    );
  }
}
