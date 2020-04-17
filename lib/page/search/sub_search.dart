part of 'search.page.dart';

class SubSearch extends StatefulWidget {
  final String searchValue;
  final SearchType searchType;
  final GlobalKey<_SubSearchState> key;
  SubSearch({this.key, @required this.searchValue, @required this.searchType})
      : super(key: key);

  @override
  _SubSearchState createState() => _SubSearchState();
}

class _SubSearchState extends State<SubSearch>
    with AutomaticKeepAliveClientMixin {
  bool _loading = false;
  bool _refreshing = false;
  dynamic _err;
  int _page = 1;
  bool _nomore = false;
  List<dynamic> _data;

  @override
  void initState() {
    _data = [];
    super.initState();
    fetchData();
  }

  Future<void> fetchData({
    bool nextPage = false,
    bool refresh = true,
  }) async {
    assert(nextPage == true ? refresh == true ? false : true : true);
    if (_loading || _nomore) return;
    if (nextPage) _page++;
    if (refresh) {
      _page = 1;
      _data.clear();
      _refreshing = true;
    }
    setState(() {
      _loading = true;
    });
    try {
      final resp = await MainApi.search(
          searchValue: widget.searchValue,
          searchType: widget.searchType,
          page: _page,
          lastItem:
              _data.length > 0 ? int.parse(_data.last["entityId"]) ?? 0 : null);
      if (resp["data"].length == 0) _nomore = true;
      _data.addAll(resp["data"]);
      _err = null;
    } catch (err, stack) {
      _err = err;
      debugPrintStack(stackTrace: stack);
    } finally {
      setState(() {
        _loading = false;
        _refreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: _data.length,
      itemBuilder: (context, index) {
        const topBorderRadius =
            const BorderRadius.vertical(top: const Radius.circular(8));
        const bottomBorderRadius =
            const BorderRadius.vertical(bottom: const Radius.circular(8));
        final needWhiteBackground = widget.searchType == SearchType.feedTopic ||
            widget.searchType == SearchType.user;
        final needRadius =
            (_data.length > 0 && (index == 0 || index == _data.length - 1)) &&
                needWhiteBackground;
        final radius = index == 0 ? topBorderRadius : bottomBorderRadius;
        return LimitedContainer(
          boxDecoration: BoxDecoration(
            borderRadius: !needRadius ? null : radius,
            color: needWhiteBackground ? Theme.of(context).cardColor : null,
          ),
          child: AutoItemAdapter(
            sliverMode: false,
            addLimitContainer: true,
            limitContainerType: LimiteType.SingleColumn,
            entity: _data[index],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
