part of 'feed.item.dart';

class FeedType10Content extends StatelessWidget {
  final dynamic source;

  FeedType10Content(this.source);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuestionRow(context),
          _buildContent(context),
          Divider(color: Colors.transparent),
          _buildInfoRow(context),
        ],
      ),
    );
  }

  Widget _buildContent(final BuildContext context) {
    return HtmlText(
      html: source["message"],
        shrinkToFit: true,
    );
  }

  Widget _buildInfoRow(final BuildContext context) {
    return Row(
      children: [
        Text(
            "${source["question_answer_num"]}人回答 · ${source["question_follow_num"]}人关注"),
      ],
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
              color: Theme.of(context).primaryColor,
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
