part of './feed.item.dart';

class FeedType11Content extends StatelessWidget {
  final dynamic source;
  const FeedType11Content(this.source, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // source["feedType"] == answer
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildQuestionRow(context),
          _buildAnswerContent(),
          buildIfImageBox(source, context),
        ],
      ),
    );
  }

  Widget _buildAnswerContent() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: HtmlText(
        html: source["message"],
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        shrinkToFit: true,
      ),
    );
  }

  Widget _buildQuestionRow(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              shape: BoxShape.rectangle,
              color: Theme.of(context).accentColor,
            ),
            child: Text(
              source["feedTypeName"],
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              source["message_title"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
