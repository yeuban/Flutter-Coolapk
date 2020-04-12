import 'dart:convert';

import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/feed_type/feed.item.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:coolapk_flutter/widget/primary_button.dart';
import 'package:flutter/material.dart';

class AutoItemAdapter extends StatelessWidget {
  final entity;
  final sliverMode;
  final Function(dynamic entity) onRequireDeleteItem;
  const AutoItemAdapter(
      {Key key, this.entity, this.sliverMode = true, this.onRequireDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final template = entity["entityTemplate"];
    final type = entity["entityType"];

    Widget item;

    switch (type) {
      case "card":
        switch (template) {
          case "sortSelectCard":
            item = const SizedBox(); // TODO:
            break;
          case "productConfigList":
            item = const SizedBox();
            break;
          case "configCard":
            item = const SizedBox();
            break;
          case "titleCard":
            item = TitleCardItem(source: entity);
            break;
          case "imageSquareScrollCard":
            item = ImageSquareScrollCardItem(source: entity);
            break;
          case "imageScaleCard":
            item = ImageScaleCardItem(source: entity);
            break;
          case "iconLinkGridCard":
            item = IconLinkGridCard(source: entity);
            break;
          case "imageCarouselCard_1":
            item = ImageCarouselCard(source: entity);
            break;
          // case "textTitleScrollCard":
          //   item = TextTitleScrollCardItem(source: entity);
          //   break;
          case "selectorLinkCard":
            item = const SizedBox();
            break;
        }
        break;
      case "feed":
        switch (template) {
          case "feed":
            item = FeedItem(
              source: entity,
              requireDelete: onRequireDeleteItem,
            );
            break;
          case "feedCover":
            item = FeedItem(
              source: entity,
              requireDelete: onRequireDeleteItem,
            );
            break;
        }
        break;
      case "liveTopic":
        item = LiveTopicItem(source: entity);
        break;
      case "topic":
        item = TopicCardItem(source: entity);
        break;
      case "product":
        item = ProductItem(source: entity);
        break;
    }
    item = item ??
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "\ntitle:${entity["title"]}\ntype:${entity["type"]}\nentityType:${entity["entityType"]}\ntemplate:${entity["entityTemplate"] ?? "null"}",
              ),
              PrimaryButton(
                text: "源",
                onPressed: () {
                  final json = JsonEncoder.withIndent("  ").convert(entity);
                  Navigator.of(context).push(ScaleInRoute(
                      widget: Scaffold(
                    appBar: AppBar(
                      title: Text("源"),
                    ),
                    body: TextField(
                      scrollPadding: const EdgeInsets.all(8),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: json),
                      ),
                      maxLines: 100,
                    ),
                  )));
                },
              ),
            ],
          ),
        );

    return (sliverMode) ? SliverToBoxAdapter(child: item) : item;
  }
}
