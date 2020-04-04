part of 'feed_detail.page.dart';

enum ReplyInputType {
  feed,
  reply, // 回复某个回复
}

class ReplyInputBottomSheet extends StatefulWidget {
  final dynamic targetId; //  reply's id or feedid ,rrid
  final String hintText;
  final ReplyInputType type;
  final Function(ReplyDataEntity data) onReplyDone;
  const ReplyInputBottomSheet({
    Key key,
    @required this.targetId,
    this.hintText,
    this.onReplyDone,
    this.type = ReplyInputType.feed,
  }) : super(key: key);

  @override
  _ReplyInputBottomSheetState createState() => _ReplyInputBottomSheetState();
}

class _ReplyInputBottomSheetState extends State<ReplyInputBottomSheet> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  bool _doing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTextTabBarHeight + 26,
      padding: const EdgeInsets.all(8),
      child: LimitedContainer(
        child: TextField(
          autofocus: false,
          controller: _textEditingController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(6),
              hintText: "回复: ${widget.targetId} ${widget.hintText}",
              suffix: IconButton(
                icon: Icon(Icons.send),
                onPressed: _doing
                    ? null
                    : () async {
                        _doing = true;
                        setState(() {});
                        try {
                          final resp = await MainApi.reply(
                              widget.targetId, _textEditingController.text);
                          if (resp["data"] != null) {
                            if (widget.onReplyDone != null)
                              widget.onReplyDone(
                                  ReplyDataEntity.fromJson(resp["data"]));
                          } else {
                            throw Exception(resp["message"] ?? "发送失败");
                          }
                        } catch (err) {
                          Toast.show(err.toString(), context, duration: 2);
                        } finally {
                          _doing = false;
                          setState(() {});
                        }
                      },
              )),
        ),
      ),
    );
  }
}
