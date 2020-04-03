part of 'feed_detail.page.dart';

class ReplyItem extends StatefulWidget {
  final Function(int uid, int cid) onClick;
  final ReplyDataEntity data;
  const ReplyItem({Key key, @required this.data, this.onClick})
      : super(key: key);

  @override
  _ReplyItemState createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  addReplyRow(ReplyDataEntity row) {
    if (widget.data.replyRows == null) widget.data.replyRows = [];
    widget.data.replyRows.add(InReplyRowEntity.fromJson(row.toJson()));
    setState(() {});
  }

  onReplyClick(final BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ReplyInputBottomSheet(
        targetId: widget.data.id,
        onReplyDone: (_data) {
          addReplyRow(_data);
          Navigator.pop(context);
        },
        hintText: widget.data.username,
        type: ReplyInputType.reply,
      ),
    );
  }

  onShowMoreReplyClick(final BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: false,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Center(
            child: Scaffold(
              appBar: AppBar(
                elevation: 1,
                backgroundColor: Theme.of(context).cardColor,
                textTheme: Theme.of(context).textTheme,
                iconTheme: Theme.of(context).iconTheme,
                title: Text("${widget.data.username}: 更多回复"),
              ),
              body: LimitedContainer(
                child: FeedReplyList(
                  widget.data.entityId,
                  discussMode: false,
                  feedType: FeedType.feed_reply,
                ),
              ),
            ),
          ); // 这里用reply的entityId即可
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onReplyClick(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExtendedImage.network(
                widget.data.userInfo.userSmallAvatar,
                width: 42,
                height: 42,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
                child: _buildContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              widget.data.username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                // fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.button.fontSize + 2,
              ),
            ),
            widget.data.isFeedAuthor == 1 ? FeedAuthorTag() : const SizedBox(),
          ],
        ),
        Divider(color: Colors.transparent, height: 4),
        HtmlText(
          html: widget.data.message,
          shrinkToFit: true,
          defaultTextStyle: Theme.of(context).textTheme.bodyText1,
        ),
        (widget.data.pic?.length ?? 0) > 3
            ? _buildPic(context)
            : const SizedBox(),
        Divider(color: Colors.transparent, height: 4),
        Row(
          children: <Widget>[
            // TODO: time and thumbup
          ],
        ),
        widget.data.replynum == 0 || widget.data.replyRows == null
            ? const SizedBox()
            : _buildInReplyColumn(context),
      ],
    );
  }

  Widget _buildPic(final BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO:
        Navigator.of(context).push(ScaleInRoute(
            widget: ImageBox(
          url: widget.data.pic,
          heroTag: widget.data.pic,
        )));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        constraints: BoxConstraints(maxHeight: 300),
        child: AspectRatio(
          aspectRatio: getImageRatio(widget.data.pic),
          child: Hero(
            tag: widget.data.pic,
            child: ExtendedImage.network(widget.data.pic),
          ),
        ),
      ),
    );
  }

  Widget _buildInReplyColumn(final BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.data.replyRows
            .map<Widget>((row) => InReplyItem(
                  row,
                  onNewReply: addReplyRow,
                ))
            .toList()
              ..addAll(
                _buildShowMore(context),
              ),
      ),
    );
  }

  List<Widget> _buildShowMore(final BuildContext context) {
    return widget.data.replyRowsMore > widget.data.replyRowsCount
        ? [
            InkWell(
              onTap: () => onShowMoreReplyClick(context),
              child: Text(
                "显示更多",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ]
        : [];
  }
}

class InReplyItem extends StatelessWidget {
  final InReplyRowEntity data;
  final Function(ReplyDataEntity data) onNewReply;
  const InReplyItem(this.data, {Key key, @required this.onNewReply})
      : super(key: key);

  showReplyInput(final BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => ReplyInputBottomSheet(
              targetId: data.rrid,
              hintText: data.username,
              type: ReplyInputType.reply,
              onReplyDone: (row) {
                onNewReply(row);
                Navigator.pop(context);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showReplyInput(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2),
        child: HtmlText(
          onLinkTap: (url) {
            // TODO: handle to user space
          },
          html:
              "<a href='${data.uid}' style='color: #${Theme.of(context).primaryColor.value.toRadixString(16)}'>${data.username}${data.isFeedAuthor == 1 ? " [楼主]" : ""}: </a>${data.message}",
          shrinkToFit: true,
        ),
      ),
    );
  }
}
