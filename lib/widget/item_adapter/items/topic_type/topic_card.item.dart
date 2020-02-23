part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';

class TopicCardItem extends StatelessWidget {
  final Map<String, dynamic> source;
  const TopicCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: ExtendedImage.network(
          source["logo"],
          cache: false, // TODO:
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
