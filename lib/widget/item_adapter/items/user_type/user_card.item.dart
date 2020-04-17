import 'dart:convert';

import 'package:coolapk_flutter/util/anim_page_route.dart';
import 'package:coolapk_flutter/widget/follow_btn.dart';
import 'package:coolapk_flutter/widget/item_adapter/items/items.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class UserCardItem extends StatelessWidget {
  final dynamic source;
  const UserCardItem({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(source["logintime"]) * 1000);
    final howDaysAgo = (time.difference(DateTime.now()).inDays.abs());
    final howHoursAgo = (time.difference(DateTime.now()).inHours.abs());
    final howMinutesAge = (time.difference(DateTime.now()).inMinutes.abs());
    String titleLeading = "";
    if (howDaysAgo > 30) {
      titleLeading =
          "${time.year < DateTime.now().year ? time.year.toString() + "年" : ""}${time.month}月${time.day}日";
    } else if (howDaysAgo >= 1) {
      titleLeading = "$howDaysAgo天前";
    } else if (howHoursAgo >= 1) {
      titleLeading = "$howHoursAgo小时前";
    } else {
      titleLeading = "$howMinutesAge分钟前";
    }
    return MCard(
      onLongPress: () {
        final json = JsonEncoder.withIndent("  ").convert(source);
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                ExtendedImage.network(source["userSmallAvatar"]).image,
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${source["displayUsername"]}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.headline6.fontSize - 5),
                ),
                Divider(color: Colors.transparent, height: 4),
                Text(
                    "${source["follow"]}关注 ${source["fans"]}粉丝 Lv.${source["level"]} 上次活跃:$titleLeading",
                    style: Theme.of(context).textTheme.caption),
                source["bio"].length > 0
                    ? Divider(color: Colors.transparent, height: 4)
                    : const SizedBox(),
                source["bio"].length > 0
                    ? Text("${source["bio"]}")
                    : const SizedBox(),
              ],
            ),
          ),
          FollowButton(
            initIsFollow: source["isFollow"] == 0 ? false : true,
            uid: source["uid"],
            margin: const EdgeInsets.only(left: 16),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
