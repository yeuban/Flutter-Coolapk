part of './feed.item.dart';

/// 停用..
class FeedType9Content extends StatelessWidget {
  final dynamic source;
  const FeedType9Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sfeed = source["forwardSourceFeed"];
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HtmlText(
            html: source["message"],
            shrinkToFit: true,
          ),
          const Divider(
            color: Colors.transparent,
            height: 8,
          ),
          sfeed == null ? const SizedBox() : InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              child: HtmlText(
                shrinkToFit: true,
                html: "<a>${sfeed["username"]}: </a>${sfeed["message"]}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
