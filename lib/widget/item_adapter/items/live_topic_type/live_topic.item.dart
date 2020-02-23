part of 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
class LiveTopicItem extends StatelessWidget {
  final Map<String, dynamic> source;
  const LiveTopicItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius4 = const Radius.circular(4);
    var liveState = source["live_status"]; // -1 结束； 0 未开始； 1 直播中
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        elevation: 4,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AspectRatio(
              aspectRatio: getImageRatio(source["pic_url"]),
              child: ExtendedImage.network(
                source["pic_url"],
                shape: BoxShape.rectangle,
                cache: false, // TODO:
                borderRadius:
                    BorderRadius.only(topLeft: radius4, topRight: radius4),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    source["title"],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "${source["description"]}",
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Chip(
                        backgroundColor: liveState == 0
                            ? Colors.blueAccent
                            : liveState == 1 ? Colors.greenAccent : Colors.grey,
                        labelStyle: const TextStyle(color: Colors.white),
                        label: Text(
                          liveState == 0
                              ? "未开始"
                              : liveState == 1 ? "直播中" : "已结束",
                        ),
                      ),
                      VerticalDivider(),
                      Text("${source["visit_num"]?.toString()}人气"),
                      VerticalDivider(),
                      Expanded(
                        child: Text(
                          liveState == 0
                              ? "直播时间：${source["show_live_time"]} ${source["follow_num"]}人已预约"
                              : "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
