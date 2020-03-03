part of './feed.item.dart';

class FeedType4Content extends StatelessWidget {
  final dynamic source;
  const FeedType4Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(top: 8, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            source["message"],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                source["extra_pic"].length == 0
                    ? ExtendedImage.asset(
                        "assets/images/logo_256.png",
                        filterQuality: FilterQuality.low,
                        width: 45,
                        height: 45,
                        color: Theme.of(context).primaryColor,
                      )
                    : ExtendedImage.network(
                        source["extra_pic"],
                        cache: Platform.isAndroid || Platform.isIOS,
                        width: 45,
                        height: 45,
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                      ),
                const VerticalDivider(
                  color: Colors.transparent,
                  width: 8,
                ),
                Expanded(
                  child: HtmlText(
                    html: source["extra_title"],
                    shrinkToFit: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
