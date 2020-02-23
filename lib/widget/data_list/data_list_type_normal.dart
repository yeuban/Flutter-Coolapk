part of './data_list.dart';

class DataListTypeNormal extends StatefulWidget {
  DataListTypeNormal({Key key}) : super(key: key);

  @override
  _DataListTypeNormalState createState() => _DataListTypeNormalState();
}

class _DataListTypeNormalState extends State<DataListTypeNormal> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _checkAndNextPage(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _checkAndNextPage(final BuildContext context) {
    final config = Provider.of<DataListConfig>(context, listen: false);
    if (config.hasMore &&
        !config.loading &&
        !config.loadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
      config.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh:
              Provider.of<DataListConfig>(context, listen: false).refresh,
          child: Selector<DataListConfig, List<dynamic>>(
            selector: (_, config) => config.data,
            builder: (context, final data, final child) {
              if (!Provider.of<DataListConfig>(context).inited) {
                _refreshIndicatorKey?.currentState?.show();
              }
              if (data.length == 0) {
                return Center(
                  child: Text(
                    "这里没有内容~",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              return GestureDetector(
                onVerticalDragStart: (details) => _checkAndNextPage(context),
                child: CustomScrollView(
                    controller: _scrollController,
                    slivers: data.map<Widget>((entity) {
                      return AutoItemAdapter(
                        entity: entity,
                        sliverMode: true,
                      );
                    }).toList()),
              );
            },
          ),
        )
      ]..addAll(Provider.of<DataListConfig>(context, listen: false).loadingMore
          ? [buildLoadingWidgetInStack()]
          : []),
    );
  }
}
