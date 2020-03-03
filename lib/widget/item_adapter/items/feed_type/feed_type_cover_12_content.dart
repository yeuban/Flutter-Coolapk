part of './feed.item.dart';

class FeedTypeCover12Content extends StatelessWidget {
  final dynamic source;
  const FeedTypeCover12Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height / 2.5;
    final fmh = (maxHeight < 240 ? 240 : maxHeight > 500 ? 500 : maxHeight);
    final cover = Container(
      constraints: BoxConstraints(maxHeight: fmh.toDouble()),
      padding: const EdgeInsets.all(0).copyWith(top: 8, bottom: 8),
      child: ExtendedImage.network(
        source["message_cover"],
        cache: Platform.isAndroid || Platform.isIOS,
        fit: BoxFit.cover,
        width: double.infinity,
        filterQuality: FilterQuality.low,
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
    );
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
          cover,
          HtmlText(
            html: source["message"],
            shrinkToFit: true,
          ),
          // buildIfImageBox(source, context),
        ],
      ),
    );
  }
}
