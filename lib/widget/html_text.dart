import 'package:coolapk_flutter/page/detail/feed_detail.page.dart';
import 'package:coolapk_flutter/util/emoji.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class HtmlText extends StatelessWidget {
  final String html;
  final TextStyle defaultTextStyle;
  final bool shrinkToFit;
  final bool renderNewlines;
  final TextStyle linkStyle;
  final Function(String url) onLinkTap;
  const HtmlText({
    Key key,
    this.html,
    this.defaultTextStyle,
    this.shrinkToFit,
    this.linkStyle,
    this.onLinkTap,
    this.renderNewlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      useRichText: false,
      data: parseEmoji(html),
      showImages: true,
      onLinkTap: onLinkTap ??
          (link) {
            handleOnLinkTap(link, context);
          },
      renderNewlines: renderNewlines ?? true,
      shrinkToFit: shrinkToFit,
      linkStyle: linkStyle ?? TextStyle(color: Theme.of(context).accentColor),
      defaultTextStyle: defaultTextStyle ?? const TextStyle(fontSize: 15),
      customRender: (node, child) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "emoji":
              final img = node.attributes["path"];
              try {
                return ExtendedImage.asset(
                  img,
                  width: 22,
                  height: 22,
                  filterQuality: FilterQuality.medium,
                );
              } catch (err) {}
              break;
          }
          if (node.text == "查看更多") {
            node.text = "";
          }
        }
        return null;
      },
    );
  }
}
