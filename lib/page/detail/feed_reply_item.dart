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
        onLongPress: () {
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return SimpleDialog(
          //       children: [
          //         TextField(
          //           controller:
          //               TextEditingController(text: widget.data.toString()),
          //           autocorrect: true,
          //           minLines: 1,
          //           maxLines: 100000,
          //         )
          //       ],
          //     );
          //   },
          // );
        },
        onTap: () => onReplyClick(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => UserSpacePage.entry(context, widget.data.uid),
                child: ExtendedImage.network(
                  widget.data.userInfo.userSmallAvatar,
                  width: 42,
                  height: 42,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 0),
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
            GestureDetector(
              onTap: () => UserSpacePage.entry(context, widget.data.uid),
              child: Text(
                widget.data.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  // fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.button.fontSize + 2,
                ),
              ),
            ),
            widget.data.isFeedAuthor == 1 ? FeedAuthorTag() : const SizedBox(),
            Spacer(),
          ],
        ),
        Divider(color: Colors.transparent, height: 4),
        HtmlText(
          html: widget.data.message,
          shrinkToFit: true,
          onLinkTap: (url) => handleOnLinkTap(url, context),
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
        Align(
          alignment: Alignment.centerRight,
          child: ThumbUpButton(
            feedID: widget.data.id,
            initThumbNum: widget.data.likenum,
            initThumbState:
                ((widget.data.userAction?.like ?? 0) == 1 ? true : false),
            isReply: true,
          ),
        ),
        Divider(
          height: 2,
        ),
      ],
    );
  }

  Widget _buildPic(final BuildContext context) {
    return InkWell(
      onTap: () {
        ImageBox.push(context, urls: [widget.data.pic]);
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
      margin: const EdgeInsets.only(top: 8, bottom: 0),
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
            Divider(height: 4),
            InkWell(
              onTap: () => onShowMoreReplyClick(context),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 2),
                  child: Text(
                    "——显示更多(${widget.data.replyRowsCount})——",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
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
    final accentColor16 = Theme.of(context).accentColor.value.toRadixString(16);
    final textColor16 =
        Theme.of(context).textTheme.bodyText1.color.value.toRadixString(16);
    final _picTag = (data.pic.isNotEmpty
        ? "<a href='pic=${data.pic}'" +
            " style='color: #${Theme.of(context).accentColor.value.toRadixString(16)}'>" +
            "[查看图片]</a" ">" // 是否有图片
        : "");
    return InkWell(
      onTap: () => showReplyInput(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2),
        child: Container(
          width: double.infinity,
          child: HtmlText(
            onLinkTap: (url) {
              // TODO: handle to user space
              handleOnLinkTap(url, context);
            },
            html: "<a href='user=${data.uid}' style='color: #$accentColor16'>" +
                "${data.isFeedAuthor == 1 ? "[楼主]${data.username}" : data.username}</a>" + // 谁
                (data.rusername.isNotEmpty ? " 回复 " : "") + // 回复
                "<a href='user=${data.ruid}' style='color: #$accentColor16'>${data.rusername}</a>" // 谁
                    ": ${data.message == "[图片]" ? _picTag : data.message + _picTag}",
            shrinkToFit: true,
          ),
        ),
      ),
    );
  }
}
