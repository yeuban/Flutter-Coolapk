part of './data_list.dart';

class DataListInner extends StatefulWidget {
  final dynamic data;
  final double paddingTop;
  final bool enableRefresh;
  DataListInner(
      {Key key, this.data, this.paddingTop, this.enableRefresh = true}) 
      : super(key: key);


  @override
  DataListInnerState createState() => DataListInnerState();
}

class DataListInnerState extends State<DataListInner> {
  DataListConfig _dataListConfig;

  @override
  void initState() {
    super.initState();
    _dataListConfig = DataListConfig(
      sourceConfig: widget.data,
      needFirstItem: false,
    );
  }

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  double get paddingTop => widget.paddingTop;

  void _checkAndNextPage() {
    final config = _dataListConfig;
    if (config.hasMore && !config.loading && !config.loadingMore) {
      config.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.enableRefresh
        ? RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _dataListConfig?.refresh,
            child: Builder(
              builder: (context) => Consumer<DataListConfig>(
                  builder: (context, final config, final child) {
                if (!config.inited) {
                  _refreshIndicatorKey?.currentState?.show();
                }
                if (config.data.length == 0 && !config.loading) {
                  return Center(
                    child: Text(
                      "这里没有内容~",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
                return CustomScrollView(
                  slivers: []
                    ..addAll(_buildItems(config))
                    ..addAll(_buildLoadingWidget(config))
                    ..add(_buildLoadMoreWidget()),
                );
              }),
            ),
          )
        : Consumer<DataListConfig>(
            builder: (context, final config, final child) {
            if (!config.inited && !config.loading) {
              Future.delayed(Duration(milliseconds: 100)).then((_) {
                config.refresh();
              });
            }
            if (config.data.length == 0 && !config.loading) {
              return Center(
                child: Text(
                  "这里没有内容~",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              );
            }
            return CustomScrollView(
              slivers: []
                ..addAll(_buildItems(config))
                ..addAll(_buildLoadingWidget(config))
                ..add(_buildLoadMoreWidget()),
            );
          });
    return ChangeNotifierProvider.value(
      value: _dataListConfig,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop ?? 0),
        child: child,
      ),
    );
  }

  Widget _buildLoadMoreWidget() {
    return SliverToBoxAdapter(
      child: OutlineButton(
        child: Text("加载更多"),
        onPressed: () => _checkAndNextPage(),
      ),
    );
  }

  List<Widget> _buildItems(final config) {
    return config.data.map<Widget>((entity) {
      return AutoItemAdapter(
        entity: entity,
        sliverMode: true,
      );
    }).toList();
  }

  List<Widget> _buildLoadingWidget(final config) {
    return config.loadingMore
        ? [
            SliverToBoxAdapter(
              child: Material(
                elevation: 16,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Text("加载中..."),
                ),
              ),
            )
          ]
        : [];
  }
}
