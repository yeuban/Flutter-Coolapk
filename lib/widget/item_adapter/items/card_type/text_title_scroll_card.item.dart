import 'package:carousel_slider/carousel_slider.dart';
import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TextTitleScrollCardItem extends StatelessWidget {
  final dynamic source;

  const TextTitleScrollCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // url
    // title
    // pic
    // entities
    //  entityType textTitle
    //  title
    //  url
    //  pic
    //  subTitle
    if (source["entities"].length == 0 ||
        source["entities"][0]["pic"].length < 3 ||
        source["title"].toString().contains("值得买")) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 2),
          child: Text("${source["title"]}",
              style: Theme.of(context).textTheme.headline6),
        ),
        Container(
          constraints: BoxConstraints(maxHeight: 200),
          width: double.infinity,
          child: MCard(
            child: CarouselSlider(
              aspectRatio: getImageRatio(source["entities"][0]["pic"]),
              items: source["entities"].map<Widget>((entity) {
                return ExtendedImage.network(entity["pic"]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
