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
            onLinkTap: (url) {
              handleOnLinkTap(url, context, onEmptyUrl: () {
                Navigator.of(context).push(ScaleInRoute(
                    widget: FeedDetailPage(
                  url: source["url"],
                )));
              });
            },
          ),
          buildIfImageBox(source, context),
        ],
      ),
    );
  }
}
