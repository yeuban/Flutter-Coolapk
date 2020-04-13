part of './feed.item.dart';

/// source["replynum"]
/// source["likenum"]
class FeedItemFooter extends StatelessWidget {
  final dynamic source;
  FeedItemFooter(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ThumbUpButton(
          feedID: source["entityId"],
          initThumbNum: 10,
          initThumbState: source["userAction"] != null
              ? source["userAction"]["like"] == 1
              : false,
        ),
        _buildItem(
          context,
          "assets/images/coolapk/ic_comment_outline_white_24dp.png",
          str: source["replynum"].toString(),
        ),
        _buildItem(
          context,
          "assets/images/coolapk/ic_share_outline_white_24dp.png",
          str: source["share_num"].toString(),
        ),
      ],
    );
  }
}

Widget _buildItem(final BuildContext context, final String iconAssets,
    {final String str}) {
  return FlatButton.icon(
    onPressed: () {},
    icon: ExtendedImage.asset(
      iconAssets,
      width: 21,
      height: 21,
      filterQuality: FilterQuality.medium,
      color: Theme.of(context).iconTheme.color,
    ),
    label: Text(str),
  );
}
