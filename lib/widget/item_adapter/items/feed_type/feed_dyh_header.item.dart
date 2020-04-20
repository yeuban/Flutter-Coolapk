import 'package:coolapk_flutter/page/detail/feed_detail.page.dart';
import 'package:coolapk_flutter/widget/html_text.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed.item.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FeedByDyhDeaderItem extends StatelessWidget {
  final dynamic source;
  final Function(int) requireDelete;
  const FeedByDyhDeaderItem({Key key, this.source, this.requireDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FeedItem(
        source: source,
        requireDelete: requireDelete,
        extHeader: InkWell(
          onTap: () {
            // TODO: handle to dyh page
            Toast.show("施工中", context, duration: 2);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(right: 29),
                child: Row(
                  children: [
                    ExtendedImage.network(
                      source["dyh_info"]["logo"],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      width: 44,
                      height: 44,
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            source["dyh_info"]["title"],
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          HtmlText(
                            onLinkTap: (url) => handleOnLinkTap(url, context),
                            html: source["dyh_info"]["fromInfo"],
                            defaultTextStyle: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color
                                    .withAlpha(155)),
                            shrinkToFit: true,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              Divider(height: 2),
            ],
          ),
        ));
  }
}
