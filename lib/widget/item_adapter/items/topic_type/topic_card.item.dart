import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TopicCardItem extends StatelessWidget {
  final Map<String, dynamic> source;
  const TopicCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: ExtendedImage.network(
          source["logo"],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          width: 44,
          height: 44,
        ),
        title: Text(source["title"] ?? ""),
        subtitle: Text(
            "${source["hot_num"]}热度  ${source["commentnum"]}讨论  ${source["follownum"]}关注"),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
      ),
    );
  }
}
