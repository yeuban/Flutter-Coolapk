part of './feed.item.dart';

class FeedType0Content extends StatelessWidget {
  final dynamic source;
  const FeedType0Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HtmlText(
            html: source["message"],
            shrinkToFit: true,
          ),
          buildIfImageBox(source, context),
        ],
      ),
    );
  }
}
