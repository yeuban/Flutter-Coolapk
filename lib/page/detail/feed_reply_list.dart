part of 'feed_detail.page.dart';

class FeedReplyList extends StatefulWidget {
  final dynamic feedId;
  final bool discussMode;
  final FeedType feedType;
  const FeedReplyList(this.feedId,
      {Key key, this.feedType = FeedType.feed, this.discussMode = true})
      : super(key: key);

  @override
  _FeedReplyListState createState() => _FeedReplyListState();
}

class _FeedReplyListState extends State<FeedReplyList> {
  List<ReplyDataEntity> _data;
  EasyRefreshController _easyRefreshController;
  int _page = 1;
  bool _nomore = false;

  ReplyDataListType sortType = ReplyDataListType.lastupdate_desc;

  int get firstItem {
    if (_data == null) return null;
    if (_data.length == 0) return null;
    return _data
        .firstWhere((entity) => (entity.entityId?.toString()?.length ?? 0) >= 4)
        ?.entityId;
  }

  int get lastItem {
    if (_data == null) return null;
    if (_data.length == 0) return null;
    return _data
        .lastWhere((entity) => (entity.entityId?.toString()?.length ?? 0) >= 4)
        ?.entityId;
  }

  addReplyRow(ReplyDataEntity entity) {
    if (_data == null) _data = [];
    _data.insert(0, entity);
    setState(() {});
  }

  Future<bool> fetchData() async {
    final resp = await MainApi.getFeedReplyList(
      widget.feedId,
      page: _page,
      firstItem: firstItem,
      lastItem: lastItem,
      feedType: widget.feedType,
      discussMode: widget.discussMode ? 1 : 0,
      sortType: widget.discussMode ? sortType : null,
    );
    if (_data == null) {
      _data = resp.data;
    } else {
      _data.addAll(resp.data);
    }
    if (resp.data.length == 0) {
      _nomore = true;
    }
    setState(() {});
    return true;
  }

  @override
  void initState() {
    _easyRefreshController = EasyRefreshController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _easyRefreshController.callRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: PhoenixHeader(),
      controller: _easyRefreshController,
      footer: BallPulseFooter(),
      onLoad: () async {
        if (_nomore) {
          _easyRefreshController.finishLoad();
          return;
        }
        _page++;
        await fetchData();
        _easyRefreshController.finishLoad();
      },
      onRefresh: () async {
        _page = 1;
        _data?.clear();
        _nomore = false;
        await fetchData();
        _easyRefreshController.finishRefresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          if (index == _data.length) {
            return FlatButton(
              child: Text(
                "没有更多了，点击刷新",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                _easyRefreshController.callRefresh();
              },
            );
          }
          return ReplyItem(
            data: _data[index],
            onClick: (uid, cid) {},
          );
        },
        shrinkWrap: true,
        itemCount: (_data?.length ?? 0) + (_nomore ? 1 : 0),
      ),
    );
  }
}
