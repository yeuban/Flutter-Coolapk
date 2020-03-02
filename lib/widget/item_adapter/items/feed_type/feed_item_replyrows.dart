part of './feed.item.dart';

// 高赞评论...
class FeedItemReplyRows extends StatelessWidget {
  final dynamic source;
  const FeedItemReplyRows(this.source, {Key key}) : super(key: key);
  dynamic get replyRow => source["replyRows"][0];
  @override
  Widget build(BuildContext context) {
    String likenum;
    try {
      likenum = replyRow["likenum"].toString();
    } catch (err) {
      return const SizedBox();
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16).copyWith(top: 8, bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(16)),
              shape: BoxShape.rectangle,
            ),
            padding: const EdgeInsets.all(4).copyWith(right: 8),
            child: Text(
              likenum + "赞",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
                top: 6,
                bottom: replyRow["pic"] != null && replyRow["pic"].length > 0
                    ? 3
                    : 8),
            child: HtmlText(
              // TODO: 需要完善
              html:
                  "<a href=${'"/user/${replyRow["uid"]}"'}>${replyRow["username"] + ": "} </a>" +
                      replyRow["message"],
              shrinkToFit: true,
              defaultTextStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          replyRow["pic"] != null && replyRow["pic"].length > 0
              ? InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                    child: Text(
                      "查看图片",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onTap: () {
                    // TODO: handle this ->
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
