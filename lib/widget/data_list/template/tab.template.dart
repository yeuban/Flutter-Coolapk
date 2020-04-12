part of './template.dart';

class TabTemplate extends StatefulWidget {
  TabTemplate({Key key}) : super(key: key);

  @override
  _TabTemplateState createState() => _TabTemplateState();
}

class _TabTemplateState extends State<TabTemplate>
    with TickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<NestedScrollViewState> _nestedScrollViewState = GlobalKey();
  ScrollController get _innerScrollController =>
      _nestedScrollViewState.currentState.innerController;
  int _nowSelect = 0;

  List<DataListConfig> _subConfigs;
  DataListConfig get _nowSelectConfig => _subConfigs[_nowSelect];

  @override
  void initState() {
    super.initState();
    final config = Provider.of<DataListConfig>(context, listen: false);
    _tabController = TabController(
      vsync: this,
      length: config.lastOne["entities"].length,
    );
    _subConfigs = [];
    (config.lastOne["entities"] as List<dynamic>).forEach((element) {
      _subConfigs
          .add(DataListConfig(title: element["title"], url: element["url"]));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _innerScrollControllerListener() {
    final nowSelectConfig = _subConfigs[_nowSelect];
    if (_innerScrollController.position.pixels >=
        (_innerScrollController.position.maxScrollExtent - 200)) {
      if (nowSelectConfig.state != DataListConfigState.NoMore &&
          nowSelectConfig.state != DataListConfigState.Loading &&
          nowSelectConfig.state != DataListConfigState.Firstime) {
        nowSelectConfig.nextPage;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataListConfig>(
      builder: (final context, final config, final _) {
        return NestedScrollView(
          key: _nestedScrollViewState,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [_buildHeaderSlivers(config)]
              ..add(_buildTabBar(context, config));
          },
          body: Builder(
            builder: (context) {
              _innerScrollController
                  .removeListener(_innerScrollControllerListener);
              _innerScrollController
                  .addListener(_innerScrollControllerListener);
              return NestedScrollViewViewport(
                offset: ViewportOffset.zero(),
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: ChangeNotifierProvider.value(
                      value: _nowSelectConfig,
                      child: SubTab(),
                    ),
                  )
                ],
              );
            },
          ),
          // body:
        );
      },
    );
  }

  Widget _buildHeaderSlivers(final DataListConfig config) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => AutoItemAdapter(
          entity: config.dataList[index],
          sliverMode: false,
          onRequireDeleteItem: (entity) {
            config.dataList.removeWhere(
                (element) => element["entityId"] == entity["entityId"]);
            config.notifyChanged;
          },
        ),
        childCount: config.dataList.length,
      ),
    );
  }

  Widget _buildTabBar(final BuildContext context, final DataListConfig config) {
    final tabConfigEntity = config.lastOne;
    return SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: SliverPersistentHeaderDelegateImpl(
          child: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    _nowSelect = value;
                  });
                },
                isScrollable: true,
                indicatorPadding: const EdgeInsets.all(0),
                unselectedLabelColor:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(100),
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(44),
                  color: Theme.of(context).primaryColor,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                controller: _tabController,
                tabs: tabConfigEntity["entities"].map<Widget>((entity) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Tab(
                      text: entity["title"],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}

class SubTab extends StatefulWidget {
  const SubTab({Key key}) : super(key: key);

  @override
  _SubTabState createState() => _SubTabState();
}

class _SubTabState extends State<SubTab>
    with LoadMoreMixinState<SubTab>, AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (Provider.of<DataListConfig>(context, listen: false).state ==
        DataListConfigState.Firstime) {
      Future.delayed(Duration(milliseconds: 1))
          .then((value) => _refreshIndicatorKey.currentState.show());
    }
    return Consumer<DataListConfig>(
      builder: (context, config, _) => RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await config.refresh;
        },
        child: ListView.builder(
          itemBuilder: (context, index) =>
              config.buildItems(index: index, sliverMode: false),
          itemCount: config.dataList.length,
          shrinkWrap: true,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
