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
        FeedItemFooterThumbup(source),
        _buildItem(context, Icons.comment, str: source["replynum"].toString()),
        _buildItem(context, Icons.share),
      ],
    );
  }
}

class FeedItemFooterThumbup extends StatefulWidget {
  final dynamic source;
  FeedItemFooterThumbup(this.source, {Key key}) : super(key: key);

  @override
  _FeedItemFooterThumbupState createState() => _FeedItemFooterThumbupState();
}

class _FeedItemFooterThumbupState extends State<FeedItemFooterThumbup> {
  dynamic get source => widget.source;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyText1.color.withAlpha(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 17,
                color:
                    Theme.of(context).textTheme.bodyText1.color.withAlpha(100),
              ),
              const VerticalDivider(
                color: Colors.transparent,
                width: 4,
              ),
              Text(source["likenum"].toString()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildItem(final BuildContext context, final IconData icon,
    {final String str}) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).textTheme.bodyText1.color.withAlpha(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 19,
              color: Theme.of(context).textTheme.bodyText1.color.withAlpha(100),
            ),
          ]..addAll(str != null
              ? [
                  const VerticalDivider(
                    color: Colors.transparent,
                    width: 4,
                  ),
                  Text(str)
                ]
              : []),
        ),
      ),
    ),
  );
}
