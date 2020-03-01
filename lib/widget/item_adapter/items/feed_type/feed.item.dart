import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed_footer.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed_header.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed_type_11_content.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

/// 最难搞的东西
/// source["type"] 有很多
///   0: 普通动态
///   9: 评论 某应用的
///   11: 回答
///   12: 图文
///   13: 视频
class FeedItem extends StatelessWidget {
  final dynamic source;
  const FeedItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (source["type"].toString()) {
      case "11":
        content = FeedType11Content(source);
        break;
      default:
        content = Text("不支持的content type " + source["type"].toString());
    }
    return MCard(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(16).copyWith(top: 8, bottom: 8),
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FeedItemHeader(
            userName: source["username"],
            headImgUrl: source["userAvatar"],
            subTitle1: source["infoHtml"].toString(),
            phoneName: source["device_title"],
            source: source,
          ),
          content,
          FeedItemFooter(source),
        ],
      ),
    );
  }
}

Widget buildImageBox2x2(List<String> picArr) {
  picArr.removeRange(4, picArr.length);
  return GridView.extent(
    maxCrossAxisExtent: 2,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    shrinkWrap: true,
    childAspectRatio: 1,
    children: picArr.map((pic) {
      return ExtendedImage.network(
        pic,
        cache: false, // TODO:
        fit: BoxFit.cover,
      );
    }).toList(),
  );
}

Widget buildImageBox1x2(List<String> picArr) {
  picArr.removeRange(2, picArr.length);
  return GridView.extent(
    maxCrossAxisExtent: 2,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    shrinkWrap: true,
    childAspectRatio: 2,
    children: picArr.map((pic) {
      return ExtendedImage.network(
        pic,
        cache: false, // TODO:
        fit: BoxFit.cover,
      );
    }).toList(),
  );
}

Widget buildImageBox1x3(List<String> picArr) {
  picArr.removeRange(3, picArr.length);
  return GridView.extent(
    maxCrossAxisExtent: 3,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    shrinkWrap: true,
    childAspectRatio: 3,
    children: picArr.map((pic) {
      return ExtendedImage.network(
        pic,
        cache: false, // TODO:
        fit: BoxFit.cover,
      );
    }).toList(),
  );
}
