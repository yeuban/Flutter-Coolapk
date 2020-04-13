part of './feed.item.dart';

class FeedType16Content extends StatefulWidget {
  final dynamic source;
  const FeedType16Content(this.source, {Key key}) : super(key: key);

  @override
  _FeedType16ContentState createState() => _FeedType16ContentState();
}

class _Option {
  int id;
  int vote_id;
  String title;
  int status;
  int order;
  String color;
  int totalSelectNum;
  bool selected = false;
  _Option(
      {this.id,
      this.vote_id,
      this.title,
      this.status,
      this.order,
      this.color,
      this.totalSelectNum});
}

class _FeedType16ContentState extends State<FeedType16Content> {
  bool _anonymous = false;
  List<_Option> _options = [];

  bool _voted = false;

  int get maxSelectNum => widget.source["vote"]["max_select_num"];
  int get minSelectNum => widget.source["vote"]["min_select_num"];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        setup(widget.source["vote"]["options"]);
      });
    });
    super.initState();
  }

  setup(sourceOptions) {
    widget.source["vote"]["options"].every((opt) {
      this._options.add(_Option(
            id: opt["id"],
            vote_id: opt["vote_id"],
            title: opt["title"],
            status: opt["status"],
            order: opt["order"],
            color: opt["color"],
            totalSelectNum: opt["total_select_num"] ?? null,
          ));
      return true;
    });
    _voted = this._options.any((opt) => opt.totalSelectNum != null);
  }

  vote() async {
    final selectedOpts = this._options.where((opt) => opt.selected);
    if (selectedOpts.length > maxSelectNum) {
      Toast.show("最多选择${maxSelectNum}个", context, duration: 2);
      return;
    } else if (selectedOpts.length < minSelectNum) {
      Toast.show("最少选择${maxSelectNum}个", context, duration: 2);
      return;
    }
    final resp = await FeedApi.vote(
        voteID: widget.source["vote"]["id"],
        selectOption: selectedOpts.map<int>((opt) => opt.id).toList(),
        anonymous: this._anonymous);
    if (resp["message"] != null) {
      Toast.show(resp["message"], context, duration: 2);
      return;
    }
    setState(() {
      setup(resp["data"]["options"]);
    });
    Toast.show("投票成功", context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleRow(context),
          _buildMessageContent(context),
          Divider(color: Colors.transparent),
          Row(
            children: [
              Text(
                "投票选项",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Spacer(),
              Text(
                  maxSelectNum == minSelectNum
                      ? "最多选择1项"
                      : "最多选择${maxSelectNum}项 最少选择${maxSelectNum}项",
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
          Divider(
            color: Colors.transparent,
            height: 4,
          ),
          _builVoteColumn(context),
          _buildInfoRow(context),
          _voted
              ? const SizedBox()
              : RaisedButton(
                  disabledColor: Theme.of(context).dividerColor.withAlpha(40),
                  disabledTextColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  child: Container(
                    child: Text("投票"),
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.bodyText1.color,
                  onPressed: this._options.any((opt) {
                    return opt.selected;
                  })
                      ? vote
                      : null,
                ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(final BuildContext context) {
    final vote = widget.source["vote"];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${vote["total_vote_num"]}人投票 · ${vote["total_comment_num"]}个观点"),
        Spacer(),
        Text("匿名投票"),
        Checkbox(
          value: _anonymous,
          onChanged: (value) {
            this._anonymous = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _builVoteColumn(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _options.map<Widget>((opt) {
        _toggle(value) {
          if (value &&
              this._options.where((opt) => opt.selected).length >=
                  maxSelectNum) {
            Toast.show("最多选择${maxSelectNum}个", context, duration: 2);
            return;
          }
          opt.selected = value;
          setState(() {});
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor.withAlpha(30),
              ),
              borderRadius: BorderRadius.circular(4),
              shape: BoxShape.rectangle),
          child: _voted
              ? ListTile(
                  dense: true,
                  title: Text(opt.title),
                  trailing: Text(
                    opt.totalSelectNum.toString(),
                  ),
                )
              : CheckboxListTile(
                  dense: true,
                  title: Text(opt.title),
                  value: opt.selected,
                  onChanged: _toggle,
                ),
        );
      }).toList(),
    );
  }

  Widget _buildMessageContent(final BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: HtmlText(
        html: widget.source["message"],
        defaultTextStyle: const TextStyle(
          fontSize: 16,
        ),
        shrinkToFit: true,
      ),
    );
  }

  Widget _buildTitleRow(final BuildContext context) {
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
              widget.source["feedTypeName"],
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.source["message_title"],
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
