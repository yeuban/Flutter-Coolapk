part of './feed.item.dart';

class FeedType12Content extends StatelessWidget {
  final dynamic source;
  const FeedType12Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            source["message_title"],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          buildIfImageBox(source, context),
          HtmlText(
            html: source["message"],
            shrinkToFit: true,
          ),
        ],
      ),
    );
  }
}
