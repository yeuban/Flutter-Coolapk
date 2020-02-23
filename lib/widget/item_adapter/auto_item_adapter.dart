import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:flutter/material.dart';

class AutoItemAdapter extends StatelessWidget {
  final entity;
  final sliverMode;
  const AutoItemAdapter({Key key, this.entity, this.sliverMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final template = entity["entityTemplate"];
    final type = entity["entityType"];

    Widget item;

    switch (type) {
      case "card":
        switch (template) {
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
    }
    item = item ??
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          child: Text(entity["entityTemplate"] ?? "null"),
        );

    return sliverMode ? SliverToBoxAdapter(child: item) : item;
  }
}
