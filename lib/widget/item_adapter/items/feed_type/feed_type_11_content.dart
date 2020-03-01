import 'package:coolapk_flutter/util/html_text.dart';
import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed.item.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FeedType11Content extends StatelessWidget {
  final dynamic source;
  const FeedType11Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // source["feedType"] == answer
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildQuestionRow(context),
          _buildAnswerContent(),
          _buildIfImageBox(context),
        ],
      ),
    );
  }

  Widget _buildIfImageBox(final BuildContext context) {
    final List<dynamic> picArr = source["picArr"];
    final maxHeight = MediaQuery.of(context).size.height / 3;
    Widget picWidget;
    if (picArr != null) {
      switch (picArr.length) {
        case 4:
          picWidget = buildImageBox2x2(picArr);
          break;
        case 2:
          picWidget = buildImageBox1x2(picArr);
          break;
        case 3:
          picWidget = buildImageBox1x3(picArr);
          break;
        case 1:
          if (picArr[0] == "") break;
          final fmh = maxHeight < 240 ? 240 : maxHeight > 400 ? 400 : maxHeight;
          picWidget = ConstrainedBox(
            constraints: BoxConstraints(maxHeight: fmh.toDouble()),
            child: ExtendedImage.network(
              picArr[0],
              cache: false, // TODO:
              fit: BoxFit.cover,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
          );
          break;
        default:
          if (picArr.length > 4) {
            picWidget = buildImageBox2x2(picArr);
          }
      }
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: picWidget ?? const SizedBox(),
    );
  }

  Widget _buildAnswerContent() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: HtmlText(
        html: source["message"],
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        shrinkToFit: true,
      ),
    );
  }

  Widget _buildQuestionRow(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              source["feedTypeName"],
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              source["message_title"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
